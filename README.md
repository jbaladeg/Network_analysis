# 🕸️ What's the Deal with Network Analysis?

## Table of Contents

1. [Introduction](#introduction)
2. [Network analysis example](#network-analysis-example)
   1. [version 1: via Modularity Maximization](#version-1-via-modularity-maximization)
      1. [Setp 1 - create the line base](#setp-1---create-the-line-base)
      2. [Setp 2 - charts](#setp-2---charts)
      3. [Setp 3 - tables](#setp-3---tables)
      4. [Interpretation](#interpretation)
   2. [version 2: via Edge Betweenness](#version-2-via-edge-betweenness)
      1. [Setp 1 - create the line base](#setp-1---create-the-line-base-1)
      2. [Setp 2 - charts](#setp-2---charts-1)
      3. [Setp 3 - tables](#setp-3---tables-1)
      4. [Setp 4 - Interpretation](#setp-4---interpretation)


## Introduction
Network analysis is all about exploring relationships — between people, survey items, ideas, you name it. If you've ever looked at a bunch of things and wondered who's central, how everything's connected, or which little groups are forming... congrats, you're already thinking like a network analyst.

A network is made up of:

⚜️ Nodes (or vertices) –> the elements of your network. These could be people, test items, companies, etc.
⚜️ Edges (or links) –> the connections between them. These represent relationships, interactions, correlations — any kind of tie.

And with that simple setup, you can discover some very cool stuff:

1- 🔍 Who's the VIP in the network?
That’s where centrality measures come in. They help you figure out who’s playing an important role:

🌐 Degree Centrality – Who has the most connections?
🌐 Betweenness Centrality – Who acts as a bridge between different parts of the network?
🌐 Closeness Centrality – Who can reach everyone else the fastest?
🌐 Eigenvector Centrality – Who’s connected to other well-connected nodes?

2- 👥 Who’s hanging out with whom?
With community detection techniques, you can identify clusters — groups that naturally form based on the connections. And if you want to see how “strong” these groupings are, that’s what modularity is for.
There are two different ways to detect groups. When it comes to detecting communities in a network — basically figuring out who’s sticking together — there are a couple of popular approaches: 

🌷 One is modularity maximization, , which looks for groupings of nodes that are more tightly connected with each other than with the rest of the network. It’s great when you want a fast and pretty solid guess at how a network naturally splits into clusters.

🌷 The other method is edge betweenness, which identifies the edges (connections) that act as bridges between different parts of the network. It’s more computationally intensive, but can be more accurate when your network has complex structures or overlapping groups.

Both approaches give different perspectives on how a network might be organized underneath the surface. So, if you're working with large networks and want quick insights, go with modularity. But if you’re diving deep into the network’s structure and want precision, edge betweenness might be the way to go.

## Network analysis example

An example of the use of this type of analysis is with the items of a questionnaire. With network analysis we can know how many communities (or groups) the items are divided into, as well as how many and to what extent the items are connected to each other. In this example we will use "bfi" data base in R.

This database compiles a series of items from a questionnaire ranging from column 1 to column 25. The aim of this example is know how many groups/dimensions our ietms are divided into and how they relate to each other.

### version 1: via Modularity Mazimization.
#### Setp 1 - create the line base
- create the nodos with the target variables and transform in a data frame
- create a correlation matrix and transform in a data frame
- stablish only significant conexions (> 0.2)
- create a new "variable" called group
- stablish: 1) degree centrality; 2) eignvector centrality; 3) closeness centrality; 4) betweeness centrality
- create the final graph
- create the final table with all the information


#### Setp 2 - charts

- closeness centrality chart
![image](https://github.com/user-attachments/assets/455f4912-6f6b-48a2-a874-a84cec40cd87)

- vertices chart
![image](https://github.com/user-attachments/assets/699adbfa-794d-4835-be70-ff6be5d08cce)

- cartesian chart 

![image](https://github.com/user-attachments/assets/f01c3c3b-0a0d-4983-821a-ebe13c50db36)

- vertices separated by group
![image](https://github.com/user-attachments/assets/a8fc3c5a-d6ae-4fff-b5a7-8ef76dd98e0f)

- vertices separed by group with the name of the real variables
![image](https://github.com/user-attachments/assets/9d454a4f-a215-4e58-8bea-dda971d5c666)

- the final chart:
![image](https://github.com/user-attachments/assets/922e2bab-9a85-41ca-91f8-ba7d094b0d3f)

### Setp 3 - tables

```
Grupo 1 :
   vertex degree     eigen   closeness betweenness group
1      A2     12 0.8118833 0.002932551   0.6166667     1
2      A3     14 0.9168407 0.002941176   1.2333333     1
3      A4     10 0.6015695 0.002915452   2.0000000     1
4      A5     14 0.9168407 0.002941176   1.2333333     1
5      C1      6 0.2423635 0.002906977   0.0000000     1
6      C2      8 0.3230158 0.002915452   2.2833333     1
7      C3      6 0.2423635 0.002906977   0.0000000     1
8      E3     14 0.8917062 0.002941176   2.0333333     1
9      E4     14 0.9168407 0.002941176   1.2333333     1
10     E5     20 1.0000000 0.002967359  21.1166667     1
11     O1      6 0.4140956 0.002898551   0.0000000     1
12     O3     12 0.7828572 0.002932551   1.2500000     1

Grupo 2 :
   vertex degree                    eigen   closeness betweenness group
1      C4     12 0.0000000000000014331451 0.002932551  18.5000000     2
2      C5     12 0.0000000000000016428737 0.002923977   1.5833333     2
3      E1      4 0.0000000000000005592761 0.002873563   0.0000000     2
4      E2     10 0.0000000000000011535070 0.002915452   3.4500000     2
5      N1     12 0.0000000000000016428737 0.002923977   1.7000000     2
6      N2     10 0.0000000000000014331451 0.002898551   0.2000000     2
7      N3     12 0.0000000000000017127832 0.002923977   1.7000000     2
8      N4     18 0.0000000000000020623308 0.002949853  18.0333333     2
9      N5     10 0.0000000000000012583713 0.002898551   0.8333333     2
10     O4      2 0.0000000000000003495476 0.002865330   0.0000000     2

Grupo 3 :
  vertex degree                    eigen   closeness betweenness group
1     O2      4 0.0000000000000003364396 0.002865330          10     3
2     O5      2 0.0000000000000001234340 0.002785515           0     3

Grupo 4 :
  vertex degree eigen   closeness betweenness group
1     A1      0     0 0.001666667           0     4
```

#### Interpretation

Based on centrality metrics (degree, eigenvector, closeness, and betweenness), the network was divided into four communities with distinct structural roles:

Group 1
This is the most central and densely connected group in the network. It contains nodes with the highest degree, eigenvector, and betweenness centrality (e.g., vertex E5 with the highest degree of 20 and exceptional betweenness). These nodes likely act as core hubs, playing crucial roles in information flow and overall connectivity.

Group 2
Nodes in this group show moderate to high degrees, but with negligible eigenvector scores. This suggests that while they are connected, their links are not to other highly influential nodes. They could be considered structural bridges or supporting agents, especially since some (like C4 and N4) exhibit high betweenness scores, indicating they facilitate connections between groups.

Group 3
A smaller cluster with only two nodes (O2 and O5), characterized by low degree and centrality measures, except for O2, which has a noticeable betweenness value. These nodes may represent peripheral actors or isolated brokers—not deeply integrated into the core structure but potentially important for specific, isolated paths.

Group 4
Comprising a single disconnected node (A1), this group reflects complete isolation in the network. It highlights that not all nodes are necessarily part of the main interaction flow and can be entirely excluded from the communication dynamics.

### version 2: via Edge Betweenness.
#### Setp 1 - create the line base

(follow the same steps as the first form)
- stablish the clusters basing on the edge betweenness
- Remove isolated items based on eigenvector centrality

#### Setp 2 - charts

- Calculate threshold based on edge weights
![image](https://github.com/user-attachments/assets/67c8b780-953c-4b01-9533-bd1cf1b2ba5d)

- network with strong connections highlighted chart
![image](https://github.com/user-attachments/assets/d6b4dd8a-8eb5-49a3-8a14-485306e8268b)

- final chart with new communities stablished basing on the edge betweenness
![image](https://github.com/user-attachments/assets/724145d9-a68d-4c2e-b265-1ab6c6561d99)

#### Setp 3 - tables
```
Grupo  1  :
   vertex degree                     eigen   closeness betweenness group
A1     A1      0 0.00000000000000006045038 0.001666667           0     1

Grupo  2  :
   vertex degree     eigen   closeness betweenness group
C1     C1      3 0.1732898 0.001776199   0.0000000     2
C3     C3      3 0.1732898 0.001776199   0.0000000     2
O1     O1      3 0.3025023 0.001788909   0.0000000     2
C2     C2      4 0.2262687 0.001876173  11.0000000     2
A4     A4      5 0.4415642 0.001926782  12.0000000     2
A2     A2      6 0.7085166 0.001897533   1.2500000     2
O3     O3      6 0.6848397 0.001848429   3.7500000     2
A3     A3      7 0.8328011 0.001919386   0.8333333     2
A5     A5      7 0.8328011 0.001919386   0.8333333     2
E3     E3      7 0.8109715 0.001869159   1.5000000     2
E4     E4      7 0.8328011 0.001919386   0.8333333     2
E5     E5     10 1.0000000 0.001996008   9.0000000     2

Grupo  3  :
   vertex degree                     eigen   closeness betweenness group
O4     O4      1 0.00000000000000000000000 0.001675042         0.0     3
O5     O5      1 0.00000000000000004734963 0.001703578         0.0     3
E1     E1      2 0.00000000000000000000000 0.001821494         0.0     3
O2     O2      2 0.00000000000000000000000 0.001795332        10.0     3
E2     E2      5 0.00000000000000000000000 0.001980198         8.5     3
N2     N2      5 0.00000000000000000000000 0.001855288         0.5     3
N5     N5      5 0.00000000000000000000000 0.001904762         3.0     3
C4     C4      6 0.00000000000000000000000 0.002028398        18.0     3
C5     C5      6 0.00000000000000000000000 0.001980198         1.0     3
N1     N1      6 0.00000000000000000000000 0.001949318         1.0     3
N3     N3      6 0.00000000000000000000000 0.001949318         1.0     3
N4     N4      9 0.00000000000000000000000 0.002012072        13.0     3
```
#### Setp 4 - Interpretation

Group 1
Group 1 consists of a single node, A1, which shows extremely low centrality across all metrics. The degree of node A1 is 0, meaning it has no connections to any other nodes in the network, making it isolated. The eigenvector centrality is very close to zero (0.00000000000000006045038), indicating that A1 has no influence on the network as it is disconnected from other nodes. The closeness of A1 is also very low (0.001666667), reinforcing its isolation in the network, and it is distant from all other nodes. Finally, betweenness centrality is 0, which means A1 does not act as a bridge or intermediary between any nodes. In conclusion, A1 is a peripheral and disconnected node, with no role in facilitating communication or information flow within the network.

Group 2
Group 2 consists of nodes that exhibit more connectivity and centrality within the network. Many nodes in this group, such as A2, A3, A4, and A5, have relatively high degree values (ranging from 6 to 10), meaning they are well-connected to other nodes. The eigenvector centrality values for these nodes range from 0.173 to 1.000, with nodes like A5 having a perfect eigenvector centrality of 1. This suggests that these nodes are influential in the network, with some of them having high centrality. Nodes like A2 and A3 also show relatively high closeness centrality values (0.0018 to 0.0019), which indicates they are reasonably well-placed to access other nodes in the network quickly. The betweenness centrality for these nodes varies, with some having higher betweenness values (e.g., A2 with 1.25 and A3 with 0.83), suggesting these nodes might serve as bridges between different parts of the network. Overall, Group 2 represents a set of relatively well-connected nodes with moderate to high centrality, indicating they play important roles in network connectivity and information flow.

Group 3
Group 3 contains nodes that are less connected but still play some role in the network's structure. Nodes in this group show degree values between 1 and 9, with many nodes having a degree of 2 or 5, suggesting that they are relatively isolated but not entirely disconnected. The eigenvector centrality for these nodes is very low (close to 0), indicating that they hold little influence in the overall network. The closeness centrality values for nodes in Group 3 are also low, further reinforcing their isolated nature within the network. Betweenness centrality values for this group vary from 0 to 18, with nodes like C4 having a high betweenness centrality of 18, suggesting it might play an important role in connecting different parts of the network. Overall, Group 3 consists of nodes with low centrality values, and while they are not well-connected, certain nodes like C4 and E2 may serve as important bridges for specific substructures within the network.
