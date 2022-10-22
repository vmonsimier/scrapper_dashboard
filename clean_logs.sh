files=$(basename -a ./run_script/management/commands/logs/*)

for file in $files
do
    true > ./run_script/management/commands/logs/$file
done
