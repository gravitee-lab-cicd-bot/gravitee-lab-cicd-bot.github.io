#!/bin/bash

# ---
echo "HUGO_PROJECT_NAME=[${HUGO_PROJECT_NAME}]"
hugo version
hugo new site ${HUGO_PROJECT_NAME}
echo "generated folder : "
ls -allh ${HUGO_PROJECT_NAME}
ls -allh
pwd

cp -fR /gravitee-bot/work/${HUGO_PROJECT_NAME}/* /gravitee-bot/src/
echo "[- ./hugo/:/gravitee-bot/src/] volume folder content after bootstrap : "
ls -allh /gravitee-bot/src/

# --
# Installing HUGO THEME

rm -fr /gravitee-bot/src/themes/vec
git clone ${HUGO_THEME_GIT_URI} /gravitee-bot/src/themes/vec

rm -fr /gravitee-bot/src/themes/vec/.git/


mkdir -p /gravitee-bot/src/layouts
cp -fR /gravitee-bot/src/themes/vec/layouts/* /gravitee-bot/src/layouts/

mkdir -p /gravitee-bot/src/static
cp -fR /gravitee-bot/src/themes/vec/static/* /gravitee-bot/src/static/

mkdir -p /gravitee-bot/src/archetypes
cp -fR /gravitee-bot/src/themes/vec/archetypes/* /gravitee-bot/src/archetypes/

mkdir -p /gravitee-bot/src/images
cp -fR /gravitee-bot/src/themes/vec/images/* /gravitee-bot/src/images/

mkdir -p /gravitee-bot/src/src
cp -fR /gravitee-bot/src/themes/vec/src/* /gravitee-bot/src/src/


cp -fR /gravitee-bot/src/themes/vec/exampleSite/* /gravitee-bot/src/


# --
# Tying up theme to hugo project, in Hugo project config file [config.toml]

sed -i "s#theme =.*#theme = \"vec\"#g" /gravitee-bot/src/config.toml

# setting up baseURL

sed -i "s#baseURL =.*#baseURL = \"${HUGO_BASE_URL}\"#g" /gravitee-bot/src/config.toml
sed -i "s#baseurl =.*#baseURL = \"${HUGO_BASE_URL}\"#g" /gravitee-bot/src/config.toml



# Now building
cd /gravitee-bot/src && hugo
