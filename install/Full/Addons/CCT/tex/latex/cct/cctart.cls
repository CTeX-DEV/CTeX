%& -no-cctspace
%
% $Id: cctart.cls,v 1.4 2005/08/30 09:23:46 zlb Exp $
%
% `cctart' class derived from the 'article' class.

\NeedsTeXFormat{LaTeX2e}[1994/12/01]
\ProvidesClass{cctart}[2004/10/14 Derived from the `article' class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass[a4paper]{article}[1996/10/31]
\RequirePackage{cctbase}[2003/01/10]

%
% Redefine some names
\renewcommand\contentsname{目　录}
\renewcommand\listfigurename{插图目录}
\renewcommand\listtablename{表格目录}
\renewcommand\refname{参考文献}
\renewcommand\indexname{索　引}
\renewcommand\figurename{\rm 图}
\renewcommand\tablename{\bf 表}
\renewcommand\abstractname{摘　要}
\renewcommand\partname{第\chnno{part}部分}
\renewcommand\appendixname{附录~\thesection}

% headings
\if@twoside
  \def\ps@headings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
%org  \def\@evenhead{\thepage\hfil\slshape\leftmark}%
%org  \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
      \def\@evenhead{\pushziti\thepage\hfil\slshape\leftmark\popziti}%   !!!
      \def\@oddhead{{\pushziti\slshape\rightmark}\hfil\thepage\popziti}% !!!
      \let\@mkboth\markboth
    \def\sectionmark##1{%
%org  \markboth {\MakeUppercase{%
      \markboth {%                         !!!
        \ifnum \c@secnumdepth >\z@
%org      \thesection\quad
          \sectionname\ \ %                !!!
        \fi
%org    ##1}}{}}%
        ##1}{}}%                           !!!
    \def\subsectionmark##1{%
      \markright {%
        \ifnum \c@secnumdepth >\@ne
%org      \thesubsection\quad
          \subsectionname\ \ %             !!!
        \fi
        ##1}}}
\else
  \def\ps@headings{%
    \let\@oddfoot\@empty
%org \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \def\@oddhead{\pushziti{\slshape\rightmark}\hfil\thepage\popziti}%  !!!
    \let\@mkboth\markboth
    \def\sectionmark##1{%
%org  \markright {\MakeUppercase{%
      \markright {%                       !!!
        \ifnum \c@secnumdepth >\m@ne
%org      \thesection\quad
          \sectionname\ \ %               !!!
        \fi
%org    ##1}}}}
        ##1}}}%                           !!!
\fi
\ps@headings%                             !!!

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >\m@ne
      \refstepcounter{part}%
%org  \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
      \addcontentsline{toc}{part}{\partname\hspace{1em}#1}%      !!!
      \protected@xdef\@currentlabel{\partname}%			 !!!
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    {\parindent \z@ \raggedright
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >\m@ne
%org   \Large\bfseries \partname~\thepart
       \Large\bfseries \partname \quad%          !!!
     \fi
%org \huge \bfseries #2%
     \Large \bfseries #2%                        !!!
     \markboth{}{}\par}%
    \nobreak
    \vskip 3ex
    \@afterheading}%
\def\@spart#1{%
    {\parindent \z@ \raggedright
     \interlinepenalty \@M
     \normalfont
%org \huge \bfseries #1\par}%
     \Large \bfseries #1\par}%                !!!
     \nobreak
     \vskip 3ex
     \@afterheading}%

\renewcommand\section{\@startsection
			{section}{1}{\z@}%   {name}{depth}{}
		        {3.5ex \@plus1ex \@minus .2ex}% leave parindent
		        {2.3ex \@plus.2ex}%
		        {\protected@xdef\@currentlabel{\sectionname}%
			 \reset@font\large\bfseries\sectionformat}}%
\newcommand\sectionname{\S\thesection}
\newcommand\sectionformat{\centering}

\renewcommand\subsection{\@startsection
			{subsection}{2}{\z@}%   {name}{depth}{}
		        {1.75ex \@plus.5ex \@minus .1ex}% leave parindent
		        {1.15ex \@plus.1ex}%
		        {\protected@xdef\@currentlabel{\subsectionname}%
			 \reset@font\normalsize\bfseries\subsectionformat}}
\newcommand\subsectionname{\sectionname.\arabic{subsection}}
\newcommand\subsectionformat{}

\renewcommand\subsubsection{\@startsection
			{subsubsection}{3}{\z@}%   {name}{depth}{}
		        {1.75ex \@plus 0.5ex \@minus .1ex}% positive->leave parindent
		        {1.15ex \@plus.1ex}%
		        {\protected@xdef\@currentlabel{\subsubsectionname}%
			 \reset@font\normalsize\bfseries\subsubsectionformat}}
\newcommand\subsubsectionname{\subsectionname.\arabic{subsubsection}}
\newcommand\subsubsectionformat{}

% appendix
\let\CCT@appendix@bak\appendix
\renewcommand\appendix{\CCT@appendix@bak
  \renewcommand\sectionname{\appendixname}}

% abstract
\renewenvironment{abstract}{%
      \leftskip=2\ccwd \rightskip=2\ccwd
      \small\parindent2\ccwd
      \bigskip
      \begin{center}%
        {\bfseries \abstractname\vspace{\z@}}%
      \end{center}%
      \par\nopagebreak\medskip\nopagebreak}
    {\par\bigskip}

%
% Change definition of `thebibliography' environment
\renewenvironment{thebibliography}[1]
     {\section*{\refname
%org        \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}}%
        \@mkboth{\refname}{\refname}}%                                  !!!
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \small%                                                    !!!
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

%
% Remove colon in \caption
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
%org  \sbox\@tempboxa{#1: #2}%
  \sbox\@tempboxa{#1~~#2}%					!!!
  \ifdim \wd\@tempboxa >\hsize
%org    #1: #2\par
    #1~~#2\par%							!!!
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

% set default \pagestyle to 'plain'
\pagestyle{plain}

\endinput
