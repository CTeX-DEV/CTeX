$Id: addr2tex-README.txt,v 1.3 2005/06/28 13:53:00 zlb Exp $

通信录格式
----------

	姓名[@标题]<tab>地址（电话、email 等）

说明：

    “[@标题]”是可选的，如果给出则作为标题用于分类和排序，
    如“张三@教授”、“李四@副教授”等。

    姓名与地址间用 <tab> 隔开, 顶行的 <tab> 表示连续行。

    位于行首的 '%' 代表说明行

    地址中可用分号 ';' 分隔项目。
    项目中可用冒号 ':' 分隔项目名和项目内容
    (全/半角均可, 转换程序会将全角 '：' 和 '；' 转换成半角)
    使用冒号时一定注意要前一项用分号结束，因为它会将直到前一个分号的
    内容当作项目的名称排版。

    参看 addr2tex-sample.txt。


转换成 TeX 文件
---------------

	以下是转换、编译命令:

		addr2tex addr2tex-sample.txt
		ctex addr2tex-sample.tex

	TeX 文件编译时，如果能打开外部的 addr2tex.sty 则采用
	\usepackage{addr2tex}, 否则则使用内置的缺省格式排版
	(即系统自带的 addr2tex.sty 文件)。因此用户可以
	修改 addr2tex.sty 文件来改变输出格式。

	缺省情况下产生供 dvi 预览的 .tex 文件。如果打算用 dvipdfmx
	生成带书签的 .pdf 文件，则需使用 '-pdf' 选项:

		addr2tex -pdf addr2tex-sample.txt
		ctex -dvipdfmx addr2tex-sample.tex

	转换程序会自动在email地址上加 \email 命令，在网址上加 \url 命令。
	如果自动加的命令有问题，可以在 .txt 文件中手工加。
	如果某处不想自动加，可将相关内容用 '{}' 括起来。

Files
-----
	addr2tex-README.txt	本说明

	addr2tex.c		C源程序
	addr2tex.py		拼音表 (仅在编译 addr2tex.c 时需要)
	addr2tex.sty		TeX 头文件

	addr2tex-sample.txt	样版文件
