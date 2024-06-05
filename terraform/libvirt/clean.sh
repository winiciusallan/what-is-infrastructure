VM_NAME=nufuturo
POOL_NAME=images
IMAGE_PATH=/home/suporte/storage

virsh destroy $VM_NAME
virsh undefine $VM_NAME
virsh pool-destroy $POOL_NAME
virsh pool-undefine $POOL_NAME
sudo rm -rf $IMAGE_PATH/*
terraform destroy -auto-approve

