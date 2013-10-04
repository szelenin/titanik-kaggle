library(ggplot2)

rm( list=ls() )

train_all <- read.csv("data/train.csv", header=TRUE, as.is=TRUE )
test_all  <- read.csv("data/test.csv", header=TRUE,  as.is=TRUE )

fam_name <- function( x ) {
  fmn <- strsplit( x, ',' )
  fmn[[1]][1]
}
train_all$Family <- sapply( train_all$name, fam_name, USE.NAMES=FALSE )


train <- data.frame( survived=train_all$survived,
                     pclass=train_all$pclass,
                     sex=train_all$sex,
                     Family=train_all$Family,
                     test=FALSE )
test  <- data.frame( survived=NA,
                     pclass=test_all$pclass,
                     sex=test_all$sex,
                     Family=test_all$Family,
                     test=TRUE )

# Combine train and test so we can count the family sizes.
combined <- rbind( train, test )

# How many members in each family?
family_count <- table( factor( combined$Family ) )

get_count <- function( fam ) { family_count[[fam]] }
combined$fam_count <- sapply(combined$Family,FUN=get_count)
combined$alone     <- factor(ifelse(combined$fam_count>1,"with family","alone"))

# Only use the training set for the plot, because that has the survival data
temp <- combined[ !combined$test, ]

p3 <- ggplot( temp, aes(x=alone,y=survived) )  + 
  stat_summary( fun.y = mean, ymin=0, ymax=1, geom="bar", size=4 ) +  
  facet_grid( pclass~sex ) + xlab( 'traveling') + ylab( 'survival rate' ) + theme_bw()

print( p3 )

# Plot for the overall effect
p4 <- ggplot( temp, aes(x=alone,y=survived) )  + 
  stat_summary( fun.y = mean, ymin=0, ymax=1, geom="bar", size=4 ) + xlab( 'traveling') + ylab( 'survival rate' ) + theme_bw()

print( p4 )

ggsave( plot=p3, file="sur_rate_family.png" )
ggsave( plot=p4, file="sur_rate_family_all.png", width=3, height=3 )
