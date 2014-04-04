URI=$(echo $VCAP_APPLICATION | json application_uris | json 0)
sed -i 's/get.stackato.com/'$URI'/g' kato-patch/$TARGET_VERSION/manifest.json
sed -i 's/https/http/g' kato-patch/$TARGET_VERSION/manifest.json
echo "Staging complete, you can download your manifest by executing 'wget $URI/kato-patch/$TARGET_VERSION/manifest.json'"
