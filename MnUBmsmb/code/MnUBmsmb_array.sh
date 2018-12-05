#!/bin/bash 
#SBATCH -p batch 
#SBATCH -N 1 
#SBATCH -n 1 
#SBATCH --time=72:00:00 
#SBATCH --mem=2GB 
#SBATCH --array=0-315
#SBATCH --err="output/MnUBmsmb_%a.err" 
#SBATCH --output="output/MnUBmsmb_%a.out" 
#SBATCH --job-name="MnUBmsmb"
# NOTIFICATIONS
#SBATCH --mail-type=ALL
#SBATCH --mail-user=phillip.j.brown@adelaide.edu.au

module load matlab/2016b
mkdir -p output 

echo "array_job_index: $SLURM_ARRAY_TASK_ID" 
i=1 
found=0 
while IFS=, read n K3 K6
do 
    if [ $i = $SLURM_ARRAY_TASK_ID ]; then 
        echo "MnUBmsmb_sweep($n,1e$K3,1e$K6,100)"
        found=1 
        break 
    fi 
    i=$((i + 1)) 
done < args.csv 
if [ $found = 1 ]; then 
  matlab -nodisplay -nodesktop -singleCompThread -r "addpath(genpath(pwd)); MnUBmsmb_sweep($n,1e$K3,1e$K6,100); quit()"
else 
  echo "args.csv does not have enough parameters for $SLURM_ARRAY_TASK_ID index" 
fi