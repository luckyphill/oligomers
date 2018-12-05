#!/bin/bash
# gets all the files on phoenix and sends any modifications to phoenix

# transfers data from server to local directory
# ignores hidden folders: -f"- .*/"
# adds non-hidden folders: -f"+ */"
# ignores files in the base directory: -f"- *"
# rsync -avz --progress -f"- .*/" -f"- output/" -f"- */code/" -f"+ */" -f"+ */*" -f"- *"   a1738927@phoenix.adelaide.edu.au:/fast/users/a1738927/Oligomers/ .

# transfers Matlab code for creating the parameter space sweeps
# ignores folders and their contents: -f"- */"
# adds .m and .sh files: -f"+ *.m" -f"+ *.sh"
# ignores any other file eg. pdfs: -f"- *.*"
# removes anything in the destination folder that isn't being transfered: --delete
rsync -avz --progress -f"- */data/" -f"- */images/" -f"+ *.m" -f"+ *.sh" -f"+ *.csv" -f"- *.*" --delete . a1738927@phoenix.adelaide.edu.au:/fast/users/a1738927/Oligomers/
