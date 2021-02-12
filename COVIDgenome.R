
library(sangerseqR) #load packages
library(rentrez)
library(BiocManager)
install(c("sangerseqR","annotate", "Biostrings")) #load additional packages within BiocManager

#create object containing sequence data from NCBI database in FASTA format
sars_seq <- entrez_fetch(db="nuccore", id="NC_045512.2", rettype="fasta")
sars_seq #view object in console

#convert into dataframe
sars_seq <- unlist(sars_seq)

sheader <- gsub("(^>.*genome)\\n[ATCG].*","\\1", sars_seq) #isolate header
sseq <- gsub("^>.*genome\\n([ATCG].*)","\\1", sars_seq) #isolate sequence
sars_seq <- data.frame(Name=sheader, Sequence=sseq) #combine the two into a data frame

#remove newline characters
sars_seq$Sequence <- gsub("\n", "", sars_seq$Sequence)

#convert string to class so I can subset by position numbers
seq_string <- DNAString(sars_seq$Sequence)

s_protein <- seq_string[21563:25384] #isolate s-protein by position number and save as object

s_protein <- as.character(s_protein) #convert to character so I can view it
s_protein #view s protein sequence

# Based on the BLAST score I ran on this s-protein sequence, I would say that it is highly conserved.
# The E values are all zero, meaning that these results were not by random chance, and the percent identity scores were all 100%. Additionally, nearly every sequence had the indicated max score, meaning that the sequences are perfectly aligned.
# Because this protein is so similar between SARS-CoV-2 strains, it is likely highly conserved and under selective pressure.



