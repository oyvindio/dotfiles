dotfiles
========

What's this?
--------------------------------
These are all my config files -- dotfiles -- for  UNIX/Linux systems,
all stored in git to make it easy to keep them in sync across multiple
systems.

How does it work?
-----------------
* Running `link.sh` creates symbolic links to the dotfiles in the
repository in `$HOME`. **Existing symbolic links will be
overwritten**, but existing files of any other type will not. Running
`link.sh` will also pull the latest version of
technomancy/emacs-starter-kit into `.emacs.d`.
* Running `link.sh clean` will remove all the symbolic links it has
created.
* To add or remove files, edit the `DOTFILES` array in `config.sh`.

