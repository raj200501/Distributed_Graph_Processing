# 🌟 Distributed Graph Processing Framework 🌟

## Overview

Welcome to the **Distributed Graph Processing Framework**, a state-of-the-art project designed to handle large-scale graph data efficiently using Julia. This framework leverages Julia's high-performance capabilities to implement advanced graph processing algorithms in a distributed manner, making it ideal for social network analysis, recommendation systems, and large-scale data mining tasks. 🚀

## Key Features

- **High Performance**: Utilizes Julia's speed and efficiency for processing large graph datasets.
- **Distributed Computing**: Implements distributed algorithms for scalable graph processing.
- **Advanced Algorithms**: Includes algorithms like Node2Vec, PageRank, and community detection.
- **Comprehensive Evaluation**: Provides tools for evaluating the performance and accuracy of the graph processing algorithms.
- **Visualization Tools**: Integrates visualization capabilities for insightful data analysis.

## Directory Structure

- **graph_data**: Scripts for generating synthetic graph data.
- **graph_algorithms**: Distributed graph processing algorithms.
- **model_training**: Distributed training and model aggregation.
- **evaluation**: Scripts for evaluating model performance using various metrics.
- **utils**: Utility scripts for data loading and visualization.
- **experiments**: Scripts for conducting various experiments.
- **deployment**: Guidelines and scripts for deploying the framework.

## ✅ Verified Quickstart

> **Prerequisite:** Install Julia (tested with Julia 1.9+). Ensure `julia` is on your PATH.

```bash
./scripts/run.sh
```

This command will:
1. Instantiate Julia dependencies in the local project.
2. Generate a synthetic graph dataset in `graph_data/synthetic_data/data/`.
3. Run the distributed PageRank demo.

## ✅ Verification

Run the smoke test to validate core functionality (data generation, PageRank, Node2Vec walks, community detection, model aggregation):

```bash
./scripts/smoke_test.sh
```

## Troubleshooting

- **`julia: command not found`**
  - Install Julia 1.9+ and ensure it is on your PATH. The scripts will exit early if Julia is missing.
- **Plotting fails in headless environments**
  - The visualization utilities use Plots/GraphRecipes and may require a display backend. Run non-visual scripts (like `scripts/run.sh` and `scripts/smoke_test.sh`) in CI or headless systems.
- **Dependencies fail to resolve**
  - Run `julia --project=. -e 'using Pkg; Pkg.instantiate()'` manually to retry resolution.

## Test Verification Notes

- This repository includes an automated smoke test (`./scripts/smoke_test.sh`) that exercises data generation, PageRank, Node2Vec walks, community detection, and model aggregation.
- For CI or local verification, ensure Julia 1.9+ is installed and on PATH, then run the smoke test command above.
- If you need a quick environment check before running tests, use:

```bash
./scripts/verify_env.sh
```

## AI Assistance Disclosure

Portions of this repository's maintenance and integration changes were completed with assistance from OpenAI's AI tooling. All changes were reviewed and committed by a human maintainer.
