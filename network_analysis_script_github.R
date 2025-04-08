#* Prepare packages and libraries ----

# Installing required packages
install.packages("ggnetwork")
install.packages("intergraph")
install.packages("bootnet")

# Loading necessary libraries
library(tidyverse)
library(igraph)
library(ggnetwork)
library(intergraph)
library(bootnet)
library(dplyr)


# Assign 'bfi' dataset to a new database called 'bd'
bd <- bfi

#* Version 1: Network Creation and Centrality Measures ----


##*** change "bd" and "c(1:25)" for your case *** ##################################################

{
  # Extract the names of the questionnaire items
  nodes <- colnames(bd)[c(1:25)]  # Select columns 1 to 25 for item names
  
  # Create a data frame with the node names
  nodes_df <- data.frame(node = nodes)
  
  # Calculate the correlation matrix between the items
  cor_matrix <- cor(bd[, c(1:25)], use = "pairwise.complete.obs")
  
  # Convert the correlation matrix into a list of connections (edges)
  edges_df <- as.data.frame(as.table(cor_matrix))
  
  # Filter only significant correlations (avoid redundancy)
  edges_df <- edges_df %>%
    filter(Freq > 0.2 & Var1 != Var2) %>%  # Keep correlations > 0.2 and remove self-loops
    rename(From = Var1, To = Var2, Weight = Freq)  # Rename columns for clarity
  
  # Create an empty graph with the number of nodes
  G <- make_empty_graph(n = length(nodes), directed = FALSE) %>%
    add_edges(as.vector(rbind(edges_df$From, edges_df$To)))
  
  # Add node attributes (e.g., a fictitious group, if desired)
  V(G)$group <- "Cuestionario"
  
  # Plot the initial graph with customizations
  plot(G, vertex.label = V(G)$name, vertex.color = "skyblue", edge.width = edges_df$Weight * 5)
  
  # Additional plot customization using layout
  plot(G, vertex.color = "green",  # Change node color
       edge.color = 'black',        # Change edge color
       vertex.size = 10,            # Adjust node size
       vertex.shape = 'circle',     # Set node shape
       asp = 0,                     # Adjust aspect ratio
       layout = layout_in_circle)   # Arrange nodes in a circular layout
  
  # Plot the network using ggplot
  ggplot(G, aes(x = x, y = y, xend = xend, yend = yend)) + 
    geom_edges() +
    geom_nodes()
  
  # Calculate degree centrality
  degr_cent <- centr_degree(G, mode = 'all')
  degr_cent <- degr_cent$res
  degr_cent
  
  # Calculate eigenvector centrality
  eign_cent <- eigen_centrality(G)
  eign_cent <- eign_cent$vector
  eign_cent
  
  # Calculate closeness centrality
  clos_cent <- igraph::closeness(G)
  clos_cent
  
  # Calculate betweenness centrality
  betw_cent <- igraph::betweenness(G)
  betw_cent
  
  # Create a data frame with all centrality measures
  data <- data.frame(vertex = nodes,  # Nodes are the questionnaire items
                     degree = degr_cent, 
                     eigen = eign_cent, 
                     closeness = clos_cent, 
                     betweenness = betw_cent)
  
  # Sort the nodes by degree centrality (from highest to lowest)
  data <- data %>% arrange(desc(degree))
  
  # Display the sorted data
  print(data)
  
  # Community detection using modularity maximization (Fast Greedy Algorithm)
  G <- simplify(G, remove.multiple = TRUE, remove.loops = TRUE)
  
  # Apply modularity-based community detection
  mod_groups <- cluster_fast_greedy(G)
  mod_groups <- mod_groups$membership
  
  # Display number of detected communities
  length(unique(mod_groups))
  
  # Plot network showing communities using modularity maximization
  par(mfrow = c(1, 2))  # Display two plots side by side
  plot(G, vertex.color = mod_groups, # Color nodes based on their community
       edge.color = 'black',
       vertex.size = 20,  
       vertex.shape = 'circle',  
       asp = 0,
       layout = layout_in_circle, 
       main = 'Modularity Maximization')
  
  # Display the node names
  V(G)$name
  V(G)$name <- nodes  # Replace 'nodes' with the actual node names
  
  # Plot network with node names and community coloring
  plot(G, vertex.color = mod_groups,  
       edge.color = 'black',  
       vertex.size = 20,  
       vertex.shape = 'circle',  
       vertex.label = V(G)$name,  # Show real node names
       vertex.label.cex = 0.8,    # Adjust text size
       asp = 0,
       layout = layout_in_circle, 
       main = 'Detected Communities')
  
  # Plot network with force-directed layout
  plot(G, vertex.color = mod_groups,  
       edge.color = 'gray',
       vertex.size = 20,  
       vertex.shape = 'circle',  
       vertex.label = V(G)$name,  
       vertex.label.cex = 0.8,  
       layout = layout_with_fr,  
       main = 'Communities in the Network')
  
  # Create a data frame with node names and their assigned groups
  grupos_df <- data.frame(vertex = V(G)$name, group = mod_groups)
  print(grupos_df)
  
  # Merge centrality data with group information
  data <- merge(data, grupos_df, by = "vertex", all.x = TRUE)
  print(head(data))
  
  # Sort items based on group assignment
  data <- data[order(data$group), ]  
  
  # Display items grouped by their assigned communities
  library(dplyr)
  for (i in unique(data$group)) {
    cat("\nGroup", i, ":\n")
    print(data %>% filter(group == i))
  }
}

