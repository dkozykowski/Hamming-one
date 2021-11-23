all: hamming_one_cpu hamming_one_gpu hamming_one_optimised_gpu generate_input test_solution

hamming_one_cpu: hamming_one_cpu.cpp
	g++ -Wall -o hamming_one_cpu hamming_one_cpu.cpp -std=gnu++0x

hamming_one_gpu: hamming_one_gpu.cu
	nvcc hamming_one_gpu.cu -o hamming_one_gpu

hamming_one_optimised_gpu: hamming_one_optimised_gpu.cu
	nvcc hamming_one_optimised_gpu.cu -o hamming_one_optimised_gpu

generate_input: generate_input.cu
	nvcc generate_input.cu -o generate_input

test_solution: test_solution.cpp
	g++ -Wall -o test_solution test_solution.cpp -std=gnu++0x

clean:
	rm hamming_one_cpu hamming_one_gpu generate_input test_solution

.PHONY: clean
