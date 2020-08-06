# Everything you ever wanted to know [about me, the `Gravitee Lab` CI CD `Bot`](https://github.com/gravitee-lab-cicd-bot) !

This is the git repo which version controls the `hugo` source code of the documentation for the **Gravitee Bot**

## What is the `Gravitee Lab` CI CD `Bot` ?

The **`Gravitee Lab` CI CD `Bot`**  :

* executes SecretHub operations like Setup, User / Permissions management, Secrets management
* Pipeline steps Docker image management operations.
* manage some labels on issues, like `stale`, or `waiting_since_more_than_30_days`
* talks to people on issues comments, merge/pull requests discussions,
* notify Gravitee lab Team members about piepline events (e.g test results report available at https://allure.gravitee-lab.io/pipelines/154778547 ) to multi channel : chatops , github pull requests discussions, email, etc...


## How to modify this Who am I (Robot As Code)

Say you are using the Atom ide (or modify the atom commands below to your IDE 's Command)

* Retrieve the code and init the git flow in your workspace :

```bash
export MYWORK_HOME=~/graviteebothugo/
git clone git@github.com:gravitee-lab-cicd-bot/gravitee-lab-cicd-bot.github.io.git ${MYWORK_HOME}
cd  ${MYWORK_HOME}
git flow init --defaults
git push -u origin --all
git flow feature start  ${FEATURE_ALIAS}
git push -u origin --all
atom .
```

* modify the hugo source code with the git flow , and make a release, to trigger github pages deployment. The hugo generated static assets must be placed into the `./docs` folder, on the `master` branch.
* to test the `hugo` code :



* note your github user must be invited to the repo by the `Gravitee Bot` Github.com user, to be allowed to commit to `master`, or send pull requests.

## How this whoami was initialized

* [ ] init the git flow :

```bash
export MYWORK_HOME=~/graviteebothugo/
git clone git@github.com:gravitee-lab-cicd-bot/gravitee-lab-cicd-bot.github.io.git ${MYWORK_HOME}
cd  ${MYWORK_HOME}
git flow init --defaults
git push -u origin --all
git flow feature start  ${FEATURE_ALIAS}
git push -u origin --all

export FEATURE_ALIAS='hugo_bootstrap'
export COMMIT_MESSAGE="feat(${FEATURE_ALIAS}): adding docker compose based hugo ide as required by #1"

atom .

```


* [ ] add quick hugo ide :
  * `export FEATURE_ALIAS='hugo_bootstrap' && git flow feature start  ${FEATURE_ALIAS}`
  * in `./docker-compose.yml` :

```bash

#
# Copyright (C) 2015 The Gravitee team (http://gravitee.io)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
version: '3.5'

networks:
  hugo_bootstrap:
    name: hugonet
    driver: bridge

volumes:
  graviteebot-data:

services:

  hugo_bootstrap:
    image: quay.io/gravitee-lab/hugo-ide:0.74.3
    build:
      context: oci/hugo_bootstrap
      args:
        - HUGO_VERSION=latest
    command: server
    ports:
      - "1313:1313"
    volumes:
      - ".:/src"
      - ./.gravitee-bot/.secrets:/gravitee-bot/.secrets
      # - graviteebot-data:/gravitee-bot/.data
    environment:
      - HUGO_BASE_URL=https://gravitee-lab-cicd-bot.github.io/
    networks:
      - hugo_bootstrap
```
  * in `oci/hugo-ide/Dockerfile` :

```Yaml
FROM klakegg/hugo:0.74.3
# https://github.com/klakegg/docker-hugo

ARG HUGO_VERSION=graviteeio

ARG HUGO_BASE_URL
ENV HUGO_BASE_URL=${HUGO_BASE_URL}

RUN mkdir -p /gravitee-bot/.secrets
VOLUME /gravitee-bot/.secrets

```
  * `export FEATURE_ALIAS='hugo_bootstrap' && git flow feature finish  ${FEATURE_ALIAS} && git push -u origin --all`
* [ ] add quick hugo theme :
  * `export FEATURE_ALIAS='hugo_theme' && git flow feature start  ${FEATURE_ALIAS}`
  * bootstrap hugo project with theme https://github.com/IvanChou/hugo-theme-vec , out of executing :

```bash
# git flow init
# Bootstrap project :
./bootstrap.sh
# Develop cycle :
docker-compose up -d --build --force-recreate hugo_ide && docker-compose logs -f hugo_ide

cp -fr src/public/* ./docs
sed -i "s#baseURL =.*#baseURL = \"${HUGO_BASE_URL}\"#g" ./docs/config.toml
sed -i "s#baseurl =.*#baseURL = \"${HUGO_BASE_URL}\"#g" ./docs/config.toml

# Congrats! Now the fresh hugo project source code is generated under the [src/] folder, and your site runing at

# And now you could do a release
```

  * `export FEATURE_ALIAS='hugo_theme' && git flow feature finish  ${FEATURE_ALIAS} && git push -u origin --all`
* [ ] do the release :
  * `git flow release start 0.0.1`
  * `git flow release finish -s 0.0.1`
  * `git push -u origin --all && git push -u origin --tags`
