if haskey(ENV, "HOME")
	if haskey( ENV, "__SAMOS" ) && search( ENV["__SAMOS"], "CYGWIN" ) == 1:6
		push!(LOAD_PATH, ENV["HOME"]*"\\.julia")
		push!(LOAD_PATH, ENV["HOME"]*"\\Julia")
	else
		push!(LOAD_PATH, ENV["HOME"]*"/Julia")
	end
end
#push!(LOAD_PATH, ENV["HOME"]*"/codes/Mads.jl/src")
#push!(LOAD_PATH, ENV["HOME"]*"/scripts.jl")
#push!(LOAD_PATH, ENV["HOME"]*"/codes/anasol.jl")
#push!(LOAD_PATH, ENV["HOME"]*"/codes/metatools.jl")
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
