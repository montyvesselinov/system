if haskey(ENV, "HOME")
	push!(LOAD_PATH, joinpath(ENV["HOME"], "Julia"))
end

function pkgisavailable(modulename::String)
	flag=false
	try
		Pkg.available(modulename)
		flag=true	
	catch
		warn("$modulename is not available")
	end
	return flag
end

if pkgisavailable("TerminalExtensions") && is_apple()
	atreplinit((_)->Base.require(:TerminalExtensions))
end
if haskey(ENV, "HOSTNAME")
	for i = ("wc", "cj", "pi", "mp", "ml", "wf")
		if ismatch(Regex("^$i.*"), ENV["HOSTNAME"])
			ENV["MADS_NO_PYPLOT"] = ""
			if i != "wc" 
				ENV["MADS_NO_PYTHON"] = ""
			end
			ENV["HOSTNAME"] = i
			ENV["JULIA_PKGDIR"] = joinpath(ENV["HOME"], string(".julia-", i))
			unshift!(Base.LOAD_CACHE_PATH, joinpath(ENV["HOME"], string(".julia-", i), "lib"))
			deleteat!(Base.LOAD_CACHE_PATH,2)
			break
		end
	end
end

#if haskey( ENV, "__SAMOS" ) && search( ENV["__SAMOS"], "CYGWIN" ) == 1:6
#elseif haskey( ENV, "OS" ) && search( ENV["OS"], "Windows" ) == 1:7
#else
#end

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
