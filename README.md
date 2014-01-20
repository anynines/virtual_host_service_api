# Virtual Host Service


## Problem solved by this service

To secure an URL with https it is necceary to setup a SSL certificate on the webserver. To setup a SSL certificate the configuration of the webserver has to be extended by a new vhost section. 

- Problem 1: Whenever a shared webserver is used to host multible customer applications only the admistrator of the webserver is able to add the customers ssl certificates.

- Problem 2: Whenever a webserver is part of a server farm (behind a load balancer) the administrator has to add the certificates to each webserver.

## System Architecture


The Virtual Host Service (vHost Service) provides an interface to push SSL certificates (certificate, ca certificate, private key) into the service. After passing a certificate to the vHost service the service will forward the cerificate into a RabbitMQ Exchange. The RabbitMQ Excange will dispatch the cerificates to a virual host worker installed on each webserver. The vHost worker eventually configures the webserver (nginx).

![an image](/doc/overall_architecture.png)

The sources for the worker wich has to be installed on each webserver are located here:
https://github.com/avarteqgmbh/virtual_host_service_worker

## Configuration

## Running the tests