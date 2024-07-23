using Statistics

function evaluate_model(predictions::Vector{Float64}, labels::Vector{Float64})
    accuracy = mean(predictions .== labels)
    return accuracy
end

function main()
    predictions = rand(Bool, 100)
    labels = rand(Bool, 100)
    accuracy = evaluate_model(predictions, labels)
    println("Model accuracy: $accuracy")
end

main()
