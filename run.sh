make
echo "Generating input"
./generate_input input.txt 1500 500

echo "Running CPU"
CPU_START_TIME=$(date +%s%N | cut -b1-13)
./hamming_one_cpu input.txt > output1.txt
CPU_END_TIME=$(date +%s%N | cut -b1-13)

echo "Running GPU"
GPU_START_TIME=$(date +%s%N | cut -b1-13)
./hamming_one_gpu input.txt > output2.txt
GPU_END_TIME=$(date +%s%N | cut -b1-13)

echo `./test_solution output1.txt output2.txt` 

echo "Cleaning files"
make clean
rm input.txt output1.txt output2.txt

echo "CPU calculations took $(($CPU_END_TIME - $CPU_START_TIME)) miliseconds to complete"
echo "GPU calculations took $(($GPU_END_TIME - $GPU_START_TIME)) miliseconds to complete"