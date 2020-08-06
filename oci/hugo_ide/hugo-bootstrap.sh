#!/bin/bash

# ---
echo "HUGO_PROJECT_NAME=[${HUGO_PROJECT_NAME}]"
hugo --version
hugo new site ${HUGO_PROJECT_NAME}
