include("generator.jl")
include("optimal_network.jl")
include("pathEdges.jl")

N = 15

for iter in 1:1, α in [1,1.5,2], β in [1,1.5,2]
# for iter in 1:1, α in [1], β in [1]
	gr = graph_generator(N, α=α, β=β)
	plot_graph_grid(gr, filename="plots/grid-$α-$β-$iter.svg")
	for cnt in [1,10,100]
		M = (2N+1)^2*cnt
		pop = assign_population(gr, M; γ=2.0, δ=2.0)
		population_heatmap(gr, pop, filename="plots/individual-$α-$β-$cnt-$iter.pdf")

		verts = getVertsUsingEdges(gr)
		v = optimal_allocation(M, N, verts; ω=5.0)
		population_heatmap(gr, v, filename="plots/optimal-$α-$β-$cnt-$iter.pdf")

		dist = distances_to_origin(gr)
		distance_heatmap(gr, v, filename="plots/distance-$α-$β-$cnt-$iter.pdf")
	end
end
