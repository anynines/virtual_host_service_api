# Virtual Host Service

## Problem solved by this service

To secure an URL with https it is necceary to setup a SSL certificate on the webserver. To setup a SSL certificate the configuration of the webserver has to be extended by a new vhost section. 

- Problem 1: Whenever a shared webserver is used to host multible customer applications only the admistrator of the webserver is able to add the customers ssl certificates.

- Problem 2: Whenever a webserver is part of a server farm (behind a load balancer) the administrator has to add the certificates to each webserver.

The main purpose of this service is to provide the users of an Cloud Foundry installation the possibility to upload their certificates throug a customer panel.

## Overall System Architecture

The Virtual Host Service (vHost Service) provides an interface to push SSL certificates (certificate, ca certificate, private key) into the service. After passing a certificate to the vHost service the service will forward the cerificate into a RabbitMQ Exchange. The RabbitMQ Excange will dispatch the cerificates to a virtual host worker installed on each webserver. The vHost worker eventually configures the webserver (nginx).

![an image](/doc/overall_architecture.png)

The sources for the worker wich has to be installed on each webserver are located here:
https://github.com/avarteqgmbh/virtual_host_service_worker


## Requirements

To run the vHost, service a MySql database and a RabbitMQ message bus is required. Further at least one corresponding worker should be configured and running.
To checkout the worker see: https://github.com/avarteqgmbh/virtual_host_service_worker

## Configuration

To configure the vHost service the configuration templates can be used.

```
cp config/amqp.yml.example config/amqp.yml
cp config/database.yml.example config/database.yml
cp config/application.example config/application.yml
```

The amqp.yml contains the RabbitMQ connection information. 
The database.yml contains the MySql connection information.

The application.yml contains following configuration fields:

- api_keys: Key value pairs. Each value of one of the pairs can be used to access the API. 
- amqp_channel: This should be the same string as used in the virtual host worker configuration.

## REST API of the Virtual Host Service 

### Create a new vHost configuration (upload ssl certificate)

This request should contain a ssl certificate and the corresponding private RSA key as parameters. The server name encoded in the certificate is actually the domain which should be protected with this certificate.

```
POST /v_hosts
```

Paramameters: 
	
- **params['access_token']**: One of the API keys configured in the config/application.yml file.
- **params['v_host']['organization_guid']**: A organization (customer) id to which the certificate belongs (optional).
- **params['v_host']['ssl_certificate']**: The ssl certificate for a domain. The hostname/servername which should be protected is encoded there.
- **params['v_host']['ssl_ca_certificate']**: The ca certificate (optional, could also be a chain of certificates)
- **params['v_host']['ssl_key']**: The private RSA key belonging to the certificate (must be unencrypted)

### List all certificates of an organization (customer)

This request returns a list of all server names which are protected with an uploaded certificate.

```
GET /v_hosts/by_organization
```

Paramameters:

- **params['access_token']**: One of the API keys configured in the config/application.yml file.
- **params['guid']**: The id of the organization/customer

### Delete a vHost configuration

```
DELETE /v_hosts/destroy_by_server_name
```

Paramameters:

- **params['access_token']**: One of the API keys configured in the config/application.yml file.
- **params['server_name']**: The server name (hostname) for wich the certificate should be deleted.


## Running the tests

Make sure the MySql and RabbitMQ servers are running. And the vHost service is configured (see section Configuration)

```
bundle install
bundle exec rake db:setup
bundle exec rake db:test:prepare

bundle exec rspec spec
```



