#! /bin/bash
# $1 Query List

if [ $# -ne 3 ];
then
	echo "MakePSSM [option file] [FASTA file] [output dir]"
	exit 1
fi

base=`basename ${2} .fasta`

# READ OPTION FILE
BLAST=""
NR_DB=""
CPU_NUM=""

while read file
do
	FLAG=$(echo $file | cut -f 1 -d " ")
	if test "${FLAG}" == "CPUNum";
	then
		CPU_NUM=$(echo $file | cut -f 3 -d " ")
	elif test "${FLAG}" == "BLAST_DIR";
	then
		BLAST=$(echo $file | cut -f 3 -d " ")
	elif test "${FLAG}" == "NR_DB";
	then
		NR_DB=$(echo $file | cut -f 3 -d " ")
	fi
done < ${1}


${BLAST}/blastpgp -a ${CPU_NUM} -j 4 -h 0.0005 -e 0.001 -d ${NR_DB} -i ${2} -C ${3}${base}.chk  > ${3}${base}.blast

cp ${2} ${3}${base}.fasta
echo ${base}.chk > ${3}${base}.pn
echo ${base}.fasta > ${3}${base}.sn

${BLAST}/makemat -P ${3}${base} -d ${NR_DB}

