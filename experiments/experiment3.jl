include("../utils/data_loading.jl")
include("../graph_algorithms/distributed_community_detection.jl")
include("../evaluation/evaluate_model.jl")
include("../utils/visualization.jl")

function experiment3(data_dir::String)
    nodes, edges = load_graph_data(data_dir)
    
    # Perform community detection using distributed approach
    communities = distributed_community_detection(data_dir)
    
    # Mock true labels for evaluation
    true_labels = rand(1:10, length(communities))
    
    # Evaluate the community detection results
    accuracy = evaluate_model(communities, true_labels)
    println("Community Detection Evaluation Accuracy: $accuracy")
    
    # Visualize the detected communities
    plot_graph(nodes, edges)
    println("Community detection distributed algorithm executed successfully.")
end

function main()
    data_dir = "./graph_data/synthetic_data/data"
    experiment3(data_dir)
end

main()
