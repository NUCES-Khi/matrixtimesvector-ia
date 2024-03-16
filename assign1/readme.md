# Assignment 1
## Team Members
|std_id|Name|
|--------|-|
|K21-3119|Muhammad Ayan|
|K21-3093|Muhammad Ibrahim|

## Output Screenshots
Output was very long hence full output video is recorded and uploaded as file 2_Terminal_Output.webm
Just a glimpse of output
![image](https://github.com/NUCES-Khi/matrixtimesvector-ia/assets/127008532/ecaabe0c-44d5-4755-8ab0-3e0045406eb9)

## Results and Analysis
Graph plots are in pdf as file 1_Plot_Output

## Major Problems Encountered
1. Scalability Issues with Input Size: As the input size increases, the running time also increases for all programming models. This is evident in the progression of running averages across different input sizes, indicating that as the computational workload grows, the execution time becomes significantly higher. For the MPI and OpenMP models, adjusting the level of parallelism and fine-tuning the workload distribution among processors could address some of the scalability issues. 
   
2. Variability in Performance Between Models: There's a notable difference in performance between the sequential, OpenMP, and MPI models, with and without tiling. The sequential model tends to perform worse as the size increases, indicating its lack of scalability. OpenMP and MPI show better scalability but with notable variations, especially when comparing their standard and tiling implementations.

3. Inconsistent Performance Gains with Tiling: The use of tiling in OpenMP and MPI does not consistently yield better performance. In some cases, tiling improves the running average, while in others, it either has a negligible effect or worsens the performance. Optimizing the tiling parameters and the algorithm itself could lead to more consistent performance gains.
