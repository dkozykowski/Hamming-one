all: hamming_one_cpu hamming_one_gpu

hamming_one_cpu: hamming_one_cpu.cpp
	g++ -Wall -o hamming_one_cpu hamming_one_cpu.cpp -std=gnu++0x

hamming_one_gpu: hamming_one_gpu.cu
	nvcc hamming_one_gpu.cu -o hamming_one_gpu

clean:
	rm hamming_one_cpu hamming_one_gpu

.PHONY: clean
