%%
%% This is file `ncsuthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% ncsuthesis.dtx  (with options: `class')
%% --------------------------------------------------------------------
%% ncsuthesis --- A thesis class conforming to NC State ETD guidelines.
%% E-mail: jmhykes@ncsu.edu
%% Released under the LaTeX Project Public License v1.3c or later
%% See http://www.latex-project.org/lppl.txt
%% --------------------------------------------------------------------
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ncsuthesis}[2010/02/24 v0.2 NC State ETD conformant thesis class]
%% -------------------------------------------------------------------------- %%
%% ------------------------------ Thesis type ------------------------------- %%
%% -------------------------------------------------------------------------- %%
\newcommand{\ncsu@thesistype}{phd}
\DeclareOption{phd}{\renewcommand{\ncsu@thesistype}{phd}}
\DeclareOption{ms}{\renewcommand{\ncsu@thesistype}{ms}}

%% Spacing options
\newcommand{\ncsu@defaultspacing}{\onehalfspacing}
\DeclareOption{singlespacing}{
     \renewcommand{\ncsu@defaultspacing}{\singlespacing}}
\DeclareOption{onehalfspacing}{
     \renewcommand{\ncsu@defaultspacing}{\onehalfspacing}}
\DeclareOption{doublespacing}{
     \renewcommand{\ncsu@defaultspacing}{\doublespacing}}

\newenvironment{lscape}{\begin{lscapenum}}{\end{lscapenum}}
\DeclareOption{hardcopy}{
    \renewenvironment{lscape}{\begin{lscapenotnum}}{\end{lscapenotnum}}
}

\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{book}}
\DeclareOption{10pt}{\PassOptionsToClass{\CurrentOption}{book}}
\DeclareOption{11pt}{\PassOptionsToClass{\CurrentOption}{book}}
\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{book}}

