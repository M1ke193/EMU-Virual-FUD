
@echo off
chcp 65001 >nul
cls
color 0A
REM QEMU VM Launcher

REM ===== Config  =====
SET VM_IMG=win.qcow2
REM Add "-cdrom %ISO_IMG% ^" in the command below when init in the first time, for installing windows
SET ISO_IMG=win10.iso
SET VIRTIO_ISO=virtio-win.iso

SET RAM=6G
SET CPU_CORES=6
SET SPICE_PORT=5900

echo.
echo ================================================
echo   Starting QEMU (QXL/SPICE Mode)
echo SPICE Server: localhost:%SPICE_PORT%
echo Using Remote Viewer to connect
echo ================================================
echo.
echo ╔════════════════════════════════════════════════╗
echo ║              SPICE HOTKEYS - CHEAT SHEET       ║
echo ╠════════════════════════════════════════════════╣
echo ║ Shift + F12         │ Release / Grab Mouse     ║
echo ║ F11                 │ Toggle Fullscreen        ║
echo ║ Ctrl + Alt + End    │ Send Ctrl+Alt+Del        ║
echo ║ Ctrl + C / V        │ Copy / Paste             ║
echo ║ Alt + F4            │ Close VM Window          ║
echo ╚════════════════════════════════════════════════╝
echo.

REM ===== command to run =====
"qemu-system-x86_64" ^
  -machine pc-q35-9.0,usb=off,vmport=off,kernel_irqchip=on,hpet=off,acpi=on ^
  -accel whpx ^
  -cpu Nehalem,+ssse3,+sse4.1,+sse4.2,+x2apic,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time,hv_vendor_id=GenuineIntel ^
  -smp %CPU_CORES%,sockets=1,cores=%CPU_CORES%,threads=1 ^
  -m %RAM% ^
  -drive file=%VM_IMG%,cache=writeback,format=qcow2,aio=threads ^
  -boot order=d,strict=on ^
  -drive file=%VIRTIO_ISO%,media=cdrom,index=2 ^
  -rtc base=localtime,driftfix=slew,clock=host ^
  -global ICH9-LPC.disable_s3=1 ^
  -global ICH9-LPC.disable_s4=1 ^
  -vga qxl ^
  -global qxl-vga.ram_size=268435456 ^
  -global qxl-vga.vram_size=268435456 ^
  -global qxl-vga.vgamem_mb=256 ^
  -spice port=%SPICE_PORT%,addr=127.0.0.1,disable-ticketing=on,image-compression=auto_glz,streaming-video=filter,playback-compression=on ^
  -device virtio-serial-pci ^
  -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 ^
  -chardev spicevmc,id=spicechannel0,name=vdagent ^
  -audiodev spice,id=spice-audio ^
  -device intel-hda,id=sound0 ^
  -device hda-duplex,audiodev=spice-audio ^
  -device virtio-net-pci,netdev=net0 ^
  -netdev user,id=net0,ipv6=off,dns=8.8.8.8 ^
  -usb ^
  -device virtio-balloon-pci ^
  -device usb-tablet ^
  -device usb-kbd ^
  -smbios type=0,vendor="American Megatrends Inc.",version="UX305UA.201",date="11/09/2025" ^
  -smbios type=1,manufacturer="ASUS",product="UX305UA",version="1.0",serial="System-Serial",uuid="00000000-0000-0000-0000-000000000000",sku="SKU",family="Notebook" ^
  -smbios type=2,manufacturer="ASUSTeK",product="UX305UA",version="1.0",serial="Board-Serial" ^
  -smbios type=3,manufacturer="ASUS",version="1.0",serial="Chassis-Serial" ^
  -smbios type=4,manufacturer="Intel",version="Core i7",max-speed=3400,current-speed=3400 ^
  -smbios type=17,manufacturer="Kingston",loc_pfx="DIMM",speed=2400,serial="12345678",part="KHX2400C15/8G"

echo VM Closed. Press any key to exit...
pause >nul