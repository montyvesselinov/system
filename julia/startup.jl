mytoken = "LANL-5162867576190545e1ea1453cfeb87f598d09591"

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
	try
		@eval import Gadfly
		import Cairo, Fontconfig
		import Base: display
		function Base.display(p::Gadfly.Plot)
			Gadfly.draw(Gadfly.PNG(), p)
			print("\r")
		end
	catch
		@warn("Gadfly is not available")
	end
end

if haskey(ENV, "HOME") && !in(joinpath(ENV["HOME"], "Julia"), LOAD_PATH)
	push!(LOAD_PATH, joinpath(ENV["HOME"], "Julia"))
end

include("gen_project.jl")