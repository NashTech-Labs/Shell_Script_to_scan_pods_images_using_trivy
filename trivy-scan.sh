ListNamespaces=$(kubectl get namespaces -o name)
echo "List all NameSpace :${ListNamespaces}"

nextscan=0
#Read the particular namespace name for getting all pods inside it.

while [ $nextscan -ne 1 ]
do
read -p "Enter the user namespace: " nameSpace
echo "Selected namespace: $nameSpace"

#List the image used in pod.

List=$(kubectl get pods --namespace $nameSpace  -o jsonpath="{.items[*].spec.containers[*].image}"|tr -s '[[:space:]]' '\n' |sort
)
echo "Images Inside pods of Selected namespace : ${List}"

 for imagename in $List
    do  
        podName=`echo $imagename`
        echo "Print Scanning Image only : $imagename"
        Output=$(trivy image $imagename)
        echo "Output  : ${Output}"
    done

echo Number: $i
    nextscan=1
    echo "Do you want to scan again yes or no"  
    read temporary
    if [ $temporary = 'yes' ]; then
    nextscan=0
    fi
done









