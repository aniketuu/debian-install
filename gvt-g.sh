
#!/bin/bash

printf "\033c" #reset the terminal
echo "setup GVT-g"

if [ $EUID -ne 0 ]; then
 echo "Please run as super user"
 exit 1
fi

# enable iommu
sed -i 's/^GRUB_CMDLINE_LINUX=""$/GRUB_CMDLINE_LINUX="intel_iommu=on i915.enable_gvt=1 kvm.ignore_msrs=1"/' /etc/default/grub
update-grub

# load modules
echo "vfio_mdev" >> /etc/modules
echo "kvmgt" >> /etc/modules
update-initramfs -u

# create systemd service
echo "[Unit]" > /etc/systemd/system/setup-gvt.service
echo "Description=Setup GVT" >> /etc/systemd/system/setup-gvt.service
echo "" >> /etc/systemd/system/setup-gvt.service
echo "[Service]" >> /etc/systemd/system/setup-gvt.service
echo "Type=oneshot" >> /etc/systemd/system/setup-gvt.service
echo "ExecStart=/usr/bin/bash -c 'echo 1e0d01e0-fe65-438a-9120-2066570851f4 > /sys/devices/pci0000:00/0000:00:02.0/mdev_supported_types/i915-GVTg_V5_4/create'" >> /etc/systemd/system/setup-gvt.service
echo "" >> /etc/systemd/system/setup-gvt.service
echo "[Install]" >> /etc/systemd/system/setup-gvt.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/setup-gvt.service
#systemctl enable setup-gvt --now
