[使用]
    只需点击鼠标,选中符号所对应用的LaTeX命令就会插入到WinEdt编辑的当前文本的光标所在处.
对于WinEdt, 系统还会检查该LaTeX文件是否调用了相应的宏包.若没有,则会在\documentclass...下面加入一行,如 \usepackage{...}.

为使该系统正确工作,LaTeX文件必须以\documentclass开始.对于CCT中文TeX,建议使用

      \documentclass[11pt]{cctart}
      \documentclass[11pt]{cctbook}
      \documentclass[11pt]{cctpage}
       ... ...
(\documentstyle 为LaTeX 2.09所定义的命令. LaTeX 2e 应使用命令\documentclass)

[文件格式说明]

   您可以按以下方法扩充字符集,从而加强TeXFriend的功能.

[fonts.txt]
   每行定义了一个字符集。其中caption为字符集的名称，bitmap为存放这些字符的位图文件（可以为其他格式），该图被分成r x c个小图，每个小图代表一个字符，h,w分别为小图的高和宽。command为一个文本文件，它的每一行定义了一个字符串，与bitmap中的小图相对应，它的格式为

macro="...",  package="..."
 
[Editors.txt]

您可以自定义编辑器, 其中
Editor="..."中的字符串将出现在TexFriend标题栏, 
CaptionWord="..."中的字符串为该编辑器运行时标题栏的特征字符串, TexFriend用它来确定当前编辑器所在窗口.
 
