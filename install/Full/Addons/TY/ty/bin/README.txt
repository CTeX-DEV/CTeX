                        TYWIN安装方法

只需建立一个子目录(如TYWIN), 把zip中的文件复制过去, 子目录中的文件
复制入TEX的相应子目录, texuser 子目录下面的文件是试验用的例子, 可
复制入天元源文件的目录内. 再在桌面建立一个快捷方式即可.

为了能使用天元内含的绘图程序 TYdraw, 还需要安装 TYdraw fonts. 如果
你使用的 TeX 系统不会自动执行 Metafont 以生成 tfm 与 pk 文件(例如
PCTEX32), 则你需要再下载 tdwfont.zip, 把 tfm 以及 pk 文件分别复制入
相应的子目录中. 如果你使用的 TeX 系统能自动执行 Metafont 生成所需的
tfm 以及 pk 文件, 则只需再下载 tdwmf.zip, 把 mf 文件复制入 cmr10.mf
所在的子目录内即可. 不需再下载 tdwfont.zip.

TEXUSER 中有4个天元源文件, 其中 testty1.ty 以及 testty2.ty 应该先用
TYWIN 的默认汉字大小处理, 再分别用 LaTeX2e 及 AMSTEX 编译. test1.ty 
以及 test2.ty 应该采用 LaTeX 对应的汉字大小, 先用 TYWIN 处理, 再用
LaTeX2e 编译. 这4个例子做对了, 就说明安装成功了.

天元的功能及使用方法请参看help文件 tywin.hlp
