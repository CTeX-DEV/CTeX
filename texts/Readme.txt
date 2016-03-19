CTeX 3.0.0
==========

目录

1. 内容
2. 安装
3. 其它
   3.1. CJK 中文模式和字库
   3.2. 升级和更新
   3.3. 刷新文件名数据库
4. 致谢
5. 关于我们
   5.1. 网站
   5.2. CTeX 中文套装
   5.3. 联系方式


====================================================

1. 内容

本套装软件包中含有如下软件：

        MiKTeX 2.9 以及必要的宏包
        WinEdt 10.0
        GSview 5.0
        Ghostscript 9.18
        SumatraPDF 3.11


====================================================

2. 安装

请将原先的 CTeX 中文套装卸载后再安装新版本，不要直接升级。

新版本中的 FontSetup 可以自动从系统字库中生成中文 Type1 字库，但是
建议尽量不使用，而是使用 TrueType 字库。


====================================================

3. 其它


3.1. CJK 中文模式

CTeX 中文套装可以直接使用的 CJK 模式有 GBK 和 UTF8，字体有六种

song    % 宋体
hei     % 黑体
kai     % 楷体
fs      % 仿宋
li      % 隶书
you     % 幼圆

如果需要使用 pmC 模式或者 GB 编码，或者增加其他中文字库，请自己生成相关
字库和配置文件。可以参考 CTeX 目录下的文件。


3.2. Type1 字库

如果没有生成中文 Type1 字库，则自动使用 Windows 自带的 TrueType 字库。
在这种情况下，只有 dvips 使用 ttf2pk 来将 TrueType 字库转为 pk 字库，
而其他程序如 dvipdfmx 和 pdfTeX 都将直接使用 TrueType 字库。

在生成 Type1 字库后，pdfTeX 和 pdfLaTeX 将改为使用 Type1 字库，此时要使
pdfTeX 和 pdfLaTeX 直接使用 TrueType 字库，请在 tex 文件中使用如下命令

\input{cjk-ttf}

来使用中文 TrueType 字库。

注意：Windows XP 中的楷体和仿宋体 TrueType 字库只是 GB2312 字符集，而其他几
种字体是 GBK 大字符集。


3.3. 升级

如果 CTeX 中文套装没有及时升级，你可以自己更新 CTeX 中文套装中的部件。
CTeX 中文套装中的大部分软件可以单独升级。

MiKTeX 升级可以使用菜单中的 MiKTeX -> Update
MiKTeX 增加 package 可以使用菜单中的 MiKTeX -> Browser Packages

Ghostscript 和 GSview 只需直接安装新的版本即可。安装完成以后，原来的目录
可以删除。升级 Ghostscript 以后要在 GSview 的菜单
Options -> Easy Configuration 中设置正确的版本号，这样 GSview 才能正常工
作。有时还要刷新 MiKTeX 的文件名数据库以使用 Ghostscript 所带的字库。

WinEdt 的升级比较麻烦，不建议自己升级。


3.4. 刷新文件名数据库

在对 CTeX 和 MiKTeX 目录下的文件作出修改后，请不要忘了刷新 MiKTeX 的
文件名数据库。可以使用菜单中的 MiKTeX -> Settings 工具来完成。


====================================================

4. 致谢

如果你对 CTeX 中文套装进行了修改，或者制作了补丁，欢迎将修改信息反馈到 CTEX。
这将对我们制作下一个发行版本有很大的帮助。有任何的建议和意见，也欢迎向
我们反映。感谢 CTEX 论坛上的用户对 CTeX 套装软件提出的各种建议和意见。


====================================================

5. 关于我们

CTEX 是一个中国 TeX 用户社区，目前负责 CTEX 网站和 CTEX 论坛的管理维护
工作。

CTEX 的宗旨是为中国广大的 TeX 用户提供力所能及的帮助。CTEX 目前除了
维护 CTEX 网站外，还开发提供了 CTeX 中文套装（中文 TeX 套装）软件。


5.1. CTEX 网站

CTEX 的服务器和网络接入得到了中国科学院数学与系统科学研究院的支持。

CTEX 网站提供大量的 TeX 相关软件和文档下载，以及各类新闻通讯。

CTEX 网站的网址为 http://www.ctex.org
CTEX 论坛的网址为 http://bbs.ctex.org


5.2. CTeX 中文套装

CTeX 中文套装是基于 Windows 下的 MiKTeX 系统，集成了编辑器 WinEdt 和 PostScript 
处理软件 Ghostscript 和 GSview 等主要工具。

CTeX 中文套装在 MiKTeX 的基础上增加了对中文的完整支持。CTeX 中文套装支持
CJK/CCT/TY 三种中文 TeX 处理方式。

CTeX 中文套装只用于科研与学术目的，不得以任何理由用于商业目的。CTeX 中文套装中
包含的所有免费、共享软件的版权均属于其原作者。安装程序的版权属于 CTEX。


5.3. 联系方式

主页：http://www.ctex.org
论坛：http://bbs.ctex.org
