source .env || (echo "Please make an .env with var DOMAINS" && exit)
domains=($(echo $DOMAINS | sed 's/,/ /'))
echo "Found Domains:" ${domains[@]}
echo ${domains[0]}
