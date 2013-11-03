# :sparkles: .emacs.d :sparkles:

This is where I store all my carefully crafted micro-optimizations for
Emacs.

## Installation

**Note:** The code is designed to be installed in the
[standard](http://www.emacswiki.org/emacs/DotEmacsDotD) Emacs user
directory.

Fetch the source.

    $ git clone  git://github.com/aptrik/.emacs.d.git  ~/.emacs.d

Make sure you have Emacs version 24.3 or higher [installed](#install-emacs).

### Install all ELPA packages

First install [Cask](http://cask.github.io/):

    $ curl -fsSkL https://raw.github.com/cask/cask/master/go | python
    ...
    Successfully installed Cask!  Now, add the cask binary to your $PATH:
    export PATH="$HOME/.cask/bin:$PATH"'

Upgrade `cask` and then let `cask` install all dependencies.

    $ cd ~/.emacs.d
    $ cask upgrade
    $ cask install


### Install python-mode dependencies

Install `Jedi` and `python-epc` by:

    $ pip install -r ~/.emacs.d/python_requirements.txt


## Install Emacs <a id="install-emacs"></a>

### GNU/Linux

    $ wget http://ftpmirror.gnu.org/emacs/emacs-24.3.tar.gz
    $ tar xfz emacs-24.3.tar.gz
    $ cd emacs-24.3
    $ ./configure --prefix=$HOME/tools/emacs-24.3 --without-toolkit-scroll-bars
    $ make
    $ ./src/emacs -q
    $ make install

RHEL 6 dependencies(?):

    $ sudo yum install libtiff-devel giflib-devel libotf-devel m17n-lib-devel

### Mac OS

    $ brew install emacs --cocoa

Or the bleeding edge version.

    $ brew install emacs --cocoa --use-git-head --HEAD


## Emacs Help

* `F1 t`  Basic tutorial.
* `F1 k`  Help for a keybinding.
* `F1 r`  Emacs' extensive documentation.
