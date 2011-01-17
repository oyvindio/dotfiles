#!/usr/bin/env python
import os
import os.path
import platform
import sys

IGNORE_LIST = [
    os.path.basename(__file__),
    '.gitignore',
    'README.mkdn',
    '.git',]

if __name__ == '__main__':
    dotfiles = os.listdir(os.path.dirname(__file__))
    dotfiles = [f for f in dotfiles if f not in IGNORE_LIST]
    for d in dotfiles:
        src = os.path.abspath(d)
        dest = os.path.join(os.path.expanduser('~'), os.path.basename(d))
        if d == '.Xdefaults': # .Xdefaults should be linked as .Xdefaults-hostname
            dest += '-{}'.format(platform.node())
        if os.path.lexists(dest):
            if os.path.islink(dest):
                os.remove(dest)
            else:
                print >> sys.stderr, '{} already exists, you should remove it first!'.format(dest)
        print 'symlinking {} to {}'.format(src, dest)
        os.symlink(src, dest)
