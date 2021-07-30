## uefi 和bios 区别

传统bios引导是
1. 读取bois里设定的第一启动设备的mbr（主引导记录）
2. 寻找活动分区
3. 加载pbr（分区引导记录）
4. 加载boot loader（nt5是ntldr，nt6是bootmgr，其他如grub）
5. 加载相应启动菜单（nt5是boot.ini，nt6是boot目录bcd文件，grub的grub.conf）
6. 加载系统引导程序（win是winloader.exe，linux是initrd等）

uefi引导（多数为64位引导）
1. uefi搜索所有设备的efi分区（fat分区及包含efi、boot目录、bootx64.efi文件）并以此列出可引导的efi启动设备，win7必须开启csm兼容模式，所以并非完全兼容uefi
2. 选择引导该设备并加载efi启动菜单（efi目录下多条记录）
3. 加载引导文件（windows的bootmgfw.efi，grub的grubx64.efi）
4. 加载相应启动菜单（windows为bcd文件，grub的grub.conf）
5. 加载系统引导程序（windows为winloader.efi，linux为initrd等）