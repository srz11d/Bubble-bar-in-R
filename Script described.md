# Bubble bar in R Studio 
_This graph is part of a research project from a spent fuel nuclear pond_ 

### Input file
The input file is a table where the _relative abundance of genera_ (calculated in Excel) in 10 samples is represented. An additional column represents the condition _indoor_ or _outdoor_

The input was created and manipulated in Excel (to calculate the average relative abundance) and then saved as a _CSV_ file. Here is a table of the input file:

<img width="783" alt="Screenshot 2023-08-03 at 14 21 09" src="https://github.com/srz11d/Bubble-bar-in-R/assets/135147161/61a0afc3-2bb6-46d9-8dbe-c1e79d543ca0">

### Library required
```
library(ggplot2)
library(reshape2)
library(tidyr)
library(dplyr)
```

### Read file
```
pc = read.csv("phylaT.csv", header = TRUE)
```

### Change to long format
```
pcm = melt(pc, id = c("Samples", "Condition"))
```

### Keep the same order (Optional)
In this particular case, I added this step to keep the order set on the columns to show the abundance of _others_ at the bottom of the graph 

```
pcm$Sample <- factor(pcm$Sample,levels=unique(pcm$Sample))
```

### Create the graph
```
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
```

### See the graph

```
xx
```

### Save the file as _png_
In some versions of R Studio it is possible to export the graph as _PDF_ or _JPG_, however, in my particular case the quality is not the best, hence I saved the file with the following script:

```
ggsave("Bubble_plot_more.png", width = 8, height = 6, dpi = 300)
```

## Result graph
This is the resulting graph. Feel free too change the settings

<img width="935" alt="Screenshot 2023-08-03 at 14 20 12" src="https://github.com/srz11d/Bubble-bar-in-R/assets/135147161/7818c779-78c6-413d-b52c-2b511129a7d7">
