using JuMP

function optimal_allocation(M, N, P, β, γ)

	model = Model()

	@defVar(model, 0 <= v[-N:1:N, -N:1:N] <= M, Int)
	@defVar(model, aux[keys(P)])

	for k in keys(P)
		@addConstraint(model, aux[k] == sum{v[i,j], (i,j) = P[k]})
	end

	@setObjective(model, Min, sum{β*aux[k] + γ*aux[k]^2, k = keys(P)})

	solve(model)
	return getValue(v)
end