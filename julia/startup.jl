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

"""
    generate_project_toml([name::String])

Generate Project.toml file for the existing current project at `\$PWD`.
It activates the generated Project.toml and then adds packages based on
REQUIRE file.
"""
function generate_project_toml(name::AbstractString = guess_project_name())
    if isfile("Project.toml")
        error("Project.toml exists.")
    end

    if !isfile("REQUIRE")
        error("REQUIRE file not found.")
    end
    deps = read_require("REQUIRE")

    pkg = Base.identify_package(name)
    project_toml = """
    name = $(repr(name))
    uuid = "$(pkg.uuid)"
    """
    write("Project.toml", project_toml)

    @info "Activating \$PWD (to run `Pkg.add`)"
    Pkg.activate(pwd())
    Pkg.add(deps)
end

"""
    guess_project_name() :: String

Guess project name using Git.  It works even in worktree repository.
"""
function guess_project_name()
    path = abspath(rstrip(read(`git rev-parse --git-dir`, String)))
    prev = ""
    while path != prev
        if basename(path) == ".git"
            return basename(dirname(path))
        end
        prev, path = path, dirname(path)
    end
    error("Project not found")
end

function read_require(path)
    deps = String[]
    for line in readlines(path)
        name, = split(line)
        if name == "julia"
            continue
        end
        push!(deps, name)
    end
    return deps
end