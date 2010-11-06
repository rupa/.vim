" unrelated functions

if !has("python")
    finish
endif

python << EOF

import os, sys, vim

''' add py dirs to path (for 'gf' etc) '''
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))

EOF
