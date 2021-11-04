// Hamming One
// Architecture: GPU
// Complexity: L * M^2
//

#include <iostream>
#include <fstream>
#include <cstring>
using namespace std;

#define BITS_IN_INT 31
#define ERR(source) (fprintf(stderr,"%s:%d\n",__FILE__,__LINE__),\
                     perror(source),\
                     exit(EXIT_FAILURE))

void usage(char *name){
    fprintf(stderr,"USAGE: %s <input_file_path>\n",name);
    exit(EXIT_FAILURE);
}

int _ceil(double variable) {
    int new_variable = (int)variable;
    if ((double)new_variable == variable) return new_variable;
    else return new_variable + 1;
}

void read_input(char* file_path, int& L, int& M, int*& h_input) {
    ifstream fileStream;    
    fileStream.open(file_path, ios::in);
    if (!fileStream.is_open()) ERR("ifstream.open");
    fileStream >> L >> M;

    int newL = _ceil((double)L / BITS_IN_INT);

    h_input = new int[newL * M];
    if (h_input == NULL) ERR("operator new");
    memset(h_input, 0, sizeof(int) * newL * M);

    int current_bit;
    for (int i = 0; i < M; i++) {
        for (int o = 0; o < newL; o++) {
            for (int j = 0; j < BITS_IN_INT && o * BITS_IN_INT + j < L; j++) {
                fileStream >> current_bit;
                h_input[o + i * newL] = (h_input[o + i * newL] << 1) + current_bit;
            }
        }
    }
    L = newL;
}

__global__ void find_hamming_one(int* d_input, bool* d_output, int L, int M) {
    int index = blockIdx.x * 1024 + threadIdx.x;
    int hamming_distance;
    for (int i = index + 1; i < M; i++) {
        hamming_distance = 0;

        for (int o = 0; o < L; o++) {
            int num = d_input[o + index * L] ^ d_input[o + i * L];
            while(num != 0) {
                hamming_distance += (num & 1);
                num >>= 1;
            }
        }
        d_output[i + index * M] = (hamming_distance == 1);
    }
}

int main(int argc, char ** argv) {
    if (argc != 2) usage(argv[0]);
    int L, M;
    int *h_input, *d_input;
    bool *h_output, *d_output;
    read_input(argv[1], L, M, h_input);

    cudaMalloc(&d_input, L * M * sizeof(int));
    cudaMemcpy(d_input, h_input, L * M * sizeof(int), cudaMemcpyHostToDevice);
    delete[] h_input;

    cudaMalloc(&d_output, M * M);
    cudaMemset(d_output, 0, M * M);
    h_output = new bool[M * M];
    if (h_output == NULL) ERR("operator new");

    int threads, blocks;
    threads = 1024;
    blocks = _ceil((double)M / threads);

    find_hamming_one<<<blocks, threads>>>(d_input, d_output, L, M);
    cudaMemcpy(h_output, d_output, M * M, cudaMemcpyDeviceToHost);

    for (int i = 0; i < M; i++) {
        for (int o = i + 1; o < M; o++) {
            if (h_output[o + i * M]) {
                cout << i << " " << o << "\n";
            }
        }
    }

    cudaFree(d_input);
    cudaFree(d_output);
    delete[] h_output;
    return EXIT_SUCCESS;
}