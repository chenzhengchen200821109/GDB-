python

import os

# Global variables -----------------------------------------------------------
name = None

# GGBboard --------------------------------------------------------------------

def source_plugin(path):
    if path == None:
        print("\033[1;32m but path to " + name + " does not exist!!!\033[0m")
        print("\033[1;31m please check path to " + name + " and Try again...\033[0m")
    elif os.path.exists(path):
        gdb.execute('source ' + path)
    else:
        print("\033[1;32m but path to " + name + " does not exist!!!\033[0m")
        print("\033[1;31m please check path to " + name + " and Try again...\033[0m")

class GDBboard():
    """Redisplay the ."""

    def __init__(self):
        self.plugins = ""

# Utility methods --------------------------------------------------------------

    @staticmethod
    def start():
        gdbboard = GDBboard()
        plugins = gdbboard.get_plugins()
        print("\033[1;32m Please choose a gdb enchancer.\033[0m")
        prefix = "Please input"
        postfix = "\033[1;32m Nothing\033[0m!!!"
        prefix += plugins;
        prefix += postfix;
        print(prefix)

    def get_plugins(self):
        # scan the scope for plugins
        plugins = {}
        i = 0
        for name in globals():
            obj = globals()[name]
            try:
                if issubclass(obj, gdb.Command):
                    self.plugins += "\033[1;31m " + obj().name.upper() + "\033[0m" + " or"
            except TypeError:
                continue
        return self.plugins 

# Default GDB Enhancer --------------------------------------------------------------

class PEDA(gdb.Command):
    """peda: """

    def __init__(self):
        gdb.Command.__init__(self, 'PEDA',
                gdb.COMMAND_USER, gdb.COMPLETE_NONE, True)
        self.name = 'peda'
        # CHANGE PATH TO PLUGIN PEDA IF NECESSARY
        self.path = '/home/chenzheng/Documents/peda/peda.py'

    def invoke(self, arg, from_tty):
        global name
        if name == None:
            name = self.name
            print("\033[1;32m " + self.name + '\033[0m has been chosen')
            source_plugin(self.path)

class GEF(gdb.Command):
    """gef: """

    def __init__(self):
        gdb.Command.__init__(self, 'GEF',
                gdb.COMMAND_USER, gdb.COMPLETE_NONE, True)
        self.name = 'gef'
        # CHANGE PATH TO PLUGIN GEF IF NECESSARY
        self.path = '/home/chenzheng/Documents/gef/gef.py'

    def invoke(self, arg, from_tty):
        global name
        if name == None:
            name = self.name
            print("\033[1;32m " + self.name + '\033[0m has been chosen')
            source_plugin(self.path)


class PWNDBG(gdb.Command):
    """pwndbg: """

    def __init__(self):
        gdb.Command.__init__(self, 'PWNDBG',
                gdb.COMMAND_USER, gdb.COMPLETE_NONE, True)
        self.name = 'pwndbg'
        # CHANGE PATH TO PLUGIN PWNDBG IF NECESSARY
        self.path = '/home/chenzheng/Documents/pwndbg/gdbinit.py'

    def invoke(self, arg, from_tty):
        global name
        if name == None:
            name = self.name
            print("\033[1;32m " + self.name + '\033[0m has been chosen')
            source_plugin(self.path)

# XXX traceback line numbers in this Python block must be increased by 1
end

# Better GDB defaults ----------------------------------------------------------

set history save
set verbose off
set print pretty on
set print array off
set print array-indexes on
set print demangle
set print asm-demangle
set python print-stack full

# Start ------------------------------------------------------------------------

python GDBboard.start()

# Pretty printer ---------------------------------------------------------------

# To make print pretty work properly, g++83 must be used to compile program.
# for example: g++83 -g - std=c++11 [program]
# g++(4.8) can NOT make it!!!
add-auto-load-safe-path /usr/local/gcc-8.3/lib/libstdc++.so.6.0.26-gdb.py 

# User defined commands --------------------------------------------------------

define bret
    finish
end
document bret
Syntax: bret
| Execute until selected stack frame returns (step out of current call).
| Upon return, the value returned is printed and put in the value history.
end

define binit
    tbreak _init
    run
end
document binit
Syntax: binit
| Run program and break on _init().
end

define bstart
    tbreak _start
    run
end
document bstart
Syntax: bstart
| Run program and break on _start().
end

define bcstart
    tbreak __libc_start_main
    run
end
document bcstart
Syntax: bcstart
| Run program and break on __libc_start_main().
| Useful for stripped executables.
end

define bmain
    tbreak main
    run
end
document bmain
Syntax: bmain
| Run program and break on main().
end

define cls
    shell clear
end
document cls
Syntax: cls
| Clear screen.
end

define threads
    info threads
end
document threads
Syntax: threads
| Print threads in target.
end

define lib
    info sharedlibrary
end
document lib
Syntax: lib
| Print shared libraries linked to target.
end

# ------------------------------------------------------------------------------
# Copyright (c) 2018-2019 Chen Zheng <987102818@qq.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# ------------------------------------------------------------------------------
# vim: filetype=python
# Local Variables:
# mode: python
# End:
