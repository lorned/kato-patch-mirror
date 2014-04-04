URI=$(echo $VCAP_APPLICATION | json application_uris | json 0)
wget -q https://a248.e.akamai.net/cdn.hpcloudsvc.com/g701e14e9fa37a30cfbbc3a01f78365e2/prodae1//blob-manifest
wget -q https://a248.e.akamai.net/cdn.hpcloudsvc.com/g701e14e9fa37a30cfbbc3a01f78365e2/prodae1//folder-manifest
cat blob-manifest | grep $TARGET_VERSION > version-blobs
cat folder-manifest | grep $TARGET_VERSION > folder-blobs
rm blob-manifest folder-manifest
cd blobs
while read folder; do
  mkdir $folder
done < ../folder-blobs
while read file; do
  curl -s -o $file https://a248.e.akamai.net/cdn.hpcloudsvc.com/g701e14e9fa37a30cfbbc3a01f78365e2/prodae1/$file
done < ../version-blobs
cd ~/kato-patch/$TARGET_VERSION
grep -r1 -l hpcloudsvc . | xargs sed -i 's|https://a248.e.akamai.net/cdn.hpcloudsvc.com/g701e14e9fa37a30cfbbc3a01f78365e2/prodae1/|'$URI'/blobs/|g'
rm ~/version-blobs && rm ~/folder-blobs
