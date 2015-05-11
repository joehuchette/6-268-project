using JuMP, Gurobi

function optimal_allocation(M, N, P; β=0.0, γ=1.0, ω=1.0)

	model = Model(solver=GurobiSolver(MIPGap=0.01))

	@defVar(model, 0 <= v[-N:1:N, -N:1:N] <= M, Int)
	@defVar(model, aux[keys(P)])
	@addConstraint(model, v[0,0] == 0)

	#total population constraint
	@addConstraint(model, sum{v[i,j], i=-N:N, j=-N:N} == M)

	for k in keys(P)
		@addConstraint(model, aux[k] == sum{v[i,j], (i,j) = P[k]})
	end

	@setObjective(model, Min, sum{β*aux[k] + γ*aux[k]^2, k = keys(P)}
							+ sum{ω*v[i,j]^2, i in -N:N, j in -N:N})

	solve(model)
	return getValue(v)
end