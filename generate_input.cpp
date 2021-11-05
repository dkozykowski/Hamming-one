#include <iostream>
#include <fstream>
using namespace std;

#define DEFAULT_L_VALUE 1500
#define DEFAULT_M_VALUE (int)1e5
#define MIN_L_VALUE 31
#define MIN_M_VALUE 5
#define ERR(source) (fprintf(stderr,"%s:%d\n",__FILE__,__LINE__),\
                     perror(source),\
                     exit(EXIT_FAILURE))

void usage(char *name){
    fprintf(stderr,"USAGE: %s <output_file_path> [L] [M]\n",name);
    fprintf(stderr,"L - sequence lenght [OPTIONAL, L = 1500], 1000 <= L\n");
    fprintf(stderr,"M - number of sequences [OPTIONAL, M = 1e5], (int)1e5 <= M\n");
    exit(EXIT_FAILURE);
}

void write_data_to_file(char * file_path, bool * output, const int& L, const int& M) {
    ofstream fileStream;
    fileStream.open(file_path, ios::out | ios::trunc);
    if (!fileStream.is_open()) ERR("ostream.open");

    fileStream << L << " " << M << "\n";

    for (int i = 0; i < M; i++) {
        for (int o = 0; o < L; o++) {
            fileStream << output[o + i * L] << " ";
        }
        fileStream << "\n";
    }
    fileStream.close();
}

void generate_data(bool * output, const int& L, const int& M) {
    srand(time(NULL));
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < L; j++) {
            output[j + i *  L] = rand() % 2;
        }
    }

    int duplicated_rows_num = rand() % M;
    for (int p = 0; p < duplicated_rows_num; p++) {
        int row1, row2;
        row1 = rand() % M;
        do
        {
            row2 = rand() % M;
        } while (row2 == row1);
        
        for (int i = 0; i < L; i++) {
            output[i + row2 * L] = output[i + row1 * L];
        }
        if (rand() % 5  < 2) {
            int pos_of_diff = rand() % L;
            output[pos_of_diff + row2 * L] = !output[pos_of_diff + row1 * L];
        }
    }
}

int main(int argc, char ** argv) {
    int L, M;
    L = DEFAULT_L_VALUE;
    M = DEFAULT_M_VALUE;

    if (argc > 4 || argc < 2) usage(argv[0]);
    if (argc == 4) M = atoi(argv[3]);
    if (argc >= 3) L = atoi(argv[2]);

    bool* output = new bool[L * M];
    if (output == nullptr) ERR("operator new");

    generate_data(output, L, M);
    write_data_to_file(argv[1], output, L, M);

    delete[] output;
}