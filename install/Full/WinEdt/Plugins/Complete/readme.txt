Command completion
==================

v0.11 (beta)
Holger Danielsson
dani@fbg.schwerte.de


What 'complete' does (should do):
---------------------------------

You type the beginning of a TeX/LaTeX command or a WinEdt macro,
and the program completes if the pattern is unique or shows a
dialog with all possible commands/macros. 'complete'
doesn't care about lower and upper letters.


Installation and usage:
-----------------------

- copy all files to '%B\plugins\complete'

- run WinEdt and choose 'Macros/Execute Macro'. Then execute
  'install.edt', which installs the plugin in the Shortcuts menu.
  If you want to restore the initial values execute '_Restore.edt'

- Remark: there is no need to start 'complete.exe'. This is done
  automatically when you call 'complete' the first time.

- Now you can use four different Shortcuts:

  1) CTRL-Y:       command completion for TeX/LaTeX commands
  2) CTRL-SHIFT-Y: command completion for LaTeX-environments
  3) ALT-Y:        command completion for WinEdt macros
  4) ALT-SHIFT-Y:  command completion for WinEdt commands

- run WinEdt and type the beginning of a LaTeX command (f.e. '\ne'),
  an environment name (f.e. 'i'), a WinEdt macros (f.e. 'if')
  or a WinEdt command (f.e. 'se');

- call the command completion (CTRL-Y, CTRL-SHIFT-Y, ALT-Y
  or ALT-SHIFT-Y)


Available Shortcuts:
--------------------

1) CTRL-Y: command completion for TeX/LaTeX commands

'complete.exe' is only looking for TeX/LaTeX commands from
command files, which are selected in the listbox. All
TeX/LaTeX commands begin with a backslash.

2) CTRL-SHIFT-Y: command completion for LaTeX-environments

You dont't have to type '\begin{', it suffers to type the
beginning of the environment name. If you type f.e. 'i' and
press CTRL-SHIFT-Y, 'complete.exe' will prepend this prefix,
which results the pattern '\begin{i'. The program will complete
with

\begin{itemize}

\end{itemize}

because there is only one environment beginning with 'i' at
this moment.

3) ALT-Y: command completion for WinEdt macros

'complete.exe' will only look for WinEdt macros from the
command file 'WinEdt1.lst'.

4) ALT-SHIFT-Y: command completion for WinEdt commands

'complete.exe' will only look for WinEdt commands from the
command file 'WinEdt2.lst'. If you type f.e. 'b' and press
ALT-SHIFT-Y, 'complete' will insert

CMD("Backspace");

because there is only one WinEdt command which begins with
the letter 'b'.


Actions when the user calls 'complete':
---------------------------------------

1) the current word ist selected

2) a listbox is opened with all commands from the selected files,
   which match the selected word

    a) If there is no matching word, nothing will happen and the
       choosen word is deselected

    b) If there is exactly one word, the command will be completed.
       With all braces, brackets, parenthesis, ...

3) Now the user can

   a) choose a command with the mouse, this command will be sent
       to WinEdt.

   b) choose the selected command with the ENTER key, this command
       will be sent to WinEdt.

    c) input the next character ('A'..'Z','a'..'z') for the pattern:

        - if there are no more commands matching the current pattern,
          this pattern will be sent to WinEdt.

        - if there is exactly one command matching this pattern, this
          command will be sent to WinEdt.

        - if there are still two ore more commands matching this new
          pattern, the listbox is updated and the number of possible
          matches will shrink

    d) delete the last character (BACKSPACE): this will grow the
       number of items in the listbox

    e) move through the listbox (CURSOR UP/DOWN, PAGE UP/DOWN)

    f) cancel the dialog (ESCAPE)


Options:
--------

- several command files, which also can be enabled and disabled
  The filenames must match the entry in the listbox with the
  extension '.lst' and must be paced in the folder 'commands'.
  There are four files included: 'Tex.lst', 'Latex.lst',
  'Math Symbols.lst', 'Winedt1.lst' and 'Winedt2.lst'. You can
  also add new entries and delete old entries for your special
  purposes.

- show parameters
  on:  the commands will be shown with short explanations
       '\newcommand{cmd}[args]{def}'. They are not send to WinEdt!
  off: the commands will be shown with short explanations
       '\newcommand{}[]{}'

- place cursor
  on:  place the cursor behind the first brace, bracket,...
       (changed: there is no '^'-symbol, anymore)
  off: place the cursor behind the inserted text

- insert bullets
  on:  insert WinEdt-Bullets between braces, brackets,...
  off: insert no bullets

- close environments
  on:  when an environment is selected, also the end of the
       environment is send to WinEdt.
  off: only '\begin{...}' is send to WinEdt

- allow @
  on:  the key '@' is allowed
  off: the key '@' is not allowed

All options are saved in the companion ini-file 'complete.ini'
and restored with the next start.


Files:
------

in the folder 'complete':

complete.exe           i forgot ...
complete.ini           options
install.edt            WinEdt macro for installation
Complete Menu.dat      WinEdt install data
Complete Menu-Off.dat  Uninstall data
complete.edt           WinEdt macro for DDE connection (for LaTeX commands)
env.edt                WinEdt macro for DDE connection (for LaTeX environments)
macro.edt              WinEdt macro for DDE connection (for WinEdt macros)
cmd.edt                WinEdt macro for DDE connection (for WinEdt commands)
readme.txt             this file

in the folder 'complete\commands':

latex.lst           list of LaTeX commands
math symbols.lst    list of math symbols
tex.lst             list of TeX commands
winedt1.lst         list of WinEdt macros
winedt2.lst         list of WinEdt commands
