+++
title = "The OSS blueprint for the Industrial IoT"
menuTitle = "Documentation"
draft = false
description = "The United Manufacturing Hub is an Open-Source Helm Chart for Kubernetes, which combines state-of -the-art IT / OT tools & technologies and brings them into the hands of the engineer."
hide_readingtime = true
+++

<style>
h1 {text-align: center; margin-left: auto; margin-right: auto}
h2 {text-align: center; margin-left: auto; margin-right: auto}
.lead {text-align: center; margin-left: auto; margin-right: auto}
.center {text-align: center; margin-left: auto; margin-right: auto}
</style>
<!-- **Bringing the worlds best IT and OT tools into the hands of the engineer:** Why start from scratch when you can leverage a proven open-source blueprint? -->

<!-- <img src="/images/homepage_architecture.png" style="width: 80%; max-width: 1000px; margin: auto; display: block;"/> -->

## Bringing the worlds best IT and OT tools into the hands of the engineer
<p class="center">Why start from scratch when you can leverage a proven open-source blueprint? Kafka, MQTT, Node-RED, TimescaleDB and Grafana with the press of a button - tailored for manufacturing and ready-to-go</p>
<img src="/images/homepage_architecture.png" style="width: 80%; max-width: 1000px; margin: auto; display: block;"/>
<br>
<hr>

## What can you do with it?
<br>
<section id="features" >
    <div class="main-section">
        <div class="feature-box">
            <div>
                <h3 class="mb-3">Everything That You Need To Do To Generate Value On The Shopfloor</h3>
                <ul>
                    <li><strong>Extract data from the shopfloor</strong> <a href="https://nodered.org/">via Node-RED</a>, from <a href="/docs/architecture/microservices/core/sensorconnect/">ifm IO-Link gateways</a>, from <a href="/docs/architecture/microservices/core/barcodereader/">barcode readers</a> or from <a href="/docs/architecture/microservices/community/cameraconnect/">GenICam compatible cameras</a></li>
                    <li><strong>Contextualize and standardize data</strong> using <a href="https://nodered.org/">Node-RED</a> as a low-code programming tool and the <a href="">ISA95 compatible UMH data model</a></li>
                    <li><strong>Exchange and store data</strong> using <a href="/docs/architecture/microservices/core/hivemq/">HiveMQ</a> for IoT devices, <a href="/lesson/introduction-into-it-ot-kafka/">Apache Kafka</a> as enterprise message broker, and <a href="https://learn.umh.app/topic/timescaledb/">TimescaleDB</a> as a reliable relational and time-series storage solution</li>
                    <li><strong>Visualize data</strong> using <a href="https://grafana.com/">Grafana</a> and <a href="/docs/architecture/microservices/core/factoryinsight/">factoryinsight</a> to build powerful shopfloor dashboards</li>
                </ul>
            </div>
            <div>
                <h3 class="mb-3">Prevent Vendor Lock-In and Customize to Your Needs</h3>
            <ul>
                    <li><strong>The only requirement is Kubernetes</strong>, which is available in various flavors, including k3s, bare-metal k8s, and Kubernetes-as-a-service offerings like <a href="https://aws.amazon.com/de/eks/">AWS EKS</a> or <a href="https://azure.microsoft.com/en-us/products/kubernetes-service">Azure AKS</a></li>
                    <li><strong>Swap components with other options at any time.</strong> Not a fan of Node-RED? Replace it with <a href="https://learn.umh.app/topic/kepware/">Kepware</a>. Prefer a different MQTT broker? Use it!</li>
                    <li><strong>Leverage existing systems</strong> and add only what you need.</li>
            </ul>
            </div>
        </div>
        <div class="feature-box">
            <div>
                <h3 class="mb-3">Get Started Immediately</h3>
            <ul>
                    <li><strong><a href="/docs/getstarted/installation/">Download & install now</a></strong>, so you can show results instead of drawing nice boxes in PowerPoint </li>
            </ul>
            </div>
            <div>
                <h3 class="mb-3">Connect with Like-Minded People</h3>
            <ul>
                <li><strong>Tap into our community of experts and ask anything.</strong> No need to depend on external consultants or system integrators.</li>
                <li><strong>Leverage community content</strong>, from tutorials and Node-RED flows to Grafana dashboards. Although not all content is enterprise-supported, starting with a working solution saves you time and resources.</li>
                <li><strong>Get honest answers</strong> in a world where many companies spend millions on advertising.</li>
            </ul>
            </div>
        </div>
    </div>
    <hr>
