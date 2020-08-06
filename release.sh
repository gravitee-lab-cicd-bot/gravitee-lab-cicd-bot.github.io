#!/bin/bash

source .env

hugoPackage () {
  if [ -d ./docs ]; then
    rm -fr ./docs
  fi;
  mkdir -p ./docs
  cp -fr $(pwd)/hugo/public/* ./docs
  sed -i "s#baseURL =.*#baseURL = \"${HUGO_BASE_URL}\"#g" ./docs/config.toml
  sed -i "s#baseurl =.*#baseURL = \"${HUGO_BASE_URL}\"#g" ./docs/config.toml
}
# Develop cycle :
docker-compose up -d --build --force-recreate hugo_ide && sleep 5s && hugoPackage

docker-compose logs -f hugo_ide

# Congrats! Now the fresh hugo project source code is generated under the [src/] folder, and your site runing at

# And now you could do a release

if [ "x${COMMIT_MESSAGE}" == "x" ]; then
  echo "Your commit message is empty or not set"
  echo "set the COMMIT_MESSAGE env. var. to finish your git flow feature"
  exit 7
fi;

git add --all && git commit -m "${COMMIT_MESSAGE}" && git push -u origin HEAD

if [ "x${FEATURE_ALIAS}" == "x" ]; then
  echo "Your FEATURE_ALIAS is empty or not set"
  echo "set the FEATURE_ALIAS env. var. to finish your git flow feature"
  echo ""
fi;

git flow feature finish ${FEATURE_ALIAS} && git push -u origin --all

git flow release start ${NEXT_RELEASE}
git flow release finish -s ${NEXT_RELEASE}
