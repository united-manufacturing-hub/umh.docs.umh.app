+++
title = "HiveMQ"
menuTitle = "HiveMQ"
chapter = false
weight = 6
draft = false
description = "The technical documentation for UMH implementation of the service HiveMQ Community Edition, which is the MQTT broker from 0.9.10 onwards."
+++

We use Hive-MQ community Edition version 2022.1 in our stack, you can build a base version of it separately or install the configured version with our entire stack
through the methods listed in our [Get Started section](/docs/getstarted).

We made some modifications to the configuration, namely adding extensions for better configuration and configuring the HiveMQ broker to fit better into our stack.
For more information about Hive-MQ Community Edition, make sure to look into their [extensive documentation](https://www.hivemq.com/docs/hivemq/4.9/user-guide/introduction.html)

In the following table we will list the elements we used in the config.xml file we provide on startup of the hivemq container.

#### Listeners 

The following elements are all inside the /<listeners> base element in the config file, for more information look at the bottom of this page for an example.
For more information read [here](https://www.hivemq.com/docs/hivemq/4.9/user-guide/listeners.html).

| Element                        | Description                                                                                                 | contains                                                                                                                                               | Possible values                          | Example values                                                      |
|--------------------------------|-------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------|---------------------------------------------------------------------|
| \<tcp-listener>                | element for a basic TCP connection                                                                          | 1 of each elements: \<port>, \<bind-address>, \<name>                                                                                                  | -                                        | -                                                                   |
| \<tls-tcp-listener>            | element for a secure TCP connection                                                                         | 1 of each elements: \<port>, \<bind-address>, \<name>, \<tls>                                                                                          | -                                        | -                                                                   |
| \<websocket-listener>          | element for a basic WebSocket connection                                                                    | 1 of each elements: \<port>, \<bind-address>, \<name>                                                                                                  | -                                        | -                                                                   |
| \<tls-websocket-listener>      | element for a secure WebSocket connection                                                                   | 1 of each elements: \<port>, \<bind-address>, \<name>, \<tls>                                                                                          | -                                        | -                                                                   |
| \<tls>                         | element contains tls details for secure connections                                                         | variable, possible elements: \<protocols>, \<keystore>, \<truststore>, \<client-authentication-mode>, \<cipher-suites>, \<prefer-server-cipher-suites> | -                                        | -                                                                   |
| \<port>                        | port number for listeners                                                                                   | valid port number                                                                                                                                      | any valid port number                    | \<port>1883\</port>                                                 |
| \<bind-address>                | bind address for listeners                                                                                  | valid IP address                                                                                                                                       | any valid IP address                     | \<bind-address>0.0.0.0\</bind-address>                              |
| \<name>                        | name for the listener                                                                                       | the name for the listener                                                                                                                              | any string                               | \<name>hivemq-mqtt\</name>                                          |
| \<protocols>                   | element contains enabled protocols for the listener                                                         | \<protocol> elements for each protocol enabled                                                                                                         | -                                        | -                                                                   |
| \<protocol>                    | name of a protocol                                                                                          | valid protocol name                                                                                                                                    | "TLSv1", "TLSv1.1", "TLSv1.2", "TLSv1.3" | \<protocol>"TLSv1.3" \</protocol>                                   |
| \<keystore>                    | element for a keystore                                                                                      | 1 of each elements: \<path>, \<password>, \<private-key-password>                                                                                      | -                                        | -                                                                   |
| \<truststore>                  | element for a truststore                                                                                    | 1 of each elements: \<path>, \<password>                                                                                                               | -                                        | -                                                                   |
| \<password>                    | password to open the respective store                                                                       | the valid password to the corresponding element                                                                                                        | UTF-8 string                             | \<password> changeme \<password>                                    |
| \<path>                        | path to where the respective store is stored                                                                | a valid relative path                                                                                                                                  | valid path as a string                   | \<path> /stores/truststore.jks \<path>                              |
| \<client-authentication-mode>  | Determines which way HiveMQ handles authentication                                                          | A key to describe what way certificates are needed by the client                                                                                       | NONE, POSSIBLE, REQUIRED                 | \<client-authentication-mode>REQUIRED\</client-authentication-mode> |
| \<cipher-suites>               | element contains enabled cipher suites                                                                      | \<cipher-suite> elements                                                                                                                               | -                                        | -                                                                   |
| \<cipher-suite>                | cipher suite                                                                                                | a valid cipher suite name                                                                                                                              | valid cipher suite names                 | \<cipher-suite>TLS_RSA_WITH_AES_128_CBC_SHA\</cipher-suite>         |
| \<prefer-server-cipher-suites> | optional element, which enables preferential use of cipher suites higher up in the \<cipher-suites> element | a boolean value                                                                                                                                        | true, false                              | \<prefer-server-cipher-suites>true\</prefer-server-cipher-suites>   |

#### Persistence

The following elements are all inside the /<persistence> base element in the config file, for more information look at the bottom of this page for an example.
For details, read [here](https://www.hivemq.com/docs/hivemq/3.4/user-guide/configuration.html#mqtt-configuration-persistence-chapter)

| Element                     | Description                                                                 | contains                                                                          | Possible values         | Example values                                                        |
|-----------------------------|-----------------------------------------------------------------------------|-----------------------------------------------------------------------------------|-------------------------|-----------------------------------------------------------------------|
| \<client-session>           | Manages persistence of the client session                                   | one of each elements: \<general>, \<queued-messages>, \<subscriptions>            | -                       | -                                                                     |
| \<general>                  | details how the client session generally handles persistence                | \<mode> element                                                                   | -                       | -                                                                     |
| \<mode>                     | persistence handling mode (either memory based or disk based)               | string                                                                            | in-memory, file         | \<mode>file\</mode>                                                   |
| \<queued-message>           | details how the client session handles persistence of queued messages       | one of each elements: \<mode>, \<queued-messages-strategy>, \<max-queued-messages> | -                       | -                                                                     |
| \<max-queued-messages>      | maximum number of queued messages for a specific client                     | a positive integer                                                                | positive integers       | \<max-queued-messages>1800000\</max-queued-messages>                  |
| \<queued-messages-strategy> | Handles what to do when message queue is full                               | string which determines discarding strategy                                       | discard, discard-oldest | \<queued-messages-strategy>discard-oldest\</queued-messages-strategy> |
| \<subscriptions>            | details how the client session handles persistence on granted subscriptions | \<mode> element                                                                   | -                       | -                                                                     |
| \<message-flow>             | details how incoming and outgoing message flow persistence is handled       | \<incoming> ,  \<outgoing>                                                        | -                       | -                                                                     |
| \<incoming>                 | contains mode for incoming messages                                         | \<mode> element                                                                   | -                       | -                                                                     |
| \<outgoing>                 | contains mode for incoming messages                                         | \<mode> element                                                                   | -                       | -                                                                     |
| \<retained-messages>        | details how the client handles persistence of retained messages             | \<mode> element                                                                   | -                       | -                                                                     |
| \<publish-payloads>         | details how publish payloads are stored                                     | \<mode> element                                                                   | -                       | -                                                                     |
| \<attribute>                | details how session attributes are stored                                   | \<mode> element                                                                   | -                       | -                                                                     |
| \<client-group>             | details how client groups are stored                                        | \<mode> element                                                                   | -                       | -                                                                     |

#### Security 

The following elements are all inside the /<security> base element in the config file, for more information look at the bottom of this page for an example.
For more information red [here](https://www.hivemq.com/docs/hivemq/4.9/user-guide/configuration.html#security).

| Element                  | Description                                            | contains           | Possible values | Example values           |
|--------------------------|--------------------------------------------------------|--------------------|-----------------|--------------------------|
| \<allow-empty-client-id> | allows the use of empty client IDs                     | \<enabled> element | -               | -                        |
| \<enabled>               | enables or disables the meta-element                   | boolean value      | true, false     | <enabled>false</enabled> |
| \<utf8-validation>       | enables UTF-8 validation of topic names and client IDs | \<enabled> element | -               | -                        |



### Extensions

Our HiveMQ implementation uses an init-container to download and install the following extensions:

- [RBAC file extension](https://www.hivemq.com/extension/file-rbac-extension/) to manage the authentication and authorizations rules for the broker.
- [Prometheus extension](https://www.hivemq.com/extension/prometheus-extension/) to expose metrics for a prometheus applications
- [Heartbeat extension](https://www.hivemq.com/extension/heartbeat-extension/) to allow for readiness checks

These extensions are configured by the config-extensions.yaml. For detailed information visit their respective github documentation listed below. Nevertheless, we provide explanation regarding
our standard configuration.

#### RBAC file extension

This one uses an XML markup format for its configuration. In the table below we give a quick rundown of what the config contains. Make sure to check out their [GitHub documentation](https://github.com/hivemq/hivemq-file-rbac-extension) for more details.

| Element        | Description                                                                                                                                                 | contains                                                                                                                                          | Possible values              | Example Values                  |
|----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------|---------------------------------|
| \<users>       | Base element, entirety of \<users>                                                                                                                          | \<user> elements                                                                                                                                  | -                            | -                               |
| \<user>        | First indentation element, \<users> is composed of these elements                                                                                           | one of each elements: \<name>, \<password>, \<roles>                                                                                              | -                            | -                               |
| \<name>        | Name of the user                                                                                                                                            | username as string                                                                                                                                | any                          | \<name> FACTORYINPUT \</name>   |
| \<password>    | password for the username, in our case it is a custom encrypted hash, see [this article](/docs/production-guide/security/hivemq-rbac)  for more information | password                                                                                                                                          | password without whitespaces | \<password>changeme\</password> |
| \<roles>       | Roles users can have                                                                                                                                        | depending on location: base element contains \<role> elements, defining the \<role>s; as a subelement of \<user> it defines what roles a user has | -                            | -                               |
| \<id>          | id of a \<role>                                                                                                                                             | \<id> of a defined \<role>                                                                                                                        | valid MQTT topic structure   | \<id>superuser</id>             |
| \<role>        | Role, base element \<roles> is composed of these elements                                                                                                   | one \<id> element, one \<permissions> element                                                                                                     | -                            | -                               |
| \<permissions> | collection of all pub/sub \<permission>s the role has                                                                                                       | one or multiple <permission> elements                                                                                                             | -                            | -                               |
| \<permission>  | A sub/pub permission for the role                                                                                                                           | a valid \<topic> element                                                                                                                          | -                            | -                               |
| \<topic>       | Topic for the \<permission> element                                                                                                                         | a valid topic structure string                                                                                                                    | all valid topic structures   | \<topic>ia/#</topic>            |

#### Heartbeat

This one uses an XML markup format for its configuration. In the table below we give a quick rundown of what the config contains. Make sure to check out their [GitHub documentation](https://github.com/hivemq/hivemq-heartbeat-extension) for more details.

| Element         | Description                                                                                       | contains          | Possible values       | Example Values                         |
|-----------------|---------------------------------------------------------------------------------------------------|-------------------|-----------------------|----------------------------------------|
| \<bind-address> | (required) Base element, IP Address the service is bound to                                       | valid IP address  | any valid IP address  | \<bind-address>0.0.0.0\</bind-address> |
| \<port>         | (optional) Base element, port under which the service is available. 9090 if unset.                | valid port number | any valid port number | \<port> 9090 \</port>                  |
| \<path>         | (required) Base element, path where the heartbeat HTTP service is located. Default ist /heartbeat | valid path        | any valid path        | \<path> /heartbeat \</path>            |

#### Prometheus

This one uses a yaml style key:value pair in its configuration. For more information make sure to check out their [GitHub documentation]

| Element     | Description                                                                           | contains          | Possible values       | Example Values |
|-------------|---------------------------------------------------------------------------------------|-------------------|-----------------------|----------------|
| host        | IP Address the service is bound to                                                    | valid IP address  | any valid IP address  | 0.0.0.0        |
| port        | The port which the servlet will listen to. 9399 if unset.                             | valid port number | any valid port number | 9399           |
| metric_path | The path for the service which gets called by Prometheus. It must start with a slash. | valid path        | any valid path        | /prometheus    |

##### Example main hivemq config file

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{include "united-manufacturing-hub.fullname" .}}-hivemqce-hive
data:
  config.xml: |
    <?xml version="1.0"?>
    <hivemq xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        <listeners>
            {{- if .Values.hivemqce.service.mqtt.enabled}}
            <tcp-listener>
                <port>1883</port>
                <bind-address>0.0.0.0</bind-address>
                <name>hivemq-mqtt</name>
            </tcp-listener>
            {{- end}}
            {{- if .Values.hivemqce.service.mqtts.enabled}}
            <tls-tcp-listener>
                <port>8883</port>
                <bind-address>0.0.0.0</bind-address>
                <name>hivemq-secure-mqtt</name>
                <tls>
                    <protocols>
                        {{range .Values.hivemqce.service.mqtts.tls_versions}}
                        <protocol>{{.}}</protocol>
                        {{end}}
                    </protocols>
                    <keystore>
                        <path>/stores/keystore.jks</path>
                        <password>{{.Values._000_commonConfig.infrastructure.mqtt.tls.keystorePassword}}</password>
                        <private-key-password>{{.Values._000_commonConfig.infrastructure.mqtt.tls.privateKeyPassword}}</private-key-password>
                    </keystore>
                    <truststore>
                        <path>/stores/truststore.jks</path>
                        <password>{{.Values._000_commonConfig.infrastructure.mqtt.tls.truststorePassword}}</password>
                    </truststore>
                    <client-authentication-mode>REQUIRED</client-authentication-mode>
                    <cipher-suites>
                        {{range .Values.hivemqce.service.mqtts.cipher_suites}}
                        <cipher-suite>{{.}}</cipher-suite>
                        {{end}}
                    </cipher-suites>
                    <prefer-server-cipher-suites>true</prefer-server-cipher-suites>
                </tls>
            </tls-tcp-listener>
            {{- end}}
            {{- if .Values.hivemqce.service.ws.enabled}}
            <websocket-listener>
                <port>8080</port>
                <bind-address>0.0.0.0</bind-address>
                <path>/mqtt</path>
                <name>hivemq-websocket</name>
                <subprotocols>
                    <subprotocol>mqttv3.1</subprotocol>
                    <subprotocol>mqtt</subprotocol>
                </subprotocols>
                <allow-extensions>true</allow-extensions>
            </websocket-listener>
            {{- end}}
            {{- if .Values.hivemqce.service.wss.enabled}}
            <tls-websocket-listener>
                <port>8443</port>
                <bind-address>0.0.0.0</bind-address>
                <path>/mqtt</path>
                <name>hivemq-secure-websocket</name>
                <subprotocols>
                    <subprotocol>mqttv3.1</subprotocol>
                    <subprotocol>mqtt</subprotocol>
                </subprotocols>
                <allow-extensions>true</allow-extensions>
                <tls>
                    <protocols>
                        {{range .Values.hivemqce.service.wss.tls_versions}}
                        <protocol>{{.}}</protocol>
                        {{end}}
                    </protocols>
                    <keystore>
                        <path>/stores/keystore.jks</path>
                        <password>{{.Values._000_commonConfig.infrastructure.mqtt.tls.keystorePassword}}</password>
                        <private-key-password>{{.Values._000_commonConfig.infrastructure.mqtt.tls.privateKeyPassword}}</private-key-password>
                    </keystore>
                    <truststore>
                        <path>/stores/truststore.jks</path>
                        <password>{{.Values._000_commonConfig.infrastructure.mqtt.tls.truststorePassword}}</password>
                    </truststore>
                    <client-authentication-mode>REQUIRED</client-authentication-mode>
                    <cipher-suites>
                        {{range .Values.hivemqce.service.wss.cipher_suites}}
                        <cipher-suite>{{.}}</cipher-suite>
                        {{end}}
                    </cipher-suites>
                    <prefer-server-cipher-suites>true</prefer-server-cipher-suites>
                </tls>
            </tls-websocket-listener>
            {{- end}}
        </listeners>
        <persistence>
            <client-session>
                <general>
                    <mode>file</mode>
                </general>
                <queued-messages>
                    <max-queued-messages>1800000</max-queued-messages>
                    <queued-messages-strategy>discard-oldest</queued-messages-strategy>
                    <mode>file</mode>
                </queued-messages>
                <subscriptions>
                    <mode>file</mode>
                </subscriptions>
            </client-session>
            <message-flow>
                <incoming>
                    <mode>file</mode>
                </incoming>
                <outgoing>
                    <mode>file</mode>
                </outgoing>
            </message-flow>
            <retained-messages>
                <mode>file</mode>
            </retained-messages>
            <publish-payloads>
                <mode>file</mode>
            </publish-payloads>
            <attribute>
                <mode>file</mode>
            </attribute>
            <client-group>
                <mode>file</mode>
            </client-group>
        </persistence>
        <security>
            <allow-empty-client-id>
                <enabled>false</enabled>
            </allow-empty-client-id>
            <utf8-validation>
                <enabled>true</enabled>
            </utf8-validation>
        </security>
    </hivemq>
{{end}}
```

##### Example extension config file

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{include "united-manufacturing-hub.fullname" .}}-hivemqce-extension
data:
# https://github.com/hivemq/hivemq-file-rbac-extension
  credentials.xml: |
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <file-rbac>
    <users>
        <user>
            <name>FACTORYINPUT</name>
            <password>{{.Values.factoryinput.mqtt.encryptedPassword}}</password>
            <roles>
                <id>ia_read_write</id>
            </roles>
        </user>
        <user>
            <name>MQTT_KAFKA_BRIDGE</name>
            <password>{{.Values.mqttkafkabridge.mqtt.encryptedPassword}}</password>
            <roles>
                <id>ia_read_write</id>
            </roles>
        </user>
        <user>
            <name>MQTT_BRIDGE</name>
            <password>{{.Values.mqttbridge.mqtt.encryptedPassword}}</password>
            <roles>
                <id>ia_read_write</id>
            </roles>
        </user>
        <user>
            <name>SENSORCONNECT</name>
            <password>{{.Values.sensorconnect.mqtt.encryptedPassword}}</password>
            <roles>
                <id>ia_read_write</id>
            </roles>
        </user>
        <user>
            <name>IOTSENSORSMQTT</name>
            <password>{{.Values.iotsensorsmqtt.mqtt.encryptedPassword}}</password>
            <roles>
                <id>ia_raw</id>
            </roles>
        </user>
        <user>
            <name>PACKMLSIMULATOR</name>
            <password>{{.Values.packmlmqttsimulator.env.mqtt.encryptedPassword}}</password>
            <roles>
                <id>packmlsimulator</id>
            </roles>
        </user>
        <user>
            <name>node-red</name>
            <password>{{.Values.nodered.mqtt.encryptedPassword}}</password>
            <roles>
                <id>packmlsimulator</id>
                <id>umh_read_write</id>
                <id>ia_read_write</id>
            </roles>
        </user>
        {{if .Values._000_commonConfig.infrastructure.mqtt.adminUser.enabled}}
        <user>
            <name>{{.Values._000_commonConfig.infrastructure.mqtt.adminUser.name}}</name>
            <password>{{.Values._000_commonConfig.infrastructure.mqtt.adminUser.encryptedPassword}}</password>
            <roles>
                <id>superuser</id>
            </roles>
        </user>
        {{end}}
    </users>
    <roles>
        <role>
            <id>umh_read_write</id>
            <permissions>
                <permission>
                    <topic>umh/#</topic>
                </permission>
            </permissions>
        </role>
        <role>
            <id>ia_read_write</id>
            <permissions>
                <permission>
                    <topic>ia/#</topic>
                </permission>
            </permissions>
        </role>
        <role>
            <id>ia_raw</id>
            <permissions>
                <permission>
                    <topic>ia/raw/#</topic>
                </permission>
            </permissions>
        </role>
        <role>
            <id>packmlsimulator</id>
            <permissions>
                <permission>
                    <topic>{{.Values.packmlmqttsimulator.env.site}}/{{.Values.packmlmqttsimulator.env.area}}/{{.Values.packmlmqttsimulator.env.productionline}}/#</topic>
                </permission>
            </permissions>
        </role>
        <role>
            <id>superuser</id>
            <permissions>
                <permission>
                    <topic>#</topic>
                </permission>
            </permissions>
        </role>
    </roles>
    </file-rbac>


    heartbeat.xml: |
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <heartbeat-extension-configuration>
        <port>9090</port>
        <bind-address>0.0.0.0</bind-address>
        <path>/heartbeat</path>
    </heartbeat-extension-configuration>



    prometheus.properties: |
        ip=0.0.0.0
        port=9399
        metric_path=/metrics

```
