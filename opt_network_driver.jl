include("generator.jl")
include("optimal_network.jl")
include("pathEdges.jl")

N = 2
gr = graph_generator(N)

M = 10

verts = getVertsUsingEdges(gr)
optimal_allocation(N, M, verts, keys(verts), 1, 1)