

echo "############# Comenzado el pipeline a las $(date +'%H:%M:%S')...##########"

echo "Descargando el genoma..."
mkdir -p res/genome
wget -O res/genome/ecoli.fasta.gz ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
echo

echo "Descomprimiendo el genoma..."
gunzip res/genome/ecoli.fasta.gz
echo

echo "Ejecutando STAR para crear indice..."
mkdir -p res/genome/star_index
STAR --runThreadN 4 --runMode genomeGenerate --genomeDir res/genome/star_index/ --genomeFastaFiles res/genome/ecoli.fasta --genomeSAindexNbases 9
echo

echo "Comenzando sample analysis..."
echo

for sampleid in $(ls data/*.fastq.gz |cut -d"_" -f1 | sed "s:data/::" | sort | uniq )
do
	 bash scripts/analyse_sample.sh $sampleid
done

echo "Ejecutando MultiQC"
mkdir -p out/multiqc
multiqc -o out/multiqc .
echo
echo "###### Pipeline terminado a las $(date +'%H:%M:%S') ##############"
