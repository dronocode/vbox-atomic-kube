N=${1:?num}
NN=$(($N+200))
sed -e "s/atom0/atom$N/" -e "s/200/$NN/g" <meta-data.tmpl >meta-data
genisoimage -output init$N.iso -volid cidata -joliet -rock user-data meta-data
VBoxManage clonevm atom-template --name atom$N --snapshot atom-template-snapshot --options link --register
VBoxManage storageattach atom$N --storagectl IDE --port 0 --device 0 --type dvddrive --medium init$N.iso 
