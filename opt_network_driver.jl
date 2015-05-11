include("generator.jl")
include("optimal_network.jl")
include("pathEdges.jl")

N = 2
gr = graph_generator(N)

M = 200

verts = getVertsUsingEdges(gr)
v = optimal_allocation(M, N, verts, 1, 1, 1)
