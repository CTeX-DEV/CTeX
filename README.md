CTeX Maintenance Plan  
====
如何自动编译：  
1. 运行 CTeX-Build.exe  
2. 到 output 目录下找到输出文件  

如何手工编译:  
0. 下载并安装 NSIS 3.0b3  
1. 下载启用 Advance Log 的 NSIS 3.0b3 （即覆盖进 NSIS 安装目录） http://prdownloads.sourceforge.net/nsis/nsis-3.0b3-log.zip?download   
2. 把本 repo 中 libs\external\Textreplace.zip 中的内容解压到 NSIS 程序目录下  
3. 执行以下命令： `makensis.exe /INPUTCHARSET UTF8 /OUTPUTCHARSET UTF8 /DDEBUG filename.nsi`  
4. 若需详细编译过程可使用 /V4 开关，但是会严重影响编译速度  
5. 若需发布则去掉 /DDEBUG 开关，并 install\Full 下面的文件夹移动到 install 下，删除所有的dummy.txt

目前已完成：  
- [x] 所有脚本UTF-8化  
- [x] 包含最新版的 Ghostview 和 GSView  
- [x] 加入 WinEdt 9.1 科学版（你懂的，可直接使用无需定期reset） （是否其他编辑器比如 TeX Studio？）  
- [x] 重绘图标（偷懒不加上 CTeX 字样了）
- [x] 重绘安装包的 Banner    
- [x] 支持从最新一个版本的升级（对于 MikTeX 其实是删除重装）
- [x] 再次重建目录结构（现在的 install 目录即要被打包的文件，但为了加快打包测试速度所有目录都是空的，真正的文件都在 Full 目录下，正式打包时移动即可）  
- [x] 在工作目录中包含一个最小化的 NSIS ，只保证可以正确编译本项目。
- [x] Patch WinEdt（加入 CTeX_Tools 菜单以及一些工具）
- [x] 加入MiKTeX 的必要部分（<https://gist.github.com/Liam0205/0da87bd77f13c9f4549f>） 

待完成或问题：  

- [ ] 测试 CJK 是否可以使用 
- [ ] 解决 zhmCJK 无法使用的问题
- [ ] 测试！测试！测试！
