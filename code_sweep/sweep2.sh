#!/bin/bash

#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 8
#SBATCH --time=72:00:00
#SBATCH --mem=16GB

# Configure notifications
#SBATCH --mail-type=ALL
#SBATCH --mail-user=phillip.j.brown@adelaide.edu.au
module load matlab/2016b
matlab -nodisplay -nodesktop -r "phoenix_sweep_2; quit()"