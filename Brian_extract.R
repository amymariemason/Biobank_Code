library(rbgen)

# extract the correct data using range sufficient for all chromosomes
# UPDATE THIS TO RUN OFF RSIDs instead

ranges = data.frame(chromosome = "01", start = 627478, end = 234849400)
data = bgen.load("/scratch/am2609/Gwas/projects/Brian_playing/bgen/Brian_playing.bgen", ranges)
data.summ = apply(data$data, 1, function(data) { return(data[,1]*0 + data[,2]*1 + data[,3]*2) })
all<-data.summ

for (count in c(2:9)) {
ranges = data.frame(chromosome = paste0("0",count), start = 627478, end = 234679400)
data = bgen.load("/scratch/am2609/Gwas/projects/Brian_playing/bgen/Brian_playing.bgen", ranges)
data.summ = apply(data$data, 1, function(data) { return(data[,1]*0 + data[,2]*1 + data[,3]*2) })
all<-cbind(data.summ, all)
}

for (count in c(10:22)) {
ranges = data.frame(chromosome = paste0(count), start = 627478, end = 234679400)
data = bgen.load("/scratch/am2609/Gwas/projects/Brian_playing/bgen/Brian_playing.bgen", ranges)
data.summ = apply(data$data, 1, function(data) { return(data[,1]*0 + data[,2]*1 + data[,3]*2) })
all<-cbind(data.summ, all)
}

names(all[names(all)=='rs9528185'])<-c("rs9528185_A_G", "rs9528185_A_T")

samplelink  = read.table("/scratch/am2609/Gwas/input_all/sampleID_map.txt", stringsAsFactors=FALSE, header=TRUE)  
sampleHRC = read.table("/scratch/am2609/Gwas/input_all/ukb_imp_genID.sample", stringsAsFactors=FALSE, header=TRUE) 

all<-as.data.frame(all)

all$ID_1<- sampleHRC$ID_1[2:487410]
whichlink = which(samplelink[,1]%in%sampleHRC[,1]) 
samplepheno <- samplelink[whichlink,1:2]

all_to_print<-merge(all,samplepheno , by.x="ID_1", by.y="UKB_sample_ID", all.x = TRUE, all.y=FALSE) 

write.csv(all_to_print, file="/scratch/am2609/Gwas/projects/Brian_playing/bgen/with_ids.csv")

