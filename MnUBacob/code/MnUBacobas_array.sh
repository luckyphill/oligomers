#!/bin/bash 
#SBATCH -p batch 
#SBATCH -N 1 
#SBATCH -n 1 
#SBATCH --time=72:00:00 
#SBATCH --mem=2GB 
#SBATCH --array=0-945
#SBATCH --err="output/MnUBacobas_%a.err" 
#SBATCH --output="output/MnUBacobas_%a.out" 
#SBATCH --job-name="MnUBacobas"
# NOTIFICATIONS
#SBATCH --mail-type=ALL
#SBATCH --mail-user=phillip.j.brown@adelaide.edu.au

module load matlab/2016b
mkdir -p output 

echo "array_job_index: $SLURM_ARRAY_TASK_ID" 
i=1 
found=0 
while IFS=, read n K3 K6 q
do 
    if [ $i = $SLURM_ARRAY_TASK_ID ]; then 
        echo "MnUBacobas_sweep($n,1e$K3,1e$K6,$q,100)"
        found=1 
        break 
    fi 
    i=$((i + 1)) 
done < args_q.csv 
if [ $found = 1 ]; then 
  matlab -nodisplay -nodesktop -singleCompThread -r "addpath(genpath(pwd)); MnUBacobas_sweep($n,1e$K3,1e$K6,$q,100); quit()"
else 
  echo "args.csv does not have enough parameters for $SLURM_ARRAY_TASK_ID index" 
fi