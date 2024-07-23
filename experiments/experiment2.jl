include("../utils/data_loading.jl")
include("../graph_algorithms/distributed_pagerank.jl")
include("../evaluation/evaluate_model.jl")
include("../utils/visualization.jl")

function experiment2(data_dir::String)
    nodes, edges = load_graph_data(data_dir)
    
    # Compute PageRank using distributed approach
    ranks = distributed_pagerank(data_dir)
    
    # Evaluate the PageRank results
    true_labels = rand(1:10, length(ranks))  # Mock true labels for evaluation
    accuracy = evaluate_model(ranks, true_labels)
    println("PageRank Evaluation Accuracy: $accuracy")
    
    # Visualize the results
    plot_graph(nodes, edges)
    println("PageRank distributed algorithm executed successfully.")
end

function main()
    data_dir = "./graph_data/synthetic_data/data"
    experiment2(data_dir)
end

main()
