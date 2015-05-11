include("generator.jl")
include("optimal_network.jl")
include("pathEdges.jl")

N = 2
gr = graph_generator(N)

M = 10

verts = getVertsUsingEdges(gr)
optimal_allocation(M, N, verts, 1, 1, 1)