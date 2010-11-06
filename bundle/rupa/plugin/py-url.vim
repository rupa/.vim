" :Url

if !has("python")
    finish
endif

fun ShotwebCmpl(A,L,P)
    return "http://\nhttps://\nftp://"
endfun
command! -nargs=? -complete=custom,ShotwebCmpl Url :python shotweb(<f-args>)

python << EOF

import urllib, vim

def shotweb(url=''):
    '''
    :Url [-h] [location]
    insert source of url below the current line
    if location is not provided, uses vim.current.line
    '''
    if url == '-h':
        print shotweb.__doc__
        return
    if not url:
        url = vim.current.line
    if not '://' in url:
        url = 'http://%s' % url
    try:
        page = urllib.urlopen(url).readlines()
    except:
        print 'bad url "%s"' % url
    else:
        vim.current.range.append(page)

EOF
