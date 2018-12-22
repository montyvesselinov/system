ENV["PYTHON"]="/usr/local/bin/python3"

import Pkg

atreplinit() do repl
	try
		@eval import Revise
		@async Revise.wait_steal_repl_backend()
	catch
		@warn("Revise is not available")
	end
end

if Sys.isapple()
	atreplinit((_)->Base.require(Base, :TerminalExtensions))
end

if haskey(ENV, "HOME") && !in(joinpath(ENV["HOME"], "Julia"), LOAD_PATH)
	push!(LOAD_PATH, joinpath(ENV["HOME"], "Julia"))
end
