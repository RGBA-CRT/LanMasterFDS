nesasm.exe -raw -s main_fds.asm
nesasm.exe -raw fds_image.asm
@REM copy /b fds_image_header.bin + /b fds_image.nes lan_master.fds
move fds_image.nes lan_master.fds
del main_fds.nes
@REM del fds_image.nes
@REM Todo: cut true disk size
python fds_fit.py