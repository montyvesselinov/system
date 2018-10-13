import Pkg
import Revise

if Sys.isapple()
	atreplinit((_)->Base.require(Base, :TerminalExtensions))
end

if haskey(ENV, "HOME")
	push!(LOAD_PATH, joinpath(ENV["HOME"], "Julia"))
end