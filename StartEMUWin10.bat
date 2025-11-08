
@echo off
REM QEMU VM Launcher

REM ===== CAU HINH  =====
SET VM_IMG=win.qcow2
REM "add -cdrom %ISO_IMG% ^" when init in the first time
SET ISO_IMG=win10.iso
SET VIRTIO_ISO=virtio-win.iso

echo.
echo ================================================
echo   QEMU - Da khoi dong thanh cong!
echo ================================================
echo.
echo Luu y:
echo - Nhan Ctrl+Alt+G de bat/tha chuot
echo - Nhan Ctrl+Alt+F de chuyen sang che do toan man hinh
echo - Nhan Ctrl+Alt+Q de thoat QEMU
echo.

REM ===== command to run =====
"qemu-system-x86_64" ^
  -machine pc-q35-9.0,usb=off,vmport=off,kernel_irqchip=on,hpet=off,acpi=on ^
  -accel whpx ^
  -cpu Nehalem,+ssse3,+sse4.1,+sse4.2,+x2apic,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time,hv_vendor_id=GenuineIntel ^
  -smp 4,sockets=1,cores=4,threads=1 ^
  -m 8G ^
  -drive file=%VM_IMG%,cache=writeback,format=qcow2,aio=threads ^
  -boot order=d,strict=on ^
  -drive file=%VIRTIO_ISO%,media=cdrom,index=2 ^
  -rtc base=localtime,driftfix=slew,clock=host ^
  -global ICH9-LPC.disable_s3=1 ^
  -global ICH9-LPC.disable_s4=1 ^
  -device VGA,vgamem_mb=256 ^
  -display sdl ^
  -device virtio-serial-pci ^
  -device intel-hda ^
  -device hda-duplex ^
  -device virtio-net-pci,netdev=net0 ^
  -netdev user,id=net0 ^
  -usb ^
  -device virtio-balloon-pci ^
  -device usb-tablet ^
  -smbios type=0,vendor="American Megatrends Inc.",version="UX305UA.201",date="11/09/2025" ^
  -smbios type=1,manufacturer="ASUS",product="UX305UA",version="1.0",serial="System-Serial",uuid="00000000-0000-0000-0000-000000000000",sku="SKU",family="Notebook" ^
  -smbios type=2,manufacturer="ASUSTeK",product="UX305UA",version="1.0",serial="Board-Serial" ^
  -smbios type=3,manufacturer="ASUS",version="1.0",serial="Chassis-Serial" ^
  -smbios type=4,manufacturer="Intel",version="Core i7",max-speed=3400,current-speed=3400 ^
  -smbios type=17,manufacturer="Kingston",loc_pfx="DIMM",speed=2400,serial="12345678",part="KHX2400C15/8G"

echo VM da dong. Nhan phim bat ky de thoat...
pause >nul