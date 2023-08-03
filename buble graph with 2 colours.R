#Bubble graph with indoor name
library(ggplot2)
library(reshape2)
library(tidyr)
library(dplyr)

#read in your file
pc = read.csv("phylaT.csv", header = TRUE)
#Change to long format
pcm = melt(pc, id = c("Samples", "Condition"))
#Keep same order
pcm$Sample <- factor(pcm$Sample,levels=unique(pcm$Sample))
#Plot
xx = ggplot(pcm, aes(x = Sample, y = variable)) + 
  geom_point(aes(size = value, fill = Condition), alpha = 0.75, shape = 21) + 
  scale_size_continuous(limits = c(0.000001, 100), range = c(1,10), breaks = c(1,10,50,75)) + 
  labs( x= "", y = "", size = "Relative Abundance (%)", fill = "Condition")  + 
  theme(legend.key=element_blank(), 
        axis.text.x = element_text(colour = "black", size = 12, face = "bold", angle = 90, vjust = 0.3, hjust = 1), 
        axis.text.y = element_text(colour = "black", face = "bold", size = 9), 
        legend.text = element_text(size = 10, face ="bold", colour ="black"), 
        legend.title = element_text(size = 11, face = "bold"), panel.background = element_blank(), 
        panel.border = element_rect(colour = "black", fill = NA, size = 1.2), 
        legend.position = "right", panel.grid.major.y = element_line(colour = "grey95")) +  
  scale_fill_manual(values = c("pink", "green"), guide = guide_legend(override.aes = list(size=5))) + 
  scale_y_discrete(limits = rev(levels(pcm$variable))) 

xx

#Save
ggsave("Bubble_plot_more.png", width = 8, height = 6, dpi = 300)