using Distributed, LightGraphs

function distributed_training(data_dir::String)
    nodes = CSV.read(joinpath(data_dir, "nodes.csv"), DataFrame)
    edges = CSV.read(joinpath(data_dir, "edges.csv"), DataFrame)

    g = SimpleGraph(nrow(nodes))
    for row in eachrow(edges)
        add_edge!(g, row.Source, row.Target)
    end

    @distributed for _ in 1:procs()
        ranks = distributed_pagerank(data_dir)
        println("PageRank from process $p is $ranks")
    end
end

function main()
    data_dir = "./graph_data/synthetic_data/data"
    distributed_training(data_dir)
end

main()
