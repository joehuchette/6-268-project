using LightGraphs, Distributions, GraphLayout, Compose

# Creates a 2D lattice on [-N,N] × [-N,N]. Adds N^α random shortcuts, where the
# probability that the edge has a particular length is proportional to the distance
# to the -β-th power.
function graph_generator(N, α, β)

	function linear_to_grid(k)
		i = mod(k-1, 2N+1) - N
		j = div(k-1, 2N+1) - N
		return (i,j)
	end

	grid_to_linear(i, j) = (j+N) * (2N+1) + (i+N) + 1	

	# step 1: create the underlying lattice
	gr = Graph((2N+1)^2)
	for i in -N:(N-1), j in -N:(N-1)
		add_edge!(gr, grid_to_linear(i,j), grid_to_linear(i+1,j))
		add_edge!(gr, grid_to_linear(i,j), grid_to_linear(i,j+1))
	end
	for i in -N:(N-1)
		add_edge!(gr, grid_to_linear(N,i), grid_to_linear(N,i+1))
		add_edge!(gr, grid_to_linear(i,N), grid_to_linear(i+1,N))
	end

	# step 2: add shortcuts
	# for each edge to add (of which there are N^\alpha)
	# we pick one endpoint uniformly at random
	# and the other (by acceptance-rejection) with probability
	# proportional to (link length)^-\beta
	du = DiscreteUniform(-N, N)
	for _ in 1:floor(N^α)
		# first endpoint
		i, j = rand(du), rand(du)
		# find normalizing constant
		c = 0.0
		for ei in -N:N, ej in -N:N
			if (i,j) != (ei,ej) #i != ei || j != ej
				c += 1 / (abs(i-ei) + abs(j-ej))^β
			end
		end
		# accpetance rejection for other endpoint, break on success
		while true
			k, l = rand(du), rand(du)
			if (k,l) == (i,j) || has_edge(gr, grid_to_linear(i,j), grid_to_linear(k,l))
				continue
			end
			dβ = 1 / (abs(i-k) + abs(j-l))^β
			if rand() < dβ / c
				add_edge!(gr, grid_to_linear(i,j), grid_to_linear(k,l))
				break
			end
		end
	end

	return gr
end

function plot_graph(gr::Graph)
	am = full(adjacency_matrix(gr))
	loc_x, loc_y = layout_spring_adj(am)
	draw_layout_adj(am, loc_x, loc_y, filename="lattice-with-jumps.svg")
end
