CREATED=`php -r 'echo date("c");'`
NONCE=`php -r 'echo uniqid();'`
DIGEST=`php -r 'echo base64_encode(sha1(base64_decode("'$NONCE'") . "'$CREATED'" . "'$OWNER_APIKEY'", true));'`
curl -H 'Accept: application/json' -H 'Content-Type: application/json' -H 'Authorization: WSSE profile="UsernameToken"' -H 'X-WSSE: UsernameToken Username="'$OWNER_USERNAME'", PasswordDigest="'$DIGEST'", Nonce="'$NONCE'", Created="'$CREATED'"' -X POST -d '{"build-name":"'$JOB_NAME'", "build-id":"'$BUILD_NUMBER'", "entity-id":'$ORO_IMAGE_ID', "state": "available"}' $MGMT_URL/image/notify

exit 0
