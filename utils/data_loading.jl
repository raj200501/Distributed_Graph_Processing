using CSV, DataFrames

function load_graph_data(data_dir::String)
    nodes = CSV.read(joinpath(data_dir, "nodes.csv"), DataFrame)
    edges = CSV.read(joinpath(data_dir, "edges.csv"), DataFrame)
    return nodes, edges
end

function main()
    data_dir = "./graph_data/synthetic_data/data"
    nodes, edges = load_graph_data(data_dir)
    println("Loaded graph data successfully.")
end

main()
