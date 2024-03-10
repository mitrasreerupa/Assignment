setwd("C:/My_files/KUMC_ass2")
options(repos = c(CRAN = "https://cloud.r-project.org/"))

install.packages("ggplot2")
install.packages("dplyr")
library(dplyr)
unzip("Homo_sapiens.gene_info.gz")
gene_info <- data.frame(read.delim("Homo_sapiens.gene_info"))
head(gene_info)
other_chr <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,"X","Y","MT","Un")
chromosomes <- c(as.numeric(gene_info$chromosome))
other_chr_set <- subset(gene_info, gene_info$chromosome == c("X","Y","MT","Un"))
gene_c1 <- data.frame(table(other_chr_set$chromosome))
gene_c1
gene_counts <- data.frame(table(chromosomes))
gene_counts
names(gene_c1) <- c("chromosomes", "Freq")
all_counts <- rbind(gene_counts, gene_c1)
all_counts <- all_counts %>% arrange(match(chromosomes, other_chr))
all_counts
all_counts$chromosomes <- factor(all_counts$chromosomes, levels = all_counts$chromosomes)

library(ggplot2)
pdf("./my_plot.pdf",  width = 8, height = 7, 
    bg = "white",          
    colormodel = "cmyk",
    paper = "A4")
ggplot(all_counts, aes(x = chromosomes, y = Freq)) + 
  geom_bar(stat = "identity", fill = "grey35") +
  labs(title = "Number of genes in each chromosome",
       x = "Chromosomes",
       y = "Gene count") +
  theme_minimal() + theme(panel.grid = element_blank(), 
                          plot.title = element_text(hjust = 0.5),
                          axis.line = element_line(color = "black"),
                          axis.ticks = element_line(size = 0.5))
dev.off()
