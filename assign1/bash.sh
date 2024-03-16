#!/bin/bash


# Compile the C codes
gcc -o seq seq.c
gcc -o omp omp.c -fopenmp
gcc -o omp_tiling omp_tiling.c -fopenmp
mpicc -o mpi mpi.c
mpicc -o mpi_tiling mpi_tiling.c


# Define the array of sizes
sizes=(64 128 256 512 1024 2048 4096 8192 16384 32768)


# Number of iterations
iterations=10


# Number of MPI processes
np=4


# CSV file name
csv_file="output.csv"


# Print CSV header
echo "Iteration, Program, Size, Current Time, Running Average" > $csv_file


# Run sequential code
for size in "${sizes[@]}"; do
    total_time=0

    for ((i=1; i<=$iterations; i++)); do
        echo -n "$i, ./seq, $size, "

        output=$(./seq $size 2>&1)

        current_time=$(echo "$output" | awk -F'[, ]' '/Test:/ {print $8}')
        total_time=$(echo "$total_time + $current_time" | bc -l)

        average_time=$(echo "$total_time / $i" | bc -l)
        echo "$current_time, $average_time"

        # Append data to CSV file
        echo "$i, ./seq, $size, $current_time, $average_time" >> $csv_file
    done

    echo
done


# Run OpenMP code
for size in "${sizes[@]}"; do
    total_time=0

    for ((i=1; i<=$iterations; i++)); do
        echo -n "$i, ./omp, $size, "

        output=$(./omp $size 2>&1)

        current_time=$(echo "$output" | awk -F'[, ]' '/Test:/ {print $8}')
        total_time=$(echo "$total_time + $current_time" | bc -l)

        average_time=$(echo "$total_time / $i" | bc -l)
        echo "$current_time, $average_time"

        # Append data to CSV file
        echo "$i, ./omp, $size, $current_time, $average_time" >> $csv_file
    done

    echo
done


# Run OpenMP with tiling code
for size in "${sizes[@]}"; do
    total_time=0

    for ((i=1; i<=$iterations; i++)); do
        echo -n "$i, ./omp_tiling, $size, "

        output=$(./omp_tiling $size 2>&1)

        current_time=$(echo "$output" | awk -F'[, ]' '/Test:/ {print $8}')
        total_time=$(echo "$total_time + $current_time" | bc -l)

        average_time=$(echo "$total_time / $i" | bc -l)
        echo "$current_time, $average_time"

        # Append data to CSV file
        echo "$i, ./omp_tiling, $size, $current_time, $average_time" >> $csv_file
    done

    echo
done


# Run MPI code
for size in "${sizes[@]}"; do
    total_time=0

    for ((i=1; i<=$iterations; i++)); do
        echo -n "$i, ./mpi, $size, "

        output=$(./mpi $size 2>&1)

        current_time=$(echo "$output" | awk -F'[, ]' '/Test:/ {print $8}')
        total_time=$(echo "$total_time + $current_time" | bc -l)

        average_time=$(echo "$total_time / $i" | bc -l)
        echo "$current_time, $average_time"

        # Append data to CSV file
        echo "$i, ./mpi, $size, $current_time, $average_time" >> $csv_file
    done

    echo
done


# Run MPI code  with tiling code
for size in "${sizes[@]}"; do
    total_time=0

    for ((i=1; i<=$iterations; i++)); do
        echo -n "$i, ./mpi_tiling, $size, "

        output=$(./mpi_tiling $size 2>&1)

        current_time=$(echo "$output" | awk -F'[, ]' '/Test:/ {print $8}')
        total_time=$(echo "$total_time + $current_time" | bc -l)

        average_time=$(echo "$total_time / $i" | bc -l)
        echo "$current_time, $average_time"

        # Append data to CSV file
        echo "$i, ./mpi_tiling, $size, $current_time, $average_time" >> $csv_file
    done

    echo
done

