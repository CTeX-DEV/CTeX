%%
%% This is file `PostDocRep.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% PostDocRep.dtx  (with options: `cls')
%% 
%% This is a generated file.
%% 
%% Copyright 2005-2006
%% CTEX.ORG and any individual authors listed elsewhere in this file.
%% 
%% This file was generated from file(s) of the PostDocRep package project.
%% ----------------------------------------------------------------------
%% 
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.2
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.2 or later is part of all distributions of LaTeX
%% version 1999/12/01 or later.
%% 
%% This file may only be distributed together with a copy of original
%% source files. You may however distribute original source files
%% without such generated files. Copying of this file is authorized
%% only if either:
%% (1) you make absolutely no changes to your copy, including name; OR
%% (2) if you do make changes, you first rename it to some other name.
%% 
%% To produce the documentation run the original source files ending
%% with `.dtx' through LaTeX.
%% 
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{PostDocRep}
  [2009/09/23 v0.1e PostDocRep
   document class]
\newif\ifPDR@typeinfo \PDR@typeinfotrue
\DeclareOption{notypeinfo}{\PDR@typeinfofalse}
\newif\ifPDR@dvips \PDR@dvipsfalse
\DeclareOption{dvips}{\PDR@dvipstrue}
\DeclareOption{dvipdfm}{\PDR@dvipsfalse}
\DeclareOption{pdftex}{\PDR@dvipsfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions
\LoadClass[cs4size,a4paper,fancyhdr,fntef]{ctexbook}[2005/11/25]
%% check pdfTeX mode
\RequirePackage{ifpdf}
%% math packages
\RequirePackage{amsmath,amsthm,amsfonts,amssymb,bm}
%% graphics packages
\RequirePackage{graphicx}
%% sort and compress citations
\RequirePackage[sort&compress,numbers]{natbib}
%% packages and settings depend on PDF mode
\ifpdf   % We're running pdfTeX in PDF mode
  \RequirePackage[pdftex]{hyperref}
  \DeclareGraphicsExtensions{.pdf}
\else    % We're not running pdfTeX, or running pdfTeX in DVI mode
  \ifPDR@dvips
    \RequirePackage[dvips]{hyperref}
    \RequirePackage{psfrag}
    \AtBeginDvi{\special{pdf:tounicode GBK-EUC-UCS2}} % GBK -> Unicode
  \else
    \RequirePackage[dvipdfm]{hyperref}
  \fi
  \DeclareGraphicsExtensions{.eps,.ps}
\fi
\hypersetup{CJKbookmarks,%
       bookmarksnumbered,%
              colorlinks,%
               linkcolor=blue,%
               citecolor=blue,%
              plainpages=false,%
            pdfstartview=FitH}
\AtEndOfPackage{\makeatletter\input{PostDocRep.cfg}\makeatother}
\oddsidemargin 1.5 true cm
\if@twoside
  \evensidemargin 0 true cm
\else
  \evensidemargin 1.5 true cm
\fi
\textheight 21 true cm
\textwidth 14.5 true cm
\headheight 15pt
\parskip 0.5ex plus 0.25ex minus 0.25ex
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
  \thispagestyle{empty}%
  \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}
\renewcommand{\floatpagefraction}{0.80}
\bibliographystyle{plain}
\newcommand\PDRspace{\protect\CTEX@spaceChar\protect\CTEX@spaceChar}
\def\PDR@getfileinfo#1 #2 #3\relax#4\relax{%
  \def\PDRfiledate{#1}%
  \def\PDRfileversion{#2}%
  \def\PDRfileinfo{#3}}%
\expandafter\ifx\csname ver@PostDocRep.cls\endcsname\relax
  \edef\reserved@a{\csname ver@ctextemp_PostDocRep.cls\endcsname}
\else
  \edef\reserved@a{\csname ver@PostDocRep.cls\endcsname}
\fi
\expandafter\PDR@getfileinfo\reserved@a\relax? ? \relax\relax
\def\PDR@underline[#1]#2{%
  \CTEXunderline{\hbox to #1{\hfill#2\hfill}}}
\def\PDRunderline{\@ifnextchar[\PDR@underline\CTEXunderline}
\newcommand\classification[1]{\def\PDR@value@classification{#1}}
\newcommand\confidential[1]{\def\PDR@value@confidential{#1}}
\newcommand\UDC[1]{\def\PDR@value@UDC{#1}}
\newcommand\serialnumber[1]{\def\PDR@value@serialnumber{#1}}
\newcommand\school[1]{\def\PDR@value@school{#1}}
\renewcommand\title[2][\PDR@value@title]{%
  \def\PDR@value@title{#2}
  \def\PDR@value@titlemark{\MakeUppercase{#1}}}
\renewcommand\author[1]{\def\PDR@value@author{#1}}
\newcommand\advisor[1]{\def\PDR@value@advisor{#1}}
\newcommand\workdate[2]{\def\PDR@value@begindate{#1}%
  \def\PDR@value@enddate{#2}}
\newcommand\submitdate[1]{\def\PDR@value@submitdate{#1}}
\newcommand\address[1]{\def\PDR@value@address{#1}}
\newcommand\englishtitle[1]{\def\PDR@value@englishtitle{#1}}
\newcommand\major[1]{\def\PDR@value@major{#1}}
\newcommand\submajor[1]{\def\PDR@value@submajor{#1}}
\newcommand\institute[1]{\def\PDR@value@institute{#1}}
\renewcommand\maketitle{%
  \cleardoublepage
  \thispagestyle{empty}
  \begin{center}
    \bf\songti\zihao{-4}
      \PDR@label@classification~
      \PDRunderline[100pt]{\PDR@value@classification}
        \hfill
      \PDR@label@confidential~
      \PDRunderline[100pt]{\PDR@value@confidential}
    \vskip 10pt
      \PDR@label@UDC~
      \PDRunderline[108pt]{\PDR@value@UDC}
        \hfill
      \PDR@label@serialnumber~
      \PDRunderline[100pt]{\PDR@value@serialnumber}
    \vskip \stretch{2}
      \bf\songti\zihao{-1} \PDR@value@school \\
      \PDR@label@report
    \vskip \stretch{2}
      \bf\heiti\zihao{3} \PDRunderline{~\PDR@value@title~}
    \vskip \stretch{1}
      \bf\kaishu\zihao{4} \PDRunderline{~\PDR@value@author~}
    \vskip \stretch{2}
    \bf\fangsong\zihao{4}
    \def\tabcolsep{1pt}
    \def\arraystretch{1.5}
    \begin{tabular}{lc}
    \ifx\PDR@value@advisor\@empty\else
      \PDR@label@advisor &
      \PDRunderline[200pt]{\PDR@value@advisor}
    \\
    \fi
      \PDR@label@workdate &
      \PDRunderline[200pt]{\PDR@value@begindate --- \PDR@value@enddate}
    \\
      \PDR@label@submitdate &
      \PDRunderline[200pt]{\PDR@value@submitdate}
    \end{tabular}
    \vskip \stretch{2}
    \PDR@value@address \\
    \PDR@value@submitdate
  \end{center}
  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \ifPDR@typeinfo
      \vspace*{\stretch{1}}
      \begin{footnotesize}
        \noindent
        Typeset by \LaTeXe{} at \CTEX@todayold \\
        With package \texttt{PostDocRep} \PDRfileversion{} of C\TeX{}.ORG
      \end{footnotesize}
    \fi
    \cleardoublepage
  \fi
  \thispagestyle{empty}
  \begin{center}
    \vspace*{\stretch{1}}
      \bf\heiti\zihao{2} \PDR@value@title
    \vskip 10pt
      \bf\heiti\zihao{3} \PDR@value@englishtitle
    \vskip \stretch{5}
    \bf\fangsong\zihao{4}
    \def\tabcolsep{1pt}
    \def\arraystretch{1.5}
    \begin{tabular}{lc}
      \PDR@label@author &
      \PDRunderline[200pt]{\PDR@value@author}
    \\
    \ifx\PDR@value@advisor\@empty\else
      \PDR@label@advisor &
      \PDRunderline[200pt]{\PDR@value@advisor}
    \\
    \fi
      \PDR@label@major &
      \PDRunderline[200pt]{\PDR@value@major}
    \\
      \PDR@label@submajor &
      \PDRunderline[200pt]{\PDR@value@submajor}
    \\
      \PDR@label@begindate &
      \PDRunderline[200pt]{\PDR@value@begindate}
    \\
      \PDR@label@enddate &
      \PDRunderline[200pt]{\PDR@value@enddate}
    \end{tabular}
    \vskip \stretch{5}
    \bf\fangsong\zihao{4}
    \def\tabcolsep{1pt}
    \def\arraystretch{1.5}
    \begin{tabular}{lc}
      \PDR@label@institute &
      \PDRunderline[250pt]{\PDR@value@institute}
    \\
      \PDR@label@submitdate &
      \PDRunderline[250pt]{\PDR@value@submitdate}
    \end{tabular}
  \end{center}
  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \cleardoublepage
  \fi
}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
}
\pagestyle{fancy}
  \fancyhf{}
  \fancyhead[RE]{\small \PDR@value@titlemark}
  \fancyhead[LO]{\small \leftmark}
  \fancyhead[LE,RO]{\small ~\thepage~}
\newenvironment{abstract}
  {\Nchapter{\PDR@label@abstract}}
  {}
\newcommand\keywords[1]{%
  \vspace{2ex}\noindent{\heiti \PDR@label@keywords} #1}
\newenvironment{englishabstract}
  {\Nchapter{\PDR@label@englishabstract}}
  {}
\newcommand\englishkeywords[1]{%
  \vspace{2ex}\noindent{\bf \PDR@label@englishkeywords} #1}
\renewcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \Nchapter{\contentsname}%
    \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    }
\addtocontents{toc}{\let\string\CTEX@spaceChar\relax}
\newcommand*\Nchapter[1]{%
  \if@mainmatter%
    \@mainmatterfalse%
    \chapter{#1}%
    \@mainmattertrue%
  \else
    \chapter{#1}%
  \fi}
\def\@dottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \vskip \z@ \@plus.2\p@
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #3\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     {#4}\nobreak
     \leaders\hbox{$\m@th\mkern 1.5mu\cdot\mkern 1.5mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
     \par}%
  \fi}
\renewcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \setlength\@tempdima{3em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries #1
       \leaders\hbox{$\m@th\mkern 1.5mu\cdot\mkern 1.5mu$}
       \hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak
      \leaders\hbox{$\m@th\mkern 1.5mu\cdot\mkern 1.5mu$}
      \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\renewenvironment{thebibliography}[1]
     {\Nchapter{\bibname}%
      \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\newenvironment{publications}[1]
     {\Nchapter{\PDR@label@publications}%
      \@mkboth{\MakeUppercase\PDR@label@publications}
              {\MakeUppercase\PDR@label@publications}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `publications' environment}}%
      \endlist}
\newenvironment{resume}
  {\Nchapter{\PDR@label@resume}}
  {}
\newenvironment{resumesection}[1]
  {{\noindent\normalfont\bfseries #1}
   \list{}{\labelwidth\z@
           \leftmargin 2\ccwd}
   \item\relax}
  {\endlist}
\newenvironment{resumelist}[1]
  {{\noindent\normalfont\bfseries #1}
   \list{}{\labelwidth\z@
           \leftmargin 4\ccwd
           \itemindent -2\ccwd
           \listparindent\itemindent}
   \item\relax}
  {\endlist}
\renewenvironment{thanks}
  {\Nchapter{\PDR@label@thanks}}
  {}
\setcounter{secnumdepth}{4}
\newtheoremstyle{break}% name
  {}%      Space above, empty = `usual value'
  {}%      Space below
  {\itshape}% Body font
  {}%         Indent amount (empty = no indent, \parindent = para indent)
  {\bfseries}% Thm head font
  {.}%        Punctuation after thm head
  {\newline}% Space after thm head: \newline = linebreak
  {}%         Thm head spec
\endinput
%%
%% End of file `PostDocRep.cls'.
