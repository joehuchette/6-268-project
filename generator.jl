using LightGraphs

function linear_to_grid(N, k)
	i = mod(k-1, 2N+1) - N
	j = div(k-1, 2N+1) - N
	return (i,j)
end

grid_to_linear(N, i, j) = (j+N) * (2N+1) + (i+N) + 1

# Creates a 2D lattice on [-N,N] × [-N,N]. Adds N^α random shortcuts, where the
# probability that the edge has a particular length is proportional to the distance
# to the -β-th power.
function graph_generator(N, α, β)
	gr = Graph((2N+1)^2)
	for i in -N:N, j in -N:N

	end
end