</section>


## How does it work?
<p class="center">Only requirement: a Kubernetes cluster (and we'll even help you with that!). You only need to install the United Manufacturing Hub <a href="">Helm Chart</a> on that cluster and configure it.</p>
<p class="center">The United Manufacturing Hub will then generate all the required files for Kubernetes, including auto-generated secrets, various microservices like bridges between MQTT / Kafka, datamodels and configurations. From there on, Kubernetes will take care of all the container management.</p>
<br>
<br>
<img src="/images/homepage_howitworks.png" style="width: 100%; max-width: 1000px; margin: auto; display: block;"/>

## FAQ
<section id="why" class="section-why pt-0">
    <div class="main-section">
        <div id="accordion">
            <div class="card" style="margin: auto;">
                <div class="card-header">
                    <a class="card-link"
                        data-toggle="collapse"
                        href="#description1">
                        This looks great, but the technologies mentioned here (Docker, Kubernetes, etc.) look complicated and we as a company are no experts. Can we still use it?
                    </a>
                </div>
                <div id="description1"
                    class="collapse show"
                    data-parent="#accordion">
                    <div class="card-body">
                        <strong>Yes</strong> - the United Manufacturing Hub is targeting specifically people and companies, who do not have the budget and/or knowledge to work on their own / develop everything from scratch.<br><br>
                        With our extensive documentation, guides and knowledge sections you can learn everything that you need.<br><br>
                        The United Manufacturing Hub abstracts these tools and technologies so that you can leverage all advantages, but still focus on what really matters: digitizing your production.<br><br>
                        With our commercial <strong>Management Console</strong> you can manage your entire IT / OT infrastructure and work with Grafana / Node-RED without the need to ever touch or understand Kubernetes, Docker, Firewalls, Networking or similar. <br><br>
                        Additionally, you can get <strong>support licenses</strong> providing unlimited support during development and maintenance of the system. Take a look at our <a href="https://www.umh.app">website</a> if you want to get more information on this.
                    </div>
                </div>
            </div>
            <div class="card" style="margin: auto;">
                <div class="card-header">
                    <a class="collapsed card-link"
                        data-toggle="collapse"
                        href="#description2">
                        We just want to buy something off-the-shelf (end-to-end solution or IoT platform). Why should we still consider the United Manufacturing Hub?
                    </a>
                </div>
                <div id="description2" class="collapse"
                    data-parent="#accordion">
                    <div class="card-body">
                        Because very often these solutions do not target the actual pains of an engineer: implementation and maintenance. And then companies struggle in rolling out IIoT as the projects take much longer and cost way more than originally proposed. <br><br>
                        In the United Manufacturing Hub, <strong>implementation and maintenance of the system are the first priority</strong>. We've had these pains too often ourselves and therefore incorporated and developed tools & technologies to avoid them.  <br><br>
                        For example, with <a href="/docs/architecture/microservices/core/sensorconnect/">sensorconnect</a> we can retrofit production machines where it is impossible at the moment to extract data. Or, with our modular architecture we can fit the security needs of all IT departments - 
                        from integration into a demilitarized zone to on-premise and private cloud. With Apache Kafka <a href="https://www.umh.app/post/tools-techniques-for-scalable-data-processing-in-industrial-iot">we solve the pain of corrupted or missing messages when scaling out the system</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

## How to proceed?
