":Markdown - create file.mkd.html and opens in browser
if !has("python")
   finish
endif
command! Markdown :python Mkd().tofile().tobrowser()

python << EOF

import os, vim, webbrowser

try:
    import markdown
except:
    class Mkd(object):
        def __init__(self):
            print 'python-markdown not found'
        def tofile(self):
            return self
        def tobrowser(self):
            pass
else:
    class Mkd(object):
        ''' markdown transformations '''
        def __init__(self, browser='firefox'):
            self.browser = browser
            self.name = vim.current.buffer.name
            self.file = False
            self.html = markdown.markdown(os.linesep.join(vim.current.buffer))

        def tofile(self):
            fh = open('%s.mkd.html' % self.name, 'w')
            fh.write(self.html)
            fh.close()
            self.file = True
            return self

        def tobrowser(self):
            if self.file:
                b = webbrowser.get(self.browser)
                b.open('file://%s.mkd.html' % self.name)

EOF
