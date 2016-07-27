#!/usr/bin/env python

import os,sys,re
from optparse import OptionParser, OptionGroup, Option, SUPPRESS_HELP

# -----------------------------
class MyOption(Option):
# -----------------------------
# used for definition of new option parser action 'extend', which enables to take multiple option arguments
# taken from online tutorial http://docs.python.org/library/optparse.html
  
  ACTIONS = Option.ACTIONS + ("extend",)
  STORE_ACTIONS = Option.STORE_ACTIONS + ("extend",)
  TYPED_ACTIONS = Option.TYPED_ACTIONS + ("extend",)
  ALWAYS_TYPED_ACTIONS = Option.ALWAYS_TYPED_ACTIONS + ("extend",)

  def take_action(self, action, dest, opt, value, values, parser):
    if action == "extend":
      lvalue = value.split(",")
      values.ensure_value(dest, []).extend(lvalue)
    else:
      Option.take_action(self, action, dest, opt, value, values, parser)


parser = OptionParser(option_class=MyOption, usage='%prog [options] label(s) [datafile]', description = """
return datafile name and ID(s) of label(s) to be used with plot[_distribution].gri
""")

parser.add_option('-c','--comma',
                  action = 'store_const',
                  const = ',',
                  dest = 'separator',
                  help = 'set column output separator to ","')

parser.set_defaults(separator = ' ')

(options, columns) = parser.parse_args()

if len(columns) < 1:
  parser.print_help()
  parser.error('no labels specified.')

if os.path.exists(columns[-1]):
  name = columns.pop()
  file = {'name':name, 'input':open(name),}
else:
  file = {'name':'STDIN', 'input':sys.stdin,}

firstline = file['input'].readline()
m = re.search('(\d+)\s+head', firstline.lower())
if m:
  headerlines = int(m.group(1))
  passOn  = [file['input'].readline() for i in range(1,headerlines)]
  headers = file['input'].readline().split()
else:
  headerlines = 1
  passOn  = []
  headers = firstline.split()
file['input'].close()

print '\t'.join([file['name']] +
                [options.separator.join(map(str,[1+headers.index(heading) for heading in columns if heading in headers]))]
               )
