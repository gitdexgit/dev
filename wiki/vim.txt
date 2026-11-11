# vim

PHILOSOPHY
  Goal: Be universal. Zero config, 100% vanilla.
  Rule: Vim edits text; the shell manages files.
  Quick edits in Vim; heavy work in nvim/emacs.
  Fallback: nvim/emacs -> vim -> vi -> nano -> ed -> cat/echo

FILE OPS (JOB CONTROL)
  Ctrl+Z      Suspend Vim to shell (mv, rm, mkdir, git)
  fg          Return to Vim instantly
  :e [file]   Reload or switch to renamed/moved file

CLIPBOARD
  Visual select with 'V', then "+y to copy to OS clipboard.
  Paste with "+p (or Ctrl+Shift+V / Ctrl+V in insert mode).

ACTIONS
  ggVG "+y    Copy entire file
  vip "+y     Copy paragraph
  Vjj "+y     Copy lines down
