include("../utils/data_loading.jl")
include("../model_training/distributed_training.jl")

function experiment1(data_dir::String)
    nodes, edges = load_graph_data(data_dir)
    distributed_training(data_dir)
end

function main()
    data_dir = "./graph_data/synthetic_data/data"
    experiment1(data_dir)
end

main()
