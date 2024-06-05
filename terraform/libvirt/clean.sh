VM_NAME=nufuturo

virsh destroy $VM_NAME
virsh undefine $VM_NAME
terraform destroy -auto-approve

