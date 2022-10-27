cd $WD
echo wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz



for sampleid in $(ls data/*.fastq.gz |cut -d"_" -f1 | sed "s:data/::" sort | uniq ); do echo $ sampleid; done;
do
	echo bash scripts/analyse_sample.sh $sampleid
done

mkdir out/multiqc
echo multiqc -o out/multicqc/ $WD
