echo "${BUILD_URL}consoleText"
echo "---image-build-start---"
gcloud docker -- pull "${BUILDER_IMAGE}"
docker run --name "orobuild_${BUILD_NUMBER}" --privileged \
-v /srv/vault/builder_token:/secret/vault/token \
-v /srv/vault/builder_token:/vault_token \
-v /srv/app-data/cache/composer:/var/cache/composer \
-e "COMPOSER_CACHE_DIR=/var/cache/composer" \
-e "GIT_REPOSITORY_URI=${GIT_REPOSITORY_URI}" \
-e "GIT_REPOSITORY_BRANCH=${GIT_REPOSITORY_BRANCH}" \
-e "DOCKER_IMAGE_POOL=${DOCKER_IMAGE_POOL}" \
-e "DOCKER_IMAGE_NAME_PREFIX=${DOCKER_IMAGE_NAME_PREFIX}" \
-e "DOCKER_IMAGE_TAG=${DOCKER_IMAGE_TAG}" \
-e "ORO_ROOT_IMAGE=${ORO_ROOT_IMAGE}" \
-e "BUILD_OPTIONS_ENVIRONMENT=${BUILD_OPTIONS_ENVIRONMENT}" \
-e "RSA_KEY_FINGERPRINT=${RSA_KEY_FINGERPRINT}" \
-e "VAULT_ADDR=${VAULT_ADDR}" \
"${BUILDER_IMAGE}" && exit 0 || {
  exit 2
}
# exit 1 need to identify failed job by post build task
