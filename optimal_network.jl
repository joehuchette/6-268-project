using JuMP

function optimal_allocation(M, N, P, edges, β, γ)

	model = Model()

	@defVar(model, 0 <= v[-N:1:N, -N:1:N] <= M, Int)

	@setObjective(model, Min, sum{β* sum{v[i,j], (i,j) in P[k]}
							    + γ*(sum{v[i,j], (i,j) in P[k]})^2, k in edges})

	solve(model)
	return getValue(v)
end