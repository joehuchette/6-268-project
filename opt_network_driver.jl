include("generator.jl")
include("optimal_network.jl")
include("pathEdges.jl")

N = 5
gr = graph_generator(N, α=2)

M = 200

verts = getVertsUsingEdges(gr)
v = optimal_allocation(M, N, verts, 1, 1, 1)
alloc = Int[v[i,j] for i in -N:N, j in -N:N]