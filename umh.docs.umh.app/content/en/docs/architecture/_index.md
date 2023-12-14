---
title: "Architecture"
menuTitle: "Architecture"
description: |
  A comprehensive overview of the United Manufacturing Hub architecture,
  detailing its deployment, management, and data processing capabilities.
weight: 2000
---

<!-- 

To render the SVG, load this up in https://structurizr.com/

-->

<!-- 

workspace {

  model {
    user = person "IT/OT Professional" "Manages and monitors the United Manufacturing Hub."
    otProfessional = person "OT Professional / Shopfloor" "Respinsible for everything on the shopfloor"
    businessAnalyst = person "Business Analyst" "Gets data for analysis from the data warehouse/data lake."
    
    dataWarehouse = softwareSystem "Data Warehouse/Data Lake" "Stores data for analysis, possibly in the cloud." {
        tags "external"
    }
    
    automationPyramid = softwareSystem "Automation Pyramid" "Represents the layered structure of systems in manufacturing operations based on the ISA-95 model."" {
      
      // Level 4: Enterprise Resource Planning (ERP)
      erp = container "ERP" "Enterprise Resource Planning system that provides business and financial functionalities."
      
      // Level 3: Manufacturing Execution System (MES)
      mes = container "MES" "Manufacturing Execution System that manages, monitors, and synchronizes the execution of real-time operations on the plant floor."
      
      // Level 2: Supervisory Control and Data Acquisition (SCADA)
      scada = container "SCADA" "Supervisory Control and Data Acquisition system that provides control and monitoring for industrial processes at the supervisory level." 
      
      // Level 1: Programmable Logic Controllers (PLC)
      plc = container "PLC" "Programmable Logic Controllers that execute control actions based on real-time operational data."
      
      // Level 0: Field-level instrumentation and sensors/actuators
      fieldDevices = container "Field Devices" "Sensors and actuators that interact with the physical process."

      // Define relationships between layers
      erp -> mes "Sends instructions and receives production data"
      mes -> scada "Coordinates and directs control actions"
      scada -> plc "Sends control commands"
      plc -> fieldDevices "Directs field-level operations"
      
      otProfessional -> automationPyramid "working with it (programming, etc.)"
      tags "external"
      
    }

    unitedManufacturingHub = group "United Manufacturing Hub" {
        managementConsole = softwareSystem "Management Console" "..." {
            spa = container "Single-Page Application" "management.umh.app" "Svelte"
            backend = container "Backend" "management.umh.app/api" "Docker, Go"
            companion = container "Management Companion" "..." "Docker, Go"
            keyStorage = container "Key Storage" "Stores and fetches encrypted private keys." "Database"
            redisMgmt = container "Message Queue" "Stores and forwards messages" "Redis"
            
            spa -> backend "Sends/receives E2E encrypted messages, fetches encrypted private key from backend"
            backend -> keyStorage "Fetches encrypted private key"
            backend -> companion "Sends/receives E2E encrypted messages"
            backend -> redisMgmt "Stores and fetches E2E encrypted messages"
            
            user -> spa "Opens management.umh.app, enters his password to decrypt private key, and then manages and monitors the entire infrastructure using the SPA" {
                tags "LowLevel"
            }
            user -> managementConsole "Manages and monitors the entire infrastructure" {
                tags "HighLevel"
            } // let's use this description for high-level views
        }
        deviceInfrastructure = softwareSystem "Device & Container Infrastructure" "Manages the deployment and setup of essential software and operating systems for devices, ensuring an automated and streamlined installation process." {
            installScript = container "Installation Script" "Automated script hosted at management.umh.app/static/automatic/install.sh, responsible for the setup and configuration of the Kubernetes environment." "Bash"
            provisioningServer = container "Provisioning Server" "Manages the initial bootstrapping of devices, including iPXE configuration and ignition files distribution." "matchbox"
            flatcarImageServer = container "Flatcar Image Server" "Central repository for hosting various versions of Flatcar Container Linux images, facilitating easy access and version control." "HTTP Forward to current-2023"
            kubernetes = container "Kubernetes" "Lightweight Kubernetes (k3s) setup that forms the backbone of the container orchestration system." "k3s"
            ipxe = container "Customized iPXE" "A specialized bootloader configured for fetching UMH-specific settings and configurations, streamlining the initial boot process." "iPXE"
            flatcar_0 = container "First Stage Flatcar OS" "Temporary operating system, used solely for the installation of the second-stage Flatcar OS."
            flatcar_1 = container "Second Stage Flatcar OS" "The final operating system on which the infrastructure runs, set up with specific configurations and tools."
        
            ipxe -> provisioningServer "Requests configuration, including user token and serial number, and retrieves iPXE config."
            ipxe -> flatcarImageServer "Downloads the specified Flatcar version for the initial boot (flatcar_0)."
            ipxe -> flatcar_0 "Initiates the boot-up sequence of the first-stage OS."
            flatcar_0 -> provisioningServer "Fetches ignition config containing the installation script for the Flatcar OS."
            flatcar_0 -> flatcar_1 "Installs the second-stage Flatcar OS onto the disk."
            flatcar_0 -> flatcarImageServer "Retrieves the image for the second-stage Flatcar OS."
            flatcar_1 -> provisioningServer "Acquires ignition config with token-specific setup instructions (networking, etc.)."
            flatcar_1 -> installScript "Downloads and executes the installation script."
            flatcar_1 -> flatcarImageServer "Checks regularly for updates" 
        
            installScript -> kubernetes "Installs Kubernetes (k3s) along with all required tools (kubectl, etc.)."
            installScript -> kubernetes "Deploys the Helm Chart for the Data Infrastructure as part of the setup process."
            installScript -> companion "Deploys the Management Companion into the Kubernetes cluster" {
                tags "LowLevel"
            } // no need to show in high-level diagrams
        }

        dataInfrastructure = softwareSystem "Data Infrastructure" "..." {
            unifiedNamespace = container "Unified Namespace" "Serves as the central source of truth for all events and messages on the shop floor." {
                kafka = component "Redpanda (Kafka)" "Handles large-scale data processing and communication between microservices."
                mqtt = component "HiveMQ" "MQTT broker used for receiving data from IoT devices on the shop floor."
                console = component "Redpanda Console" "Provides a graphical view of topics and messages in Kafka."
                databridge = component "databridge" "Bridges messages between MQTT and Kafka as well as between Kafka and other Kafka instances"
                
                mqtt -> databridge
                databridge -> kafka
                kafka -> databridge
                databridge -> mqtt
                console -> kafka
                databridge -> dataWarehouse "Provides data"
            }
            historian = container "Historian" "Stores events in a time-series database and provides visualization tools." {
                kafkaToPostgreSQL = component "kafka-to-postgresql" "Subscribes to _historian.md and _analytics topics and stores it into the database"
                timescaledb = component "TimescaleDB" "An open-source time-series SQL database."
                grafana = component "Grafana" "Visualization and analytics software that allows on-the-fly data analysis."
                factoryinsight = component "factoryinsight" "Analytics software that allows on-the-fly data analysis (e.g., OEE)"
                grafanaDatasource = component "grafana-datasource-v2" "Addon for Grafana that allows easy access to factoryinsight"
                redis = component "Redis" "In-memory data structure store used for caching."
                
                
                kafkaToPostgreSQL -> timescaledb "Stores data"
                kafka -> kafkaToPostgreSQL "Stores data in the schema _historian.md and _analytics"
                grafana -> timescaledb "Querying SQL commands"
                grafana -> grafanaDatasource "included"
                grafanaDatasource -> factoryinsight "fetches KPIs and other high-level metrics"
                factoryinsight -> timescaledb "fetches data"
                
                factoryinsight -> redis "caching"
                kafkaToPostgreSQL -> redis "caching"
                
                otProfessional -> grafana "Accessing real-time dashboards"
            }
            connectivity = container "Connectivity" "Includes tools and services for connecting various shop floor systems and sensors." {
                nodered = component "Node-RED" "A programming tool for wiring together hardware devices, APIs, and online services."
                barcodereader = component "Barcode Reader" "Connects to USB barcode reader devices and pushes data to the message broker."
                sensorconnect = component "Sensor Connect" "Reads out IO-Link Master and their connected sensors, pushing data to the message broker."
                benthosUMH = component "benthos-umh" "Customized version of benthos with an OPC UA plugin"
                
                nodered -> mqtt "Provides contextualized data"
                barcodereader -> kafka "Provides contextualized data"
                sensorconnect -> kafka "Provides contextualized data"
                benthosUMH -> kafka "Provides contextualized data"
                
                benthosUMH -> plc "Extracts data via OPC UA" {
                    tags "LowLevel"
                }
                benthosUMH -> scada "Extracts data via OPC UA" {
                    tags "LowLevel"
                }
                benthosUMH -> mes "Extracts data via REST, SOAP, and many more protocols" {
                    tags "LowLevel"
                }
                benthosUMH -> erp "Extracts data via REST, SOAP, and many more protocols" {
                    tags "LowLevel"
                }
                
                nodered -> plc "Extracts data via S7, and many more protocols" {
                    tags "LowLevel"
                }
                nodered -> mes "Extracts data via REST, SOAP, and many more protocols" {
                    tags "LowLevel"
                }
                nodered -> erp "Extracts data via REST, SOAP, and many more protocols" {
                    tags "LowLevel"
                }
                
                companion -> benthosUMH "Manages and monitors"
            }
            // simulators = container "Simulators" "Includes simulators for generating data during development and testing."
            
            connectivity -> automationPyramid "Provides and extracts data" {
                tags "HighLevel"
            }
            
            dataInfrastructure -> automationPyramid "Provides and extracts data" {
                tags "HighLevel"
            }
            
        }
        dataInfrastructure -> deviceInfrastructure "is installed on"
      }

    // Management Console
    companion -> deviceInfrastructure "Manages & monitors"
    companion -> dataInfrastructure "Manages & monitors"
    
    
    businessAnalyst -> dataWarehouse "Gets data for analysis"
  }

  views {
    systemLandscape {
      include *
      autolayout lr
      exclude "relationship.tag==LowLevel"
    }
    
    
    container "deviceInfrastructure" {
      include *
      autolayout lr
    }
    
    container "managementConsole" {
      include *
      autolayout lr
    }
    
    container "dataInfrastructure" {
      include *
      autolayout lr
      exclude "relationship.tag==LowLevel"
    }
    
    component "unifiedNamespace" {
      include *
      autolayout lr
    }
    
    component "connectivity" {
      include *
      autolayout lr
    }
    
    component "historian" {
      include *
      autolayout lr
    }
    
    styles {
        element "Person" {
            shape person
        }
        element "Software System" {
            background "#AAAAAA"
            stroke "#47A0B5"
            strokeWidth 8
        }
        element "Container" {
            background "#AAAAAA"
            stroke "#47A0B5"
            strokeWidth 8
        }
        element "Component" {
            background "#AAAAAA"
            stroke "#47A0B5"
            strokeWidth 8
        }
        element "Group" {
            color #47A0B5
        }
        element "external" {
            background "#F4F4F4"
            stroke "#F4F4F4"
            strokeWidth 0
        }
    }
    // Other views would be defined here
  }
}


-->

The United Manufacturing Hub is a comprehensive Helm Chart for Kubernetes,
integrating a variety of open source software, including notable third-party
applications such as Node-RED and Grafana. Designed for versatility, UMH is
deployable across a wide spectrum of environments, from edge devices to virtual
machines, and even managed Kubernetes services, catering to diverse industrial
needs.

The following diagram depicts the interaction dynamics between UMH's components
and user types, offering a visual guide to its architecture and operational
mechanisms.

{{< mermaid theme="neutral" >}}
graph LR
  subgraph group1 [United Manufacturing Hub]
    style group1 fill:#ffffff,stroke:#47a0b5,color:#47a0b5,stroke-dasharray:5

    16["`**Management Console**
    Configures, manages, and monitors Data and Device & Container Infrastructures in the UMH Integrated Platform`"]
    style 16 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    27["`**Device & Container Infrastructure**
    Oversees automated, streamlined installation of key software and operating systems`"]
    style 27 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    50["`**Data Infrastructure**
    Integrates every ISA-95 standard layer with the Unified Namespace, adding data sources beyond typical automation pyramid bounds`"]
    style 50 fill:#aaaaaa,stroke:#47a0b5,color:#000000
  end

  1["`fa:fa-user **IT/OT Professional**
  Manages and monitors the United Manufacturing Hub`"]
  style 1 fill:#dddddd,stroke:#9a9a9a,color:#000000
  2["`fa:fa-user **OT Professional / Shopfloor**
  Monitors and manages the shopfloor, including safety, automation and maintenance`"]
  style 2 fill:#dddddd,stroke:#9a9a9a,color:#000000
  3["`fa:fa-user **Business Analyst**
  Gathers and analyzes company data to identify needs and recommend solutions`"]
  style 3 fill:#dddddd,stroke:#9a9a9a,color:#000000
  4["`**Data Warehouse/Data Lake**
  Stores data for analysis, on-premise or in the cloud`"]
  style 4 fill:#f4f4f4,stroke:#f4f4f4,color:#000000
  5["`**Automation Pyramid**
  Represents the layered structure of systems in manufacturing operations based on the ISA-95 model`"]
  style 5 fill:#f4f4f4,stroke:#f4f4f4,color:#000000

  1-. Interacts with the
      entire infrastructure .->16
  16-. Manages & monitors .->27
  16-. Manages & monitors .->50
  2-. Access real-time
      dashboards from .->50
  2-. Works with .->5
  3-. Gets and analyzes data from .->4
  50-. Is installed on .->27
  50-. Provides data to .->4
  50-. Provides to and
       extracts data from .->5
{{</ mermaid >}}

## Management Console

The [Management Console](/docs/architecture/management-console)
of the United Manufacturing Hub is a robust web application designed to configure,
manage, and monitor the various aspects of Data and Device & Container
Infrastructures within UMH. Acting as the central command center, it provides a
comprehensive overview and control over the system's functionalities, ensuring
efficient operation and maintenance. The console simplifies complex processes,
making it accessible for users to oversee the vast array of services and operations
integral to UMH.

## Device & Container Infrastructure

The [Device & Container Infrastructure](/docs/architecture/device-&-container-infrastructure)
lays the foundation of the United Manufacturing Hub's architecture, streamlining
the deployment and setup of essential software and operating systems across devices.
This infrastructure is pivotal in automating the installation process, ensuring
that the essential software components and operating systems are efficiently and
reliably established. It provides the groundwork upon which the Data Infrastructure
is built, embodying a robust and scalable base for the entire architecture.

## Data Infrastructure

The [Data Infrastructure](/docs/architecture/data-infrastructure) is the heart of
the United Manufacturing Hub, orchestrating the interconnection of data sources,
storage, monitoring, and analysis solutions. It comprises three key components:

- **Data Connectivity**: Facilitates the integration of diverse data sources into
  UMH, enabling uninterrupted data exchange.
- **Unified Namespace (UNS)**: Centralizes and standardizes data within UMH into
  a cohesive model, by linking each layer of the ISA-95 automation pyramid to the
  UNS and assimilating non-traditional data sources.
- **Historian**: Stores data in TimescaleDB, a PostgreSQL-based time-series
  database, allowing real-time and historical data analysis through Grafana or
  other tools.

The UMH Data Infrastructure leverages Industrial IoT to expand the ISA95 Automation
Pyramid, enabling high-speed data processing using systems like Kafka. It enhances
system availability through Kubernetes and simplifies maintenance with Docker and
Prometheus. Additionally, it facilitates the use of AI, predictive maintenance,
and digital twin technologies

## Expandability

The United Manufacturing Hub is architecturally designed for high expandability,
enabling integration of custom microservices or Docker containers. This adaptability
allows for users to establish connections with third-party systems or to implement
specialized data analysis tools. The platform also accommodates any third-party
application available as a Helm Chart, Kubernetes resource, or Docker Compose,
offering vast potential for customization to suit evolving industrial demands.