#* Version 2: Community Detection using Edge Betweenness-----
{
  # Apply Edge Betweenness-based community detection algorithm
  btw_groups <- cluster_edge_betweenness(G)
  btw_groups <- btw_groups$membership  # Extract the detected groups
  
  # Plot network showing communities using Edge Betweenness
  plot(G, vertex.color = btw_groups, # Color nodes based on their community
       edge.color = 'black',
       vertex.size = 20,
       vertex.shape = 'circle',
       asp = 0,
       layout = layout_in_circle, 
       main = 'Edge Betweenness')
  
  # Display number of clusters detected by Edge Betweenness
  length(unique(btw_groups))
  
  # Display node names
  V(G)$name
  V(G)$name <- nodes  # Replace 'nodes' with the actual node names
  
  # Plot network with Edge Betweenness community coloring
  plot(G, vertex.color = btw_groups,  
       edge.color = 'black',  
       vertex.size = 20,  
       vertex.shape = 'circle',  
       vertex.label = V(G)$name,  
       vertex.label.cex = 0.8,    
       asp = 0,
       layout = layout_in_circle, 
       main = 'Detected Communities by Edge Betweenness')
  
  # Plot network using force-directed layout
  plot(G, vertex.color = btw_groups,  
       edge.color = 'black',  
       vertex.size = 20,  
       vertex.shape = 'circle',  
       vertex.label = V(G)$name,  
       vertex.label.cex = 0.8,  
       layout = layout_with_fr,  
       main = 'Communities in the Network (Edge Betweenness)')
  
  # Remove isolated items based on eigenvector centrality
  data <- data %>% arrange(eigen)
  
  # Assign random weights to edges
  set.seed(123)
  E(G)$weight <- runif(ecount(G), min = 0, max = 1)  # Random values between 0 and 1
  
  # Calculate threshold based on edge weights
  umbral <- quantile(E(G)$weight, 0.75)
  G_strong <- subgraph.edges(G, E(G)[weight > umbral])
  plot(G_strong, layout = layout_with_fr)
  
  # Assign edge weights based on node degrees
  E(G)$weight <- degree(G)[ends(G, E(G))[,1]] + degree(G)[ends(G, E(G))[,2]]
  
  # Highlight strong connections based on weight
  E(G)$width <- scales::rescale(E(G)$weight, to = c(1, 5))
  E(G)$color <- ifelse(E(G)$weight > median(E(G)$weight), "red", "gray")
  
  # Plot the network with strong connections highlighted
  plot(G, layout = layout_with_fr)
  
  # Assign edge weights again based on node degrees and detect communities
  E(G)$weight <- degree(G)[ends(G, E(G))[,1]] + degree(G)[ends(G, E(G))[,2]]
  comunidades <- cluster_fast_greedy(G)
  membresia <- comunidades$membership  # Extract community membership
  
  # Highlight strong connections with color and width
  E(G)$width <- rescale(E(G)$weight, to = c(1, 5))  # Thickness based on weight
  E(G)$color <- ifelse(E(G)$weight > median(E(G)$weight), "red", "gray")  # Color by weight
  
  # Plot network with communities highlighted
  plot(G, 
       layout = layout_with_fr, 
       vertex.color = membresia,   # Each community gets a color
       vertex.size = 15,           # Adjust node size
       vertex.label.color = "black", 
       edge.color = E(G)$color,    # Highlight strong connections
       edge.width = E(G)$width)    # Adjust edge thickness

  btw_groups <- cluster_edge_betweenness(G)
  btw_groups <- btw_groups$membership  # Obtener la asignación de comunidades
  
  # Create a dataframe with the metrics for each node
  centrality_df <- data.frame(
    vertex = V(G)$name,  # Node names
    degree = degree(G),  # Degree centrality
    eigen = eigen_centrality(G)$vector,  # Eigenvector centrality
    closeness = closeness(G),  # Closeness centrality
    betweenness = betweenness(G),  # Betweenness centrality
    group = btw_groups  # The community the node belongs to
  )
  
  # Create a table for each community group
  grouped_tables <- lapply(unique(btw_groups), function(group_id) {
    group_data <- centrality_df %>% filter(group == group_id)
    group_table <- group_data %>%
      select(vertex, degree, eigen, closeness, betweenness, group) %>%  # Select relevant columns
      arrange(degree)  # You can sort by any other metric if preferred
    return(group_table)
    
    # Print each group to the console
    for (i in 1:length(grouped_tables)) {
      cat("\nGroup ", i, " :\n")
      print(grouped_tables[[i]])
      
  
  }



