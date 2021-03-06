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
    export PATH="$HOME/.cask/bin:$PATH"

Upgrade `cask` and then let `cask` install all dependencies.

    $ cd ~/.emacs.d
    $ cask upgrade
    $ cask install


### Install python-mode dependencies

Install `Jedi` and `python-epc` by:

    $ pip install -r ~/.emacs.d/python_requirements.txt


### User customization

If there is a file named `user.el` in the `~/.emacs.d`-directory then it
will be loaded at the end of the set up phase.

Example `~/.emacs.d/user.el`:

```lisp
(setq debug-on-error t)

(setq user-full-name    "Ed Xample"
      user-mail-address "ed.xample@eg.fake")
```


## Install Emacs

### GNU/Linux

    $ wget http://ftpmirror.gnu.org/emacs/emacs-24.4.tar.gz
    $ tar xfz emacs-24.4.tar.gz
    $ cd emacs-24.4
    $ ./configure --prefix=$HOME/tools/emacs-24.4 --without-toolkit-scroll-bars
    $ make
    $ ./src/emacs -q
    $ make install

#### RHEL 6 dependencies

    $ sudo yum-builddep emacs
    $ sudo yum install libtiff-devel giflib-devel libotf-devel m17n-lib-devel

#### Ubuntu/LinuxMint dependencies

    $ sudo apt-get build-dep emacs24
    $ sudo apt-get install \
        libacl1-dev \
        libgconf2-dev \
        libgif-dev \
        libgpm-dev \
        libjpeg-dev \
        libm17n-dev \
        libmagickcore-dev libmagickwand-dev \
        libotf-dev \
        libpng-dev \
        librsvg2-dev \
        libtiff-dev \
        libxml2-dev \
        libxpm-dev

### Mac OS

    $ brew install emacs --cocoa --srgb --with-gnutls
    $ brew linkapps

Or the bleeding edge version.

    $ brew install emacs --cocoa --use-git-head --HEAD --srgb --with-gnutls
    $ brew linkapps


## Emacs Help

* `F1 t`  Basic tutorial.
* `F1 k`  Help for a keybinding.
* `F1 r`  Emacs' extensive documentation.
