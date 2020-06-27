####################
# Common Variables #
####################
company     = "kopicloud"
environment = "dev"
location    = "northeurope"

##################
# Authentication #
##################
azure-subscription-id = "complete-me"
azure-client-id       = "complete-me"
azure-client-secret   = "complete-me"
azure-tenant-id       = "complete-me"

###########
# Network #
###########
vnet-cidr   = "10.10.0.0/16"
subnet-cidr = "10.10.1.0/24"

##############
# Windows VM #
##############
windows-vm-hostname    = "kopi-nv-01" // Limited to 15 characters
windows-vm-size        = "Standard_D2s_v3"
windows-vm-os-disk     = "130" // Minimum size is 127GB
windows-admin-username = "tfadmin"
windows-admin-password = "K0p1Cl0udAdm1n"
