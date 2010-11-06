" Vim syntax file
" Language: DataMerge
" Maintainer: 31d1
" Last Change: 02/19/2010
" Version: 0.1
" URL: http://code.cutup.org/vim/dml.vim
" datamerge is a proprietary language for scripting MedicalManager
"
" add to .vimrc:
"     autocmd BufNewFile,BufRead *.dml setf dml
" and put this file in .vim/syntax/

if version < 600
 syntax clear
elseif exists("b:current_syntax")
 finish
endif

" not case sensitive
syn case ignore

syn keyword datamergeFunc ABORT ABS ADDKEY AGE ASC ATFLAG AUTO AUTOUNLOCK BACKGROUNDPRINT CHR CLEARTEXT CLEARIDX CLEARREC COMPRESSUSAGE COPYFILE DATECMP DELFILE DISPLAY DRAWBOX DRAWLINE DTTOJUL DTTOSTR ELIGIBILITY ELOCK ENABLETAB ERRLOG ERRPRINT ERRTRACE EUNLOCK EXISTS EXTLOGPRINT FLOCK FSIZE FUNLOCK GETCCODE GETDATE GETDRIVE GETENV GETFIELD GETFIELDLENGTH GETFIELDTYPE GETINPUT GETPAT GETPATH GETPHONE GETSSN GETSYSDATE HELP HELPARRAYINDEX HELPCMD HELPINDEX HELPLINE HELPNOINDEX HELPSETUP INKEY INPUTSTR INT ISALPHA ISEMPTY ISLOCKED ISNUMBER ISOPEN JULTODT JULTOSTR LASTKEY LASTPOS LASTREC LASTRECTYPE LCASE LEFT LEN LOCATEKEY LOG LOG10 MATCH MESSAGE MID NEWPROHISTLAYOUT NEXTPOS NUMARGS NUMSORT OSDATE PHTOSTR PREPOS PUTENV QFILENAME QREAD QSTART QSTOP QTYPE QWRITE RAWLOGPRINT READHEADER RECTYPE REFSPLIT RENAMEFILE REPEAT REPLY RIGHT RMCOMP SETCURRCASE SETCURRENTBATCH SETCURRENTCHECK SETCURRPAT SETFIELD SETHELPSTARTITEM SETREPLY SETRETURNCHARS SLEEP SQRT SSNTOSTR STRINGCOMPARE STRIP STRSORT STRTODT STRTOJUL STRTOPH STRTOSSN SUBSTITUTE SYSTEM TIME TRANSLATE UCASE USAGE USEDFLIST VALIDUDHTENTRY WRITEHEADER BUILDKEY CLOSE CLOSEIDX DEFEXT DELETE DELKEY DESPOOL DIM EXIT GETKEY HELPWIND HOLDDEVICES IGNOREDUP INTERRUPT LOGPRINT MOVE NOTRACK OPEN OPENIDX PARSE PMTSPLIT PREPASS PRINT READ RETURN SET STRPRINT USAGELOCK WRITE
syn keyword datamergeConst POINTER VARIABLE FIXED CREATE SHARED DELIMITED QUOTED MAXLEN MAXFIELDS RECORD NEXT READONLY LOCKED FORCEDCREATE ADD MODIFY LOCKED SUPRESS ABSOLUTE SYSDATE
syn keyword datamergeCond BREAK CONTINUE GOTO IF ELSE SWITCH CASE DEFAULT WHILE 
syn keyword datamergeDefine FUNC PROC
syn region datamergeComment start="/\*" end="\*/"
syn region datamergeString start=+L\='+ skip=+\\'\|\\\\\\+ end=+'+ 
syn region datamergeString start=+L\="+ skip=+\\"\|\\\\\\+ end=+"+
syn match datamergeOperator "[-+%^&|#*!.]"
syn match datamergeFile "[f|e][0-9]*\.[0-9]*"
syn match datamergeSvariable "[A-Za-z0-9]*\$"

" we use dbg and a debug() function
syn keyword datamergeDebug DEBUG DBG

hi datamergeFunc guifg=cyan ctermfg=cyan
hi datamergeConst guifg=cyan ctermfg=cyan
hi datamergeCond guifg=brown ctermfg=brown
hi datamergeDefine guifg=brown ctermfg=brown
hi datamergeComment guifg=darkmagenta ctermfg=darkmagenta
hi datamergeString guifg=darkblue ctermfg=darkblue
hi datamergeFile guifg=yellow ctermfg=yellow
hi datamergeOperator guifg=darkmagenta ctermfg=darkmagenta
hi datamergeDebug guifg=red ctermfg=red
hi datamergeSvariable guifg=darkgreen ctermfg=darkgreen

let b:current_syntax = "datamerge"
