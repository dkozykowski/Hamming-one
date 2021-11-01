#include <iostream>
#include <fstream>
using namespace std;

#define INPUT_FILE_NAME "input.txt"

void read_input(int& L, int& M, bool*& input) {
    ifstream fileStream;    
    fileStream.open(INPUT_FILE_NAME, ios::in);
    if (!fileStream.is_open()) exit(-1);
    fileStream >> L >> M;

    input = new bool[L * M];
    if (input == nullptr) exit(-1);

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
            for (int j = 0; j < L; j++) {
                if (input[j + o * L] != input[j + i * L]) hamming_distance++;
            }

            if (hamming_distance == 1) {
                cout << i << " " << o << "\n";
            }
        }
    }
}

int main(int argc, char ** argv) {
    int L, M;
    bool* input;
    read_input(L, M, input);
    find_hamming_one(L, M, input);

    return 0;
}