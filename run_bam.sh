time=$(date +%Y%m%d_%H%M%S)
filename=baseline.py
logname="logs/$time.log"
# echo $name
# echo $time
# echo $filename
# sh clean.sh
echo 'please input device num:'
read device
CUDA_VISIBLE_DEVICES=$device python -u $filename | tee $logname