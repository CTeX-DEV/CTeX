%& -no-cctspace
%
% $Id: cctbook.cls,v 1.6 2005/08/30 09:23:46 zlb Exp $
% `cctbook' class derived from the `book' class.

\NeedsTeXFormat{LaTeX2e}[1994/12/01]
\ProvidesClass{cctbook}[2005/04/12 Derived from the `book' class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions
\LoadClass[a4paper]{book}[1996/10/31]
\RequirePackage{cctbase}[2003/01/10]

%
% Redefine names
\renewcommand\contentsname{目　录}
\renewcommand\listfigurename{插图目录}
\renewcommand\listtablename{表格目录}
\renewcommand\bibname{参考文献}
\renewcommand\indexname{索　引}
\renewcommand\figurename{\rm 图}
\renewcommand\tablename{\bf 表}

\renewcommand\partname{第\chnno{part}部分}
\renewcommand\chaptername{第\chnno{chapter}章}
\renewcommand\appendixname{附录\chnno{chapter}}

% Change format of the running heads. Insert \pushziti and \popziti
\if@twoside
  \def\ps@headings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
%org  \def\@evenhead{\thepage\hfil\slshape\leftmark}%
%org  \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
      \def\@evenhead{\pushziti\thepage\hfil\slshape\leftmark\popziti}%    !!!
      \def\@oddhead{\pushziti{\slshape\rightmark}\hfil\thepage\popziti}%  !!!
      \let\@mkboth\markboth
    \def\chaptermark##1{%
%org  \markboth {\MakeUppercase{%
      \markboth {%                         !!!
        \ifnum \c@secnumdepth >\m@ne
          \if@mainmatter
%org        \@chapapp\ \thechapter. \ %
            \chaptername \ \ %             !!!
          \fi
        \fi
%org    ##1}}{}}%
        ##1}{}}%                           !!!
    \def\sectionmark##1{%
%org  \markright {\MakeUppercase{%
      \markright {%                         !!!
        \ifnum \c@secnumdepth >\z@
%org      \thesection. \ %
          \sectionname\ \ %                 !!!
        \fi
%org    ##1}}}}
        ##1}}}%                             !!!
\else
  \renewcommand\ps@headings{%
    \let\@oddfoot\@empty
%org \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \def\@oddhead{\pushziti{\slshape\rightmark}\hfil\thepage\popziti}%  !!!
    \let\@mkboth\markboth
    \def\chaptermark##1{%
%org  \markright {\MakeUppercase{%
      \markright {%                         !!!
        \ifnum \c@secnumdepth >\m@ne
          \if@mainmatter
%org        \@chapapp\ \thechapter. \ %
            \chaptername \ \ %              !!!
          \fi
        \fi
%org    ##1}}}}
        ##1}}}%                             !!!
\fi
\ps@headings

% Define part
\def\@part[#1]#2{%
    \thispagestyle{empty}%                       !!!
    \ifnum \c@secnumdepth >-2\relax
      \refstepcounter{part}%
      \protected@xdef\@currentlabel{\partname}%  !!!
%org  \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
      \addcontentsline{toc}{part}{\partname\hspace{1em}#1}%   !!!
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    \markboth{}{}%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >-2\relax
%org   \huge\bfseries \partname~\thepart
       \Huge\bfseries \partname%         !!!
       \par
       \vskip 20\p@
     \fi
     \Huge\bfseries #2\par}%
    \@endpart}

% Define chapter
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
			 \protected@xdef\@currentlabel{\chaptername}%  !!!
                         \typeout{\@chapapp \space \thechapter.}%
                         \addcontentsline{toc}{chapter}%
%org                               {\protect\numberline{\thechapter}#1}%
                                   {\protect\numberline{\chaptername}#1}%  !!!
                       \else
                         \addcontentsline{toc}{chapter}{#1}%
                       \fi
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}
\def\@chapapp{Chapter}%                   !!!
\def\chapterformat{\Large\bfseries\centering}%      |||
\def\@makechapterhead#1{%
%org  \vspace*{50\p@}%
%org  {\parindent \z@ \raggedright \normalfont
%org    \ifnum \c@secnumdepth >\m@ne
%org      \if@mainmatter
%org        \huge\bfseries \@chapapp\space \thechapter
%org        \par\nobreak
%org        \vskip 20\p@
%org      \fi
%org    \fi
%org    \interlinepenalty\@M
%org    \Huge \bfseries #1\par\nobreak
%org    \vskip 40\p@
  \vspace*{-\headsep}\vspace*{-\headheight}\vspace*{15\p@}%      !!!
  {\chapterformat%						 !!!
    \ifnum \c@secnumdepth >\m@ne%                                !!!
      \if@mainmatter%                                            !!!
        \chaptername \quad #1 \par\nobreak%      !!!
      \else%                                                     !!!
        #1 \par\nobreak%                         !!!
      \fi%                                                       !!!
    \fi%                                                         !!!
    \vskip 15\p@%                                                !!!
  }}
\def\@makeschapterhead#1{%
%org  \vspace*{50\p@}%
%org  {\parindent \z@ \raggedright
%org    \normalfont
%org    \interlinepenalty\@M
%org    \Huge \bfseries  #1\par\nobreak
%org    \vskip 40\p@
  \vspace*{-\headsep}\vspace*{-\headheight}\vspace*{15\p@}%   !!!
  {\chapterformat%					      !!!
    \interlinepenalty\@M%                                     !!!
    #1\par\nobreak%                                           !!!
    \vskip 15\p@%                                             !!!
  }}

% Change definition of section
\renewcommand\section{\@startsection
			{section}{2}{\z@}%   {name}{depth}{}
		        {3.5ex \@plus 1ex \@minus .2ex}% positive->leave parindent
		        {2.3ex \@plus.2ex}%
		        {\protected@xdef\@currentlabel{\sectionname}%
			 \reset@font\large\bfseries\sectionformat}}
\newcommand\sectionname{\S\thechapter.\arabic{section}}
\newcommand\sectionformat{\centering}

% Change definition of \subsection
\renewcommand\subsection{\@startsection
			{subsection}{3}{\z@}%   {name}{depth}{}
		        {1.75ex \@plus 0.5ex \@minus .1ex}% positive->leave parindent
		        {1.15ex \@plus.1ex}%
		        {\protected@xdef\@currentlabel{\subsectionname}%
			 \reset@font\normalsize\bfseries\subsectionformat}}
\newcommand\subsectionname{\sectionname.\arabic{subsection}}
\newcommand\subsectionformat{}

% Change definition of \subsubsection
\renewcommand\subsubsection{\@startsection
			{subsubsection}{4}{\z@}%   {name}{depth}{}
		        {1.75ex \@plus 0.5ex \@minus .1ex}% positive->leave parindent
		        {1.15ex \@plus.1ex}%
		        {\protected@xdef\@currentlabel{\subsubsectionname}%
			 \reset@font\normalsize\bfseries\subsubsectionformat}}
\newcommand\subsubsectionname{\subsectionname.\arabic{subsubsection}}
\newcommand\subsubsectionformat{}

% Set maxi. depth of numbered sections to 4 (\subsubsection).
\setcounter{secnumdepth}{4}

%
% Change definition of \appendix
\renewcommand\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \renewcommand\@chapapp{Appendix}
  \renewcommand\thechapter{\Alph{chapter}}%
  \renewcommand\chaptername{\appendixname}}%

% Rewrite theindex environment (removing \MakeUppercase)
%%%--- Use `multicol'
%%%\RequirePackage{multicol}
%%%\renewenvironment{theindex}
%%%                 {\chapter{\indexname}
%%%                  \vskip 15pt
%%%                  \begin{multicols}{2}%
%%%                  \let\item\@idxitem}
%%%                 {\end{multicols}}
\renewenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
		\addcontentsline{toc}{chapter}{\indexname}%   !!!
                \twocolumn[\@makeschapterhead{\indexname}]%
%org                \@mkboth{\MakeUppercase\indexname}%
%org                        {\MakeUppercase\indexname}%
                \@mkboth{\indexname}%		!!!
                        {\indexname}%		!!!
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}

% Change definition of \thebibliography environment to use smaller font.
\renewenvironment{thebibliography}[1]
%org     {\chapter*{\bibname
%org    \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}}%
     {\def\chaptername{}\chapter{\bibname}%                            !!!
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \small%                                               !!!
      \sloppy
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
  \sbox\@tempboxa{#1~~#2}%				!!!
  \ifdim \wd\@tempboxa >\hsize
%org    #1: #2\par
    #1~~#2\par%						!!!
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

\endinput
