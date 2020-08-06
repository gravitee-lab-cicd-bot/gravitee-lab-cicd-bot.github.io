+++
title = "The Bourne identities of the Gravitee Bot"
date = "2020-08-06T13:07:31+02:00"
toc = true
comments = true
+++

## What is the `Gravitee Lab` CI CD `Bot` ?

The **`Gravitee Lab` CI CD `Bot`**  :

* executes SecretHub operations like Setup, User / Permissions management, Secrets management
* Pipeline steps Docker image management operations.
* manage some labels on issues, like `stale`, or `waiting_since_more_than_30_days`
* talks to people on issues comments, merge/pull requests discussions,
* notify Gravitee lab Team members about piepline events (e.g test results report available at https://allure.gravitee-lab.io/pipelines/154778547 ) to multi channel : chatops , github pull requests discussions, email, etc...


In other words, as a Robot, I use many identities, to operate in the many countries of your Software factory partners :
* Pipeline Service provides,
* Secret Manager Service,
* Test Reporting Management Service,
* Infrastructure IAAS Service Providers,
* Badge as a service Providers,
* Chatops Service Providers,
* Security Management Services (Clair Scanners, other Docker image scanning),
* Payment Service Providers
* Delivery Service Providers (bintray, maven, docker registries)
* And the list just keeps growing every year etc... As a robot, I am here to make all repetitive, boring, automation-prone operatiosn easy for you (you won't ever do them again).
