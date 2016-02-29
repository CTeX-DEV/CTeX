                          ==================
                            zhmCJK Package
                          ==================

Introduction
------------

zhmCJK is a package written to ease the complex CJK fonts setup.  All CJK
fonts may share the same .tfm metrics.  The package sets the NFSS font
definition and actual font maappings using TeX macros dynamically.  As a
result, zhmCJK provides similar faculties and interface of xeCJK, TrueType CJK
fonts are used to generate PDF output with pdfTeX or DVIPDFMx driver.

This package is licensed under LPPL.

Installation
------------

This package consists of the files zhmCJK.dtx,
                                zhmCJK.ins,
                                zhmCJK.lua,
          and the derived files zhmCJK.sty,
                                zhmCJK.pdf,
                                zhmCJK-test.tex,
                                README.txt,               (from zhmCJK.dtx)
                                zhmCJK.map,
                                texfonts.map,
                                zhmCJK.tfm,
                                fallback/zhm*/zhm**.tfm.  (from zhmCJK.lua)

* Compile zhmCJK.lua with command

      texlua zhmCJK.lua map

  to generate zhmCJK.map, texfonts.map, zhmCJK.tfm.

  Or, for MiKTeX only, use

      texlua zhmCJK.lua nomap

  to generate fallback/zhm*/zhm**.tfm. (32 subdirectories, 8192 TFM files)

* Compile zhmCJK.ins using an 8-bit TeX engine to obtain zhmCJK.sty,
  zhmCJK-test.tex and this README.txt file.

* Compile zhmCJK.dtx using pdflatex or latex+dvipdfmx to obtain the
  documentation zhmCJK.pdf.

* Copy the files into proper directories searched by TeX.
  TDS tree:

    TEXMF/doc/latex/zhmCJK/zhmCJK-test.tex
    TEXMF/doc/latex/zhmCJK/zhmCJK.pdf
    TEXMF/doc/latex/zhmCJK/README.txt
    TEXMF/fonts/map/fontname/texfonts.map
    TEXMF/fonts/map/fontname/zhmCJK.map
    TEXMF/fonts/tfm/zhmCJK/zhmCJK.tfm
    TEXMF/source/latex/zhmCJK/zhmCJK.dtx
    TEXMF/source/latex/zhmCJK/zhmCJK.ins
    TEXMF/source/latex/zhmCJK/zhmCJK.lua
    TEXMF/tex/latex/zhmCJK/zhmCJK.sty

  If texfonts.map already exists, merge the contents of old texfonts.map and
  the new one, or simply append this line to the old texfonts.map:

    include zhmCJK.map

  Or, for MiKTeX only, instead of copying texfonts.map, zhmCJK.map and
  zhmCJK.tfm, copy all fallback/zhm*/zhm**.tfm into:

    TEXMF/fonts/tfm/zhmCJK/fallback/zhm*/zhm**.tfm

* Run texhash to refresh file name data base.

Basic Usage
-----------

zhmCJK provides similar syntax to xeCJK, while the underlying package is CJK
under pdfTeX or DVIPDFMx engine.  A TeX source file is encoded in UTF-8 by
default.

The package provides the following commands to define a CJK font family:

    \setCJKmainfont[options]{ttf-file-name}
    \setCJKsansfont[options]{ttf-file-name}
    \setCJKmonofont[options]{ttf-file-name}
    \setCJKfamilyfont{family}[options]{ttf-file-name}

For example, this setup some Chinese fonts on MS Windows:

    \usepackage{zhmCJK}
    \setCJKmainfont[BoldFont=simhei.ttf, ItalicFont=simkai.ttf]{simsun.ttc}

You can read the PDF document (in Chinese) for more detailed explanations.

Author
------

Leo Liu

Email: leoliu.pku@gmail.com

If you are interested in the process of development you may observe

    http://code.google.com/p/leoliu-tex-pkg/

--- end of README ---
