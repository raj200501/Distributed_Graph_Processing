using Distributed
using Statistics

function model_aggregation(data::Vector{Vector{Float64}})
    aggregated_model = mean(data, dims=1)
    return aggregated_model
end

function main()
    models = [rand(10) for _ in 1:4]
    aggregated_model = model_aggregation(models)
    println("Aggregated model: $aggregated_model")
end

main()
