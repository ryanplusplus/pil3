--[[
Can you use the os.execute function to change the current directory of your Lua program?  Why?
]]

os.execute('mkdir tmp')
os.execute('cd tmp')
os.execute('touch tmpfile')

--[[
Executing the above does not result in tmp/tmpfile, but in ./tmpfile.  Presumably what's happened is that each time os.execute is called a new shell/environment is created and exits when the command is done.
]]