\DeclareOption*{\PackageWarning{ncsuthesis}{Unknown option `\CurrentOption'. Ignoring}}
\ExecuteOptions{phd,onehalfspacing} % the default option is <phd, onehalfspacing>
\ProcessOptions
\LoadClass[openany,oneside,titlepage]{book}

\RequirePackage{setspace}
\RequirePackage{hyphenat}
\RequirePackage{nolbreaks}
\RequirePackage{ifthen}
\RequirePackage{sectsty}
\RequirePackage[titles]{tocloft}
\RequirePackage{graphicx}
\RequirePackage[nottoc]{tocbibind} % includes lof, lot, refs in toc
\RequirePackage{calc}

%%----------------------------------------------------------------------------%%
%%---------------------------- Formatting Options ----------------------------%%
%% -------------------------------------------------------------------------- %%
%% Capital letter height
\newlength{\ncsu@capitalheight}
\setlength{\ncsu@capitalheight}{1.6ex}
\settoheight{\ncsu@capitalheight}{D}

%% Line height
\newlength{\ncsu@lineheight}
\setlength{\ncsu@lineheight}{2.0ex}

%% We must add two double spaces plus one capital-height (for the page number)
%%  to footskip.  Footskip is measured from the top of the bottom margin.
%%  (See geometry package documentation, note that includefoot option is used.)
\ncsu@defaultspacing
\newlength{\ncsu@footskip}
\setlength{\ncsu@footskip}{\ncsu@capitalheight}
\addtolength{\ncsu@footskip}{2\baselineskip}
\RequirePackage[includefoot,
                margin=1in,
                lmargin=1.25in,
                footskip=\ncsu@footskip]{geometry}

%% -------------------------------------------------------------------------- %%
%% Disposition format -- any titles, headings, section titles
\newcommand{\ncsu@dispositionformat}{}
\allsectionsfont{\ncsu@dispositionformat}
\providecommand{\dispositionformat}[1]{
    \renewcommand{\ncsu@dispositionformat}{#1}
    \allsectionsfont{\ncsu@dispositionformat}
}

%% Heading/Chapter/Section format
\newcommand{\ncsu@headingformat}{\ncsu@dispositionformat}
\providecommand{\headingformat}[1]{
    \renewcommand{\ncsu@headingformat}{\ncsu@dispositionformat #1}
}

%% -------------------------------------------------------------------------- %%
%% Headers/footers - page number
\pagestyle{plain}

%% -------------------------------------------------------------------------- %%
%% Vertical space around tables and figures, triple spacing
\setlength{\textfloatsep}{3\ncsu@lineheight}
\setlength{\intextsep}{3\ncsu@lineheight}

%%----------------------------------------------------------------------------%%
%%---------------------------  Content Options -------------------------------%%
%% -------------------------------------------------------------------------- %%
%% Author name
\newcommand{\ncsu@authorfirstmiddle}{First Middle}
\newcommand{\ncsu@authorlast}{Last}

%% Command to test for period after middle name
\newboolean{@ncsu@needsperiod}
\newcommand{\ncsu@testlastchar}[2]{%
    \ifthenelse{\equal{#2}{\relax}}{
        \ifthenelse{\equal{#1}{.}}{%
            \setboolean{@ncsu@needsperiod}{false}
        }{% #1 != .
            \setboolean{@ncsu@needsperiod}{true}
        }
        \let\next=\relax
    }
    {% #2 != relax
        \let\next=\ncsu@testlastchar
    }
    \next#2
}

\providecommand{\student}[2]{
    \renewcommand{\ncsu@authorfirstmiddle}{#1}
    \renewcommand{\ncsu@authorlast}{#2}
    \ncsu@testlastchar#1\relax
    \author{\ncsu@authorfirstmiddle{} \ncsu@authorlast}
}

%% Degree year - in case the degree year doesn't match the current year.
\newcommand{\ncsu@year}{\the\year}
\providecommand{\degreeyear}[1]{
    \renewcommand{\ncsu@year}{#1}
}

%% -------------------------------------------------------------------------- %%
%% Thesis Title
\newcommand{\ncsu@thesistitle}{My Thesis Title}
\providecommand{\thesistitle}[1]{\renewcommand{\ncsu@thesistitle}{#1}}

%% -------------------------------------------------------------------------- %%
%% ---------------------  Chapter Commands ---------------------------------- %%
%% -------------------------------------------------------------------------- %%

%% -------------------------------------------------------------------------- %%
%%  Redefine the \chapter* driver \@makeschapterhead
%% Center the chapter* head:
\AtBeginDocument{% at begin doc is necessary since fncychap
                 %  redefines \@makeschapterhead
    \renewcommand{\@makeschapterhead}[1]{%
        {\parindent0pt\centering\ncsu@headingformat#1\par\nobreak\vskip25pt}%
    }
}

%% -------------------------------------------------------------------------- %%
%% Abstract page commands
%%  - hyphnat package \nohyphens prevents title from being hyphenated.
%%  - \nolbreaks removes any line breaks in title (but you must use \linebreak
%%     instead of \\
\newcommand{\abstractname}{Abstract}
\newenvironment{abstract}{%
   \singlespacing
   \titlepage
   \chapter*{\abstractname}
   \MakeUppercase{\ncsu@authorlast{}, \ncsu@authorfirstmiddle{}}%
   \ifthenelse{\boolean{@ncsu@needsperiod}}{\@. }{~}%
    \nohyphens{\nolbreaks{\ncsu@thesistitle}.
   (Under the direction of \ncsu@chair.)}\\

   \ncsu@defaultspacing
   \thispagestyle{empty}
   \pagestyle{empty}
}%
{\endtitlepage \pagestyle{plain}}

%% -------------------------------------------------------------------------- %%
%% Abstract page commands
\newcommand{\makecopyrightpage}{
    \begin{titlepage}
    \centering
      \quad
      \vspace{0.35\textheight}

      \copyright{} Copyright \ncsu@year{} by \@author \\[1em]
      All Rights Reserved

      \vfill
    \end{titlepage}
}

%% -------------------------------------------------------------------------- %%
%% Title page commands

\newcommand{\ncsu@committeesize}{4}
\providecommand{\committeesize}[1]{\renewcommand{\ncsu@committeesize}{#1}}

\newcommand{\ncsu@chair}{Advisor Q. Chair}
\providecommand{\chair}[1]{\renewcommand{\ncsu@chair}{#1}}

\newcommand{\ncsu@memberI}{Member 1 of Committee}
\providecommand{\memberI}[1]{\renewcommand{\ncsu@memberI}{#1}}

\newcommand{\ncsu@memberII}{Member 2 of Committee}
\providecommand{\memberII}[1]{\renewcommand{\ncsu@memberII}{#1}}

\newcommand{\ncsu@memberIII}{Member 3 of Committee}
\providecommand{\memberIII}[1]{\renewcommand{\ncsu@memberIII}{#1}}

\newcommand{\ncsu@titlepageparagraph}{
 \ifthenelse{\equal{\ncsu@thesistype}{phd}}{
   A dissertation submitted to the Graduate Faculty of\\
   North Carolina State University\\
   in partial fulfillment of the\\
   requirements for the Degree of\\
   Doctor of Philosophy
 }{} % end ifthenels phd
 \ifthenelse{\equal{\ncsu@thesistype}{ms}}{
   A thesis submitted to the Graduate Faculty of\\
   North Carolina State University\\
   in partial fulfillment of the\\
   requirements for the Degree of\\
   Master of Science
 }{} % end ifthenels phd
}

\newcommand{\ncsu@program}{Degree Program}
\providecommand{\program}[1]{\renewcommand{\ncsu@program}{#1}}

\newcommand{\ncsu@citystate}{Raleigh, North Carolina}

\newcommand{\ncsu@signatureline}[2][]{
    \begin{minipage}[t]{0.4\textwidth}
    \centering
     \hrule
     \vspace{0.5ex}
     #2\\ #1
    \end{minipage}
}

\newcommand{\ncsu@committeesignatures}{
  \ifthenelse{\ncsu@committeesize=3}{
    \begin{tabular}[t]{c@{\hspace{0.5in}}c}
       \ncsu@signatureline{\ncsu@memberI} &
       \ncsu@signatureline{\ncsu@memberII} \\[6.7em]
    \end{tabular}
    \ncsu@signatureline[Chair of Advisory Committee]{\ncsu@chair}
}{} % end ifthenelse = 3
  \ifthenelse{\ncsu@committeesize=4}{
    \begin{tabular}[t]{c@{\hspace{0.5in}}c}
       \ncsu@signatureline{\ncsu@memberI} &
       \ncsu@signatureline{\ncsu@memberII} \\[6em]
       \ncsu@signatureline{\ncsu@memberIII} &
       \ncsu@signatureline[Chair of Advisory Committee]{\ncsu@chair} \\
    \end{tabular}
}{} % end ifthenelse = 4
}

\newcommand{\maketitlepage}{
     \thispagestyle{empty}
     \clearpage
     \singlespacing
      \begin{center}
            \vfill
        \ncsu@thesistitle
            \vfill
        by \\
        \@author
            \vfill
       \ncsu@titlepageparagraph
           \vfill
       \ncsu@program\\[2.5\ncsu@lineheight]
       \ncsu@citystate\\[1\ncsu@lineheight]
       \ncsu@year
           \vfill
       APPROVED BY:
           \vfill
       \ncsu@committeesignatures
      \end{center}
     \clearpage
     \ncsu@defaultspacing
}

%% -------------------------------------------------------------------------- %%
%% ------------ Dedication, biography, and acknowledgements ----------------- %%
%% -------------------------------------------------------------------------- %%
%%  Template
\newcommand{\ncsu@dedbioack}[1]{
    \chapter*{{\ncsu@headingformat{#1}}}
}

%%  Dedication
\newenvironment{dedication}
{\ncsu@dedbioack{Dedication}}
{\clearpage}

%%  Biography
\newenvironment{biography}
{\ncsu@dedbioack{Biography}}
{\clearpage}

%%  Acknowledgements
\newenvironment{acknowledgements}
{\ncsu@dedbioack{Acknowledgements}}
{\clearpage}

%% -------------------------------------------------------------------------- %%
%% -------------------------  Table of Contents ----------------------------- %%
%% -------------------------------------------------------------------------- %%
\renewcommand{\contentsname}{Table of Contents}
\settowidth{\cftchapnumwidth}{\textbf{Chapter 00}}
\renewcommand{\cftchappresnum}{Chapter }
\renewcommand{\cftchapleader}{\cftdotfill{\cftsecdotsep}}
\newcommand{\thesistableofcontents}{
    \singlespacing
    \tableofcontents
    \clearpage
    \ncsu@defaultspacing
}

\renewcommand{\listfigurename}{List of Figures}
\settowidth{\cftfignumwidth}{Figure 00.00}
\renewcommand{\cftfigpresnum}{Figure }
\newcommand{\thesislistoffigures}{
    \singlespacing
    \listoffigures
    \clearpage
    \ncsu@defaultspacing
}

\renewcommand{\listtablename}{List of Tables}
\settowidth{\cfttabnumwidth}{Table 00.00}
\renewcommand{\cfttabpresnum}{Table }
\newcommand{\thesislistoftables}{
    \singlespacing
    \listoftables
    \clearpage
    \ncsu@defaultspacing
}

%% -------------------------------------------------------------------------- %%
%% ------------------------- Landscape Pages  ------------------------------- %%
%% -------------------------------------------------------------------------- %%
%%  Loading pdflscape package for page rotation
\RequirePackage{pdflscape}
%%  Loading fancyhdr package to change page numbering
\RequirePackage{fancyhdr}
%%  Loading sideways for sideways environment
\RequirePackage{rotating}

\newlength{\portraittextheight}
\setlength{\portraittextheight}{\textheight}
\addtolength{\portraittextheight}{\footskip}
\newlength{\portraittextwidth}
\setlength{\portraittextwidth}{\textwidth}

\RequirePackage{afterpage}
\RequirePackage{changepage}

%% Rotate page and page number
\newenvironment{lscapenum}
{
%%   The standard landscape environment does not rotate the margins and
%%   page number.  However, we want the margins (mostly) rotated as well
%%   as the page number.  To change the margins, we use the \changepage
%%   command from the \changepage package.  Since the \textheight and
%%   \textwidth dimensions get switched, we need to reduce the rotated
%%   \textheight by \ncsu@footskip and increase the \textwidth by the
%%   same measure.
%%
%%   The syntax of the \changepage command is
%% \changepage{textheight}{textwidth}{evensidemargin}{oddsidemargin}{columnsep}
%%            {topmargin}{headheight}{headsep}{footskip}
   \clearpage
   \changepage{\ncsu@footskip}{-\ncsu@footskip}{}{}{}{}{}{}{}
   \begin{landscape}
     \pagestyle{fancy}
     \fancyhead{} % clear all header fields
     \fancyfoot{} % clear all footer fields
     \renewcommand{\headrulewidth}{0pt}
     \rfoot{
       %% Since the header and footer are unrotated, we must manually
       %% place the page number.  The picture environment is included in
       %% standard LaTeX.
       \setlength{\unitlength}{\portraittextheight}
       \begin{picture}(0,0)
           \put(0.055,0.557){\begin{sideways}\thepage\end{sideways}} % page number
       \end{picture}
     }

}
{
   \end{landscape}
   %% The \textheight is too large leaving landscape environment
   %%  since we invoked the \changepage.  We manually reduce it.
   \addtolength{\textheight}{-\ncsu@footskip}

   %% \textheight controls 3 other variables, which must be updated.
   %% See \endlandscape definition in lscape.sty
   \global\@colht=\textheight
   \global\vsize=\textheight
   \global\@colroom=\textheight

   \pagestyle{plain}
}

%% Rotate page but NOT page number
\newenvironment{lscapenotnum}
{
   \begin{landscape}
}
{
   \end{landscape}
}

%% -------------------------------------------------------------------------- %%
%% ---------------------------  Captions      ------------------------------- %%
%% -------------------------------------------------------------------------- %%
%%  Adding space to start of caption
%%   save
\let\ncsu@caption\caption
\renewcommand{\caption}[2][]{
    \ifthenelse{\equal{#1}{""}}
         %% if optional string empty
         {\ncsu@caption[#1]{\,\,#2}}
         %% else, optional string not empty
         {\ncsu@caption{\,\,#2}}
}

%% -------------------------------------------------------------------------- %%
%% -------------------------  References ------------------------------------ %%
%% -------------------------------------------------------------------------- %%
\renewcommand{\bibname}{References}
%% natbib redefines \thebibliography, so we add our own requirements
%% at \begin{document} time.
\AtBeginDocument{
    \let\ncsu@thebibliography\thebibliography
    \let\endncsu@thebibliography\endthebibliography
    \renewenvironment{thebibliography}[1]
    {
        \singlespacing
        \begin{ncsu@thebibliography}{#1}
    }
    {
        \end{ncsu@thebibliography}
        \ncsu@defaultspacing
    }
}

%% -------------------------------------------------------------------------- %%
%% ------------------------- The Appendices  -------------------------------- %%
%% -------------------------------------------------------------------------- %%

\newlength{\appendixwidth}
\settowidth{\appendixwidth}{Appendix A}
\addtolength{\appendixwidth}{1em}
\providecommand{\appendixheader}[1]{
    \renewcommand{\ncsu@appendixheader}{#1}
}

%% Count the total number of appendices
\RequirePackage{totcount}
\regtotcounter{chapter} % chapter counter is used for appendices

\AtBeginDocument{%
%% Since ETD requirements are different than LaTeX's normal formatting of
%% the Table of Content's Appendix listings,
%% we change the indentation of chapters, sections, and subsections in
%% the appendix part of the table of contents, but no deeper divisions,
%% so we must cap the tocdepth at 2:
\newcounter{ncsu@appendixtocdepth}
\ifthenelse{\c@tocdepth > 2}
{\setcounter{ncsu@appendixtocdepth}{2}}
{\setcounter{ncsu@appendixtocdepth}{\c@tocdepth}}

\let\ncsu@appendix\appendix
\renewcommand{\appendix}{
    \ifthenelse{\isundefined{\ncsu@appendixheader}}
    % Appendix title page heading not defined, define it
    {
        \ifthenelse{\totvalue{chapter} = 1 }%
        %% number of appendices = 1
        {\newcommand{\ncsu@appendixheader}{Appendix}}
        %% number of appendices > 1
        {\newcommand{\ncsu@appendixheader}{Appendices}}
    }
    % Appendix title page heading already defined, do nothing
    {}

    \chapter*{\ncsu@appendixheader} %% insert 'Appendix' titlepage
    \addcontentsline{toc}{chapter}{\ncsu@appendixheader}
    %% Adding "Appendix" before letter in TOC
    %%  We must change the width of the box which the appendix letter is set in
    %%  and add the "Appendix " before the letter.  See tocloft documentation.
    \addtocontents{toc}{
        \protect\renewcommand{\protect\cftchappresnum}{Appendix }
        \protect\renewcommand{\protect\cftchapnumwidth}{\protect\appendixwidth}
        \protect\renewcommand{\protect\cftchapfont}{\protect\cftsecfont}
        \protect\setlength{\protect\cftbeforechapskip}{\protect\cftbeforesecskip}
        \protect\setlength{\protect\cftchapindent}{\protect\cftsecindent}
        \protect\renewcommand{\protect\cftchappagefont}{\protect\cftchapfont}
        \protect\setlength{\protect\cftsecindent}{\protect\cftsubsecindent}
        \protect\addtolength{\protect\cftsubsecindent}{\cftsecnumwidth}
        \protect\setcounter{tocdepth}{\c@ncsu@appendixtocdepth}
    }
    \clearpage
    \ncsu@appendix %% call internal \appendix macro
} % \renewcommand{appendix}
} % \AtBeginDocument

\ncsu@defaultspacing
%% 
%% Copyright (C) 2009-2010 by Josh Hykes <jmhykes@ncsu.edu>
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License (LPPL), either
%% version 1.3c of this license or (at your option) any later
%% version.  The latest version of this license is in the file:
%% 
%% http://www.latex-project.org/lppl.txt
%% 
%% This work is "maintained" (as per LPPL maintenance status).
%% 
%% This work consists of the file  ncsuthesis.dtx
%% and the derived files           ncsuthesis.ins,
%%                                 ncsuthesis.pdf and
%%                                 ncsuthesis.cls.
%% 
%%
%% End of file `ncsuthesis.cls'.
