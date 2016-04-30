#! /bin/bash

if [ $# -ne 3 ];
then
	echo "MakePSS.sh [option file] [TMP dir] [basename]"
	exit 1
fi

# READ OPTION FILE
PSIPRED_DIR=""
while read file
do
	FLAG=$(echo $file | cut -f 1 -d " ")
	if test "${FLAG}" == "PSIPRED_DIR";
	then
		PSIPRED_DIR=$(echo $file | cut -f 3 -d " ")
	fi
done < ${1}

test -d ${2}/PSIPRED/ || mkdir ${2}/PSIPRED

if test -e ${PSIPRED_DIR}/data/weights.dat4 ; 
then
	${PSIPRED_DIR}/bin/psipred ${2}/PSSM/${3}.mtx ${PSIPRED_DIR}/data/weights.dat ${PSIPRED_DIR}/data/weights.dat2 ${PSIPRED_DIR}/data/weights.dat3 ${PSIPRED_DIR}/data/weights.dat4 > ${2}/PSIPRED/${3}.ss

	${PSIPRED_DIR}/bin/psipass2 ${PSIPRED_DIR}/data/weights_p2.dat 1 1.0 1.0 ${2}/PSIPRED/${3}.ss2 ${2}/PSIPRED/${3}.ss > ${2}/PSIPRED/${3}.horiz
else
	${PSIPRED_DIR}/bin/psipred ${2}/PSSM/${3}.mtx ${PSIPRED_DIR}/data/weights.dat ${PSIPRED_DIR}/data/weights.dat2 ${PSIPRED_DIR}/data/weights.dat3 > ${2}/PSIPRED/${3}.ss
	${PSIPRED_DIR}/bin/psipass2 ${PSIPRED_DIR}/data/weights_p2.dat 1 1.0 1.0 ${2}/PSIPRED/${3}.ss2 ${2}/PSIPRED/${3}.ss > ${2}/PSIPRED/${3}.horiz
fi

