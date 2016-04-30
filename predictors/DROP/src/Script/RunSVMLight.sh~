#! /bin/bash

if [ $# -ne 4 ];
then
	echo "RunSVMLight.sh [option file] [Model file] [TMP dir] [basename]"
	exit 1
fi

test -d ${3}/SVM_Output/ || mkdir ${3}/SVM_Output/

while read file
do
	FLAG=$(echo ${file} | cut -f 1 -d " ")
	if test "${FLAG}" == "SVM_DIR";
	then
		SVM_DIR=$(echo ${file} | cut -f 3 -d " ")
	fi
done < ${1}

${SVM_DIR}/svm_classify ${3}/${4}.vec ${2} ${3}/SVM_Output/${4}.txt

