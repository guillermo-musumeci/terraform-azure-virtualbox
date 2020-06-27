# Deploy VirtualBox in Azure Virtual Machines

Do we have an old 32-bit Windows application in our datacenter or an old application inside an OVA (Open Virtual Appliance) package, and do we want to move to Azure?

Azure doesn't provide support for 32-bit Windows OS, so we will need to use Nested Virtualization.

## Which Azure VMs supports Nested Virtualization?

At the time of writing (June 2020), following Azure families are supported:

* **D-Series:** D_v3, Ds_v3, D_v4, Dsv4, Ddv4, Ddsv4
* **E-Series:** E_v3, Es_v3, E_v4, Esv4, Edv4, Edsv4
* **F-Series:** F2s_v2, F72s_v2
* **M-Series**

We can find out which VM sizes support Nested Virtualization at the following link: https://docs.microsoft.com/en-us/azure/virtual-machines/acu

