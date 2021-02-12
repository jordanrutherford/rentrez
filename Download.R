
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1") #set vector of NCBI IDs
library(rentrez)  # load package; you may need install.packages first
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta") #download FASTA data files from NCBI

#look at Bburg object
str(Bburg)

#use strsplit() to create a new object that contains an element for each sequence
Sequences <- strsplit(Bburg, split = "\n\n")

#view new sequence object
print(Sequences)

#[1] shows us that this is a list -- covert to a data frame
Sequences <- unlist(Sequences)

#--------use regex to separate headers from sequences

#create header object
header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
#create sequences object
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
#create new data frame combining the two
Sequences<-data.frame(Name=header,Sequence=seq)

#remove newline characters from the Sequences data using regex
Sequences$Sequence <- gsub("\n", "", Sequences$Sequence)
print(Sequences$Sequence)

#output to new .csv file
write.csv(Sequences, "Sequences.csv")












