# set of experiments to test our network building and populating
include("generator.jl")

# test a given set of generating and populating parameters
# produces one single network with (2N+1)^2 vertices and network creation
# parameters alpha, beta
# then reps times populates the network with m people and parameters gamma, delta
# and records all the population outputs
# returns a pair (gr,pops) where gr is the network topology and pops is
# a matrix with 1 row for each replication
function test_params(N::Int, m::Int, alpha, beta, gamma, delta, reps::Int)
	gr = graph_generator(N, alpha, beta)
	pops = Array(Int,reps,(2*N+1)^2)
	for rep in 1:reps
		pops[rep,:] = assign_population(gr, m, gamma, delta)
	end
	return (gr, pops)
end
