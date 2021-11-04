all: hamming_one_cpu hamming_one_gpu generate_input test_solution

hamming_one_cpu: hamming_one_cpu.cpp
	g++ -Wall -o hamming_one_cpu hamming_one_cpu.cpp -std=gnu++0x

hamming_one_gpu: hamming_one_gpu.cu
	nvcc hamming_one_gpu.cu -o hamming_one_gpu

generate_input: generate_input.cpp
	g++ -Wall -o generate_input generate_input.cpp -std=gnu++0x

test_solution: test_solution.cpp
	g++ -Wall -o test_solution test_solution.cpp -std=gnu++0x

clean:
	rm hamming_one_cpu hamming_one_gpu generate_input test_solution

.PHONY: clean
