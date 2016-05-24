if haskey(ENV, "HOME")
	if haskey( ENV, "__SAMOS" ) && search( ENV["__SAMOS"], "CYGWIN" ) == 1:6
		push!(LOAD_PATH, ENV["HOME"]*"\\.julia")
		push!(LOAD_PATH, ENV["HOME"]*"\\Julia")
	elseif haskey( ENV, "OS" ) && search( ENV["OS"], "Windows" ) == 1:7
		push!(LOAD_PATH, ENV["HOME"]*"\\.julia")
		push!(LOAD_PATH, ENV["HOME"]*"\\Julia")
	else
		push!(LOAD_PATH, ENV["HOME"]*"/Julia")
	end
end
if haskey(ENV, "HOSTNAME")
	if ismatch(r"hb.*", ENV["HOSTNAME"]) 
		ENV["MADS_NO_PYTHON"] = ""
		ENV["HOSTNAME"] = "hb"
	end
	if ismatch(r"cj.*", ENV["HOSTNAME"]) 
		ENV["MADS_NO_PYTHON"] = ""
		ENV["HOSTNAME"] = "cj"
	end
	if ismatch(r"pi.*", ENV["HOSTNAME"]) 
		ENV["MADS_NO_PYTHON"] = ""
		ENV["HOSTNAME"] = "pi"
	end
	if ismatch(r"mp.*", ENV["HOSTNAME"]) 
		ENV["MADS_NO_PYTHON"] = ""
		ENV["HOSTNAME"] = "mp"
	end
	unshift!(Base.LOAD_CACHE_PATH, joinpath(Base.LOAD_CACHE_PATH[1], ENV["HOSTNAME"]))
end
#push!(Sys.DL_LOAD_PATH, ENV["HOME"]*"/mads/repo/bin/Lib")
## give a local .juliarc.jl a chance
#if chomp(readall(`pwd`)) != ENV["HOME"]
#    if isfile(".juliarc.jl")
#        require(".juliarc.jl")
#    end
#end
#const mykeys = {
#    # Up Arrow
#    "\e[A" => (s,o...)->(LineEdit.edit_move_up(s) || LineEdit.history_prev(s, LineEdit.mode(s).hist)),
#    # Down Arrow
#    "\e[B" => (s,o...)->(LineEdit.edit_move_down(s) || LineEdit.history_next(s, LineEdit.mode(s).hist)),
#    # Page Up
#    "\e[5~" => (s,o...)->(LineEdit.history_prev_prefix(s, LineEdit.mode(s).hist)),
#    # Page Down
#    "\e[6~" => (s,o...)->(LineEdit.history_next_prefix(s, LineEdit.mode(s).hist))
#}
#
#Base.active_repl.interface = REPL.setup_interface(Base.active_repl; extra_repl_keymap = mykeys)
