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

# given a graph and list of populations
# find the average density by graph distance to origin
function get_avg_density_by_dist(gr,pops)
	V = length(vertices(gr))
	N = convert(Int, (sqrt(V) - 1) / 2)
	dij = dijkstra_shortest_paths(gr, grid_to_linear(0,0,N))
	dists = dij.dists
	mean_pops = mean(pops,1) # mean for each vertex
	maxDist = 2*N
	pointsAtDist = zeros(maxDist)
	peopleAtDist = zeros(maxDist)
	for i = 1:V
		peopleAtDist[dists[i] += mean_pops[i]
		pointsAtDist[dists[i]] += 1
	end
	return peopleAtDist ./ pointsAtDist
end