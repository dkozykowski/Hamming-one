// Hamming One
// Architecture: CPU
// Complexity: L * M^2
//

#include <iostream>
#include <fstream>
using namespace std;

#define ERR(source) (fprintf(stderr,"%s:%d\n",__FILE__,__LINE__),\
                     perror(source),\
                     exit(EXIT_FAILURE))

void usage(char *name){
    fprintf(stderr,"USAGE: %s <input_file_path>\n",name);
    exit(EXIT_FAILURE);
}

void read_input(char* file_path, int& L, int& M, bool*& input) {
    ifstream fileStream;    
    fileStream.open(file_path, ios::in);
    if (!fileStream.is_open()) ERR("ifstream.open");
    fileStream >> L >> M;

    input = new bool[L * M];
    if (input == nullptr) ERR("operator new");

    for (int i = 0; i < M; i++) {
        for (int o = 0; o < L; o++) {
            fileStream >> input[o + i * L];
        }
    }
}

void find_hamming_one(const int& L, const int& M, bool*& input) {
    int hamming_distance;
    for (int i = 0; i < M; i++) {
        for (int o = i + 1; o < M; o++) { 
            hamming_distance = 0;
            for (int j = 0; j < L && hamming_distance <= 1; j++) {
                if (input[j + o * L] != input[j + i * L]) hamming_distance++;
            }

            if (hamming_distance == 1) {
                cout << i << " " << o << "\n";
            }
        }
    }
}

int main(int argc, char ** argv) {
    if (argc != 2) usage(argv[0]);
    int L, M;
    bool* input;
    read_input(argv[1], L, M, input);
    find_hamming_one(L, M, input);

    delete[] input;
    return EXIT_SUCCESS;
}