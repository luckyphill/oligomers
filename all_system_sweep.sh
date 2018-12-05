#!/bin/bash

# Autocleavage, now known as selfbreakage
sbatch MnUBacmb/code/MnUBacmb_array.sh
sbatch MnUBacob/code/MnUBacob_array.sh
sbatch MnUBacobas/code/MnUBacobas_array.sh

# Monomer shedding
sbatch MnUBmsmb/code/MnUBmsmb_array.sh
sbatch MnUBmsob/code/MnUBmsob_array.sh
sbatch MnUBmsobas/code/MnUBmsobas_array.sh

# Proportional breakage unit
sbatch MnUBpcmb/code/MnUBpcmb_array.sh
sbatch MnUBpcob/code/MnUBpcob_array.sh
sbatch MnUBpcobas/code/MnUBpcobas_array.sh

# Proportional breakage weight
sbatch MnUBpcmb/code/MnUBpcmb_w_array.sh
sbatch MnUBpcob/code/MnUBpcob_w_array.sh
sbatch MnUBpcobas/code/MnUBpcobas_w_array.sh

# Unspecified breakage
sbatch MnUBubmb/code/MnUBubmb_array.sh
sbatch MnUBubob/code/MnUBubob_array.sh
sbatch MnUBubobas/code/MnUBubobas_array.sh