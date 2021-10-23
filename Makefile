main: main.cu
    nvcc main.cu -o main

clean:
    rm main

.PHONY: clean