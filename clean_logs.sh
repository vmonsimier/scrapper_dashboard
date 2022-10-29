files=$(basename -a ./run_script/management/logs/*)

for file in $files
do
    true > ./run_script/management/logs/$file
done
