using LightGraphs
include("generator.jl")

function getVertsUsingEdges(gr)
	# find index of origin vertex and paths to that vertex
	N = nv(gr)
	N = convert(Int, (sqrt(N)-1)/2)
	centerInd = convert(Int, ceil(nv(gr)/2))
	vertPaths = enumerate_paths(dijkstra_shortest_paths(gr,centerInd))

	# for every edge, build up the set of vertices using that edge
	vertSets = Dict()
	for testEdge in edges(gr)
		a = testEdge.first
		b = testEdge.second
		vertSets[testEdge] = Any[]
		for testV in 1:nv(gr)
			if issubset((a,b),vertPaths[testV])
				push!(vertSets[testEdge],
				      linear_to_grid(testV,N))
			end
		end
	end
	# important note here: we test if an edge (a,b) is on
	# a path just by checking if both a and b are in that path
	# this only works because we have no duplicate edges and
	# all edges are assumed to have unit length
	return vertSets
end
