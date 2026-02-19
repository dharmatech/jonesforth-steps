python
import gdb
cands = ['$_scriptdir','$_sourcedir','$_this_script_dir','$_sourcefile','$_filename','$_cmdline']
for c in cands:
    try:
        v=gdb.parse_and_eval(c)
        print(c, '=', v)
    except Exception as e:
        print(c, 'ERR', e)
end
quit
