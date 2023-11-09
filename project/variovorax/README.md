# Variovorax genome downloading

To download the Variovorax genome and gff file for *V. paradoxus*, *V. boronicumulans*, and *V. gossypii*, run the following commands (you can copy and paste all of the commands and run them at the same time).


```
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/001/591/365/GCF_001591365.1_ASM159136v1/GCF_001591365.1_ASM159136v1_genomic.fna.gz -O v_paradoxus.fa.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/001/591/365/GCF_001591365.1_ASM159136v1/GCF_001591365.1_ASM159136v1_genomic.gff.gz -O v_paradoxus.gff.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/009/811/375/GCF_009811375.1_ASM981137v1/GCF_009811375.1_ASM981137v1_genomic.fna.gz -O v_boronicumulans.fa.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/009/811/375/GCF_009811375.1_ASM981137v1/GCF_009811375.1_ASM981137v1_genomic.gff.gz -O v_boronicumulans.gff.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/003/965/815/GCF_003965815.1_ASM396581v1/GCF_003965815.1_ASM396581v1_genomic.fna.gz -O v_gossypii.fa.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/003/965/815/GCF_003965815.1_ASM396581v1/GCF_003965815.1_ASM396581v1_genomic.gff.gz -O v_gossypii.gff.gz
gunzip *.gz
```

These files are from the following webpages:

* Variovorax paradoxus: https://www.ncbi.nlm.nih.gov/genome/1766
* Variovorax boronicumulans: https://www.ncbi.nlm.nih.gov/genome/17514
* Variovorax gossypii: https://www.ncbi.nlm.nih.gov/genome/74803
