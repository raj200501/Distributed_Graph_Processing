using LightGraphs, CSV, DataFrames

function generate_synthetic_graph(num_nodes::Int, num_edges::Int, output_dir::String)
    g = SimpleGraph(num_nodes)
    for _ in 1:num_edges
        add_edge!(g, rand(1:num_nodes), rand(1:num_nodes))
    end

    nodes = DataFrame(NodeID=1:num_nodes)
    edges = DataFrame(EdgeID=1:num_edges, Source=rand(1:num_nodes, num_edges), Target=rand(1:num_nodes, num_edges))

    CSV.write(joinpath(output_dir, "nodes.csv"), nodes)
    CSV.write(joinpath(output_dir, "edges.csv"), edges)

    println("Generated synthetic graph with $num_nodes nodes and $num_edges edges.")
end

function main()
    data_dir = "./graph_data/synthetic_data/data"
    ispath(data_dir) || mkpath(data_dir)
    generate_synthetic_graph(1000, 5000, data_dir)
end

main()
