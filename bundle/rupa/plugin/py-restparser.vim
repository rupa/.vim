" INSTALL: put in ~/.vim/plugin/
"   USAGE: run :Rtbl on a paragraph of pipe-delimited values
"    TODO: accept different length rows?
"          require at least two rows?
"          treat lines of whitespace as blank

if !has("python")
    finish
endif

command! -nargs=? Rtbl :python rest_table(<f-args>)

python << EOF
'''
ReST functions
'''

import sys, vim

def create_table(values):
    '''
    Creates a ReST table from a list of lists.
    '''

    # list to hold max length of each field
    field_lengths = [0 for x in values[0]]

    # get max length of each field
    for row in values:
        try:
            for index, field in enumerate(row):
                if len(field) > field_lengths[index]:
                    field_lengths[index] = len(field)
        except:
            return False, 'rows must be the same length'

    # create header row
    header = []
    for length in field_lengths:
        header.extend(['+', ('-' * length)])
    header.append('+')

    table = [''.join(header)]

    # write each line
    for row_num, row in enumerate(values):

        # data
        line = []
        for col_num, field in enumerate(row):
            line.extend(['|', field.ljust(field_lengths[col_num])])
        line.append('|')

        table.append(''.join(line))

        # row separator
        line = []
        char = '-' if row_num else '='
        for index, length in enumerate(field_lengths):
            line.extend(['+', char * field_lengths[index]])
        line.append('+')

        table.append(''.join(line))

    return table, None

def get_paragraph_range(buff, line_no):
    '''
    the blank line delimited chunk of text that the cursor is on
    '''
    start_line = end_line = line_no
    try:
        while buff[start_line] != "":
            start_line -= 1
    except IndexError:
        pass
    try:
        while buff[end_line] != "":
            end_line += 1
    except IndexError:
        pass
    if end_line == line_no:
        # single line
        end_line += 2
    return start_line+1, end_line

def rest_table(arg=None):
    '''
    :Rtbl [-h|--help]
    transform current paragraph of pipe delimited rows into a ReST table
    '''

    if arg in ['-h', '--help']:
        print __doc__
        print rest_table.__doc__
        return

    if vim.current.line == "":
        sys.stderr.write('Error: not in a paragraph\n')
        return

    buff = vim.current.buffer
    line_no = int(vim.eval("line('.')")) - 1
    start_line, end_line = get_paragraph_range(buff, line_no)
    lines = [line.split('|') for line in buff[start_line:end_line]]
    table, error = create_table(lines)

    if table:
        buff[start_line:end_line] = table
    else:
        sys.stderr.write('Error: {0}\n'.format(error))

EOF
