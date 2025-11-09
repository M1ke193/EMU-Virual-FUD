### BEGIN
- TURN OFF `Hyper-V`
- Turn on `Hypervisor Windows Platform`
- You can find it in `Windows features` there are some tick box, just tick.

### PREPARING
- Download ISO of window and put it in folder.

- Download QEMU from here: https://qemu.weilnetz.de/w64/, then set as `ENV` path, if should be inside `C:\Program Files`.

- Download `VIRT VIEWER` from https://virt-manager.org/.

- Download `virtio-win.iso` https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/ put it in folder.

### SETUP
- Edit file `STARTEMU.bat`
  + Find line `SET ISO_IMG=win10.iso` -> change to name of `ISO file` window that you downloaded.
  + Add this line to command `-cdrom %ISO_IMG% ^`, you just need it in the first time when install window, after that you can remove it and also delete ISO file too if you want to save space. ( Could be some problem with this line `-drive file=%VIRTIO_ISO%,media=cdrom,index=2 ^` so maybe you can delete this line and install window first and add it again, it can be fix but im lazy :) )

- Make sure `virtio-win.iso` you downloaded in the folder and also change name for it from this line `SET VIRTIO_ISO=virtio-win.iso`. In VM you click `My PC`-> Find the disk that mounted -> Click and find `virtio-win-gt-x64.msi` -> Install. It help you to connect internet and setup some necessary thing.

- Final: When you start VM already and then download https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe inside it and install.

### HOW TO RUN
- RUN `StartEMU.bat`
- THEN RUN `SpciceView.bat`

