homedir=~
eval homedir=$homedir
echo $homedir
export GUROBI_HOME="$homedir/gurobi750/linux64" 
export PATH="${PATH}:${GUROBI_HOME}/bin" 
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${GUROBI_HOME}/lib"
export GRB_LICENSE_FILE="$homedir/system/gurobi.lic"
ssh -f -N -L 41954:localhost:41954 vvv@license.lanlytics.com
