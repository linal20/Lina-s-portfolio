# comparisons of the types of models #
library(tidyverse)
library(caret)
setwd("")
#### made by Lina ####
load("predictions2019.RData")
load("data17.RData")
load("data18.RData")


### The points model
i=1
knn1=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="knn",preProcess=c("center","scale"),
           trControl=train_control,tuneGrid=expand.grid(k=seq(1,50,1)))
set.seed(123)
lasso1=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl=train_control,
             preProcess = c("center","scale"),tuneGrid=expand.grid(alpha=0,lambda=seq(0,5,0.5)))
set.seed(123)
ridge1=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl=train_control,
             preProcess = c("center","scale"),tuneGrid=expand.grid(alpha=1,lambda=seq(0,5,0.1)))
set.seed(123)
enet1=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl= train_control,
            preProcess = c("center", "scale"),tuneLength=20)
set.seed(123)
pcr1=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="pcr",preProcess=c("center","scale"),
           trControl = train_control,tuneGrid = data.frame(ncomp=1:length(ind[i])))
set.seed(123)
plsr1=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="pls",preProcess=c("center","scale"),
            trControl = train_control,            tuneGrid = data.frame(ncomp=1:length(ind[i])))
set.seed(123)
spline1=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gamSpline",trControl = train_control,
              preProcess = c("center", "scale"),tuneGrid =data.frame(df=seq(1,15,by=.25)))
set.seed(123)
loess1=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gamLoess",trControl = train_control,
             preProcess = c("center", "scale"),tuneGrid =expand.grid(span = seq(0.3, 0.9, by=0.2), degree = 1))
set.seed(123)
tree1=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rpart",trControl=train_control,
            tuneGrid=data.frame("cp"=seq(.01,.5,.03)))
set.seed(123)
bag1=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="treebag",trControl=train_control)
set.seed(123)
rf1=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rf",trControl=train_control,
          tuneGrid=data.frame("mtry"=seq(1,length(unlist(ind[i])))))
tuneGrid=expand.grid(data.frame("shrinkage"=c(.01,.1,1,5),"n.trees"=c(30,50,100,150),"interaction.depth"=c(1,2,3,4),"n.minobsinnode"=c(3,7,10,12)))
boosted1=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gbm",trControl=train_control,
               tuneGrid=tuneGrid)

# tuning random forest
i=1
modellist <- list()
for (ntree in c(250,500,1000,2000,2500)) {
  set.seed(123)
  rfmod=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rf",trControl=train_control,
              tuneGrid=data.frame("mtry"=seq(1,length(unlist(ind[i]))))
              ,ntree=ntree)
  key <- toString(ntree)
  modellist[[key]] <- rfmod
  }
modellist

i=1
modellist1 <- list()
for (ntree in c(30,50,100,200,250,500,1000,2000,2500)) {
  set.seed(123)
  rfmod=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rf",trControl=train_control,
              tuneGrid=data.frame("mtry"=seq(1,length(unlist(ind[i]))))
              ,ntree=ntree)
  key <- toString(ntree)
  modellist2[[key]] <- rfmod$results[which.min(rfmod$results$RMSE),]
}
modellist1

# print the result with the lowest RMSE 
knn1$results[which.min(knn1$results$RMSE),]
lasso1$results[which.min(lasso1$results$RMSE),]
ridge1$results[which.min(ridge1$results$RMSE),]
enet1$results[which.min(enet1$results$RMSE),]

pcr1$results[which.min(pcr1$results$RMSE),]
plsr1$results[which.min(plsr1$results$RMSE),]
spline1$results[which.min(spline1$results$RMSE),]
loess1$results[which.min(loess1$results$RMSE),]

tree1$results[which.min(tree1$results$RMSE),]
bag1$results[which.min(bag1$results$RMSE),]
rf1$results[which.min(rf1$results$RMSE),]
boosted1$results[which.min(boosted1$results$RMSE),]




### The Rebound model
i=2
set.seed(123)
tree2=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rpart",trControl=train_control,
            tuneGrid=data.frame("cp"=seq(.01,.5,.03)))
set.seed(123)
bag2=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="treebag",trControl=train_control)
set.seed(123)
rf2=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rf",trControl=train_control,
          tuneGrid=data.frame("mtry"=seq(1,length(unlist(ind[i])))))
set.seed(123)
tuneGrid=expand.grid(data.frame("shrinkage"=c(.01,.1,1,5),"n.trees"=c(10,30,50,100,150),"interaction.depth"=c(1,2,3,4),"n.minobsinnode"=c(3,7,10,12)))
set.seed(123)
boosted2=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gbm",trControl=train_control,
               tuneGrid=tuneGrid)
set.seed(123)
knn2=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="knn",preProcess=c("center","scale"),
           trControl=train_control,tuneGrid=expand.grid(k=seq(1,50,1)))
set.seed(123)
lasso2=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl=train_control,
             preProcess = c("center","scale"),tuneGrid=expand.grid(alpha=0,lambda=seq(0,5,0.5)))
set.seed(123)
ridge2=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl=train_control,
             preProcess = c("center","scale"),
             tuneGrid=expand.grid(alpha=1,lambda=seq(0,5,0.1)))
set.seed(123)
enet2=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl= train_control,
            preProcess = c("center", "scale"),
            tuneLength=20)
set.seed(123)
pcr2=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="pcr",preProcess=c("center","scale"),
           trControl = train_control,tuneGrid = data.frame(ncomp=1:length(ind[i])))
set.seed(123)
plsr2=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="pls",preProcess=c("center","scale"),
            trControl = train_control,tuneGrid = data.frame(ncomp=1:length(ind[i])))
set.seed(123)
loess2=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gamLoess",trControl = train_control,
             preProcess = c("center", "scale"),tuneGrid =expand.grid(span = seq(0.3, 0.9, by=0.2), degree = 1))
set.seed(123)
spline2=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gamSpline",trControl = train_control,
              preProcess = c("center", "scale"),tuneGrid =data.frame(df=seq(1,15,by=.25)))

# tuning random forest
modellist2 <- list()
for (ntree in c(30,50,100,200,250,500,1000,2000,2500)) {
  set.seed(123)
  rfmod=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rf",trControl=train_control,tuneGrid=data.frame("mtry"=seq(1,length(unlist(ind[i]))))
              ,ntree=ntree)
  key <- toString(ntree)
  modellist2[[key]] <- rfmod$results[which.min(rfmod$results$RMSE),]
}
modellist2

# print the result with the lowest RMSE 
knn2$results[which.min(knn2$results$RMSE),]
lasso2$results[which.min(lasso2$results$RMSE),]
ridge2$results[which.min(ridge2$results$RMSE),]
enet2$results[which.min(enet2$results$RMSE),]

pcr2$results[which.min(pcr2$results$RMSE),]
plsr2$results[which.min(plsr2$results$RMSE),]
spline2$results[which.min(spline2$results$RMSE),]
loess2$results[which.min(loess2$results$RMSE),]

tree2$results[which.min(tree2$results$RMSE),]
bag2$results[which.min(bag2$results$RMSE),]
rf2$results[which.min(rf2$results$RMSE),]
boosted2$results[which.min(boosted2$results$RMSE),]

### the Steals model
i=3
set.seed(123)
knn3=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="knn",preProcess=c("center","scale"),
           trControl=train_control,tuneGrid=expand.grid(k=seq(1,50,1)))
set.seed(123)
lasso3=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl=train_control,
             preProcess = c("center","scale"),tuneGrid=expand.grid(alpha=0,lambda=seq(0,5,0.5)))
set.seed(123)
ridge3=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl=train_control,
             preProcess = c("center","scale"),tuneGrid=expand.grid(alpha=1,lambda=seq(0,5,0.1)))
set.seed(123)
enet3=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl= train_control,
            preProcess = c("center", "scale"),tuneLength=20)
set.seed(123)
pcr3=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="pcr",preProcess=c("center","scale"),
           trControl = train_control,tuneGrid = data.frame(ncomp=1:length(ind[i])))
set.seed(123)
plsr3=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="pls",preProcess=c("center","scale"),
            trControl = train_control,tuneGrid = data.frame(ncomp=1:length(ind[i])))
set.seed(123)
loess3=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gamLoess",trControl = train_control,
             preProcess = c("center", "scale"),tuneGrid =expand.grid(span = seq(0.3, 0.9, by=0.2), degree = 1))
set.seed(123)
spline3=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gamSpline",trControl = train_control,
              preProcess = c("center", "scale"),tuneGrid =data.frame(df=seq(1,15,by=.25)))
set.seed(123)
loess3=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gamLoess",trControl = train_control,
             preProcess = c("center", "scale"),tuneGrid =expand.grid(span = seq(0.3, 0.9, by=0.2), degree = 1))

set.seed(123)
tree3=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rpart",trControl=train_control,
            tuneGrid=data.frame("cp"=seq(.01,.5,.03)))
set.seed(123)
bag3=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="treebag",trControl=train_control)
set.seed(123)
rf3=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rf",trControl=train_control,
          tuneGrid=data.frame("mtry"=seq(1,length(unlist(ind[i])))))


set.seed(123)
tuneGrid=expand.grid(data.frame("shrinkage"=c(.01,.1,1,5),"n.trees"=c(30,50,100,150),"interaction.depth"=c(1,2,3,4),"n.minobsinnode"=c(3,7,10,12)))
set.seed(123)
boosted3=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gbm",trControl=train_control,
               tuneGrid=tuneGrid)

# print the result with the lowest RMSE 
knn3$results[which.min(knn3$results$RMSE),]
lasso3$results[which.min(lasso3$results$RMSE),]
ridge3$results[which.min(ridge3$results$RMSE),]
enet3$results[which.min(enet3$results$RMSE),]

pcr3$results[which.min(pcr3$results$RMSE),]
plsr3$results[which.min(plsr3$results$RMSE),]
loess3$results[which.min(loess3$results$RMSE),]
spline3$results[which.min(spline3$results$RMSE),]

tree3$results[which.min(tree3$results$RMSE),]
bag3$results[which.min(bag3$results$RMSE),]
rf3$results[which.min(rf3$results$RMSE),]
boosted3$results[which.min(boosted3$results$RMSE),]

# tuning random forest
modellist3 <- list()
for (ntree in c(30,50,100,200,250,500,1000,2000,2500)) {
  set.seed(123)
  rfmod=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rf",trControl=train_control,
              tuneGrid=data.frame("mtry"=seq(1,length(unlist(ind[i]))))
              ,ntree=ntree)
  key <- toString(ntree)
  modellist3[[key]] <- rfmod$results[which.min(rfmod$results$RMSE),]
}
modellist3

### the Assists model
i=4
set.seed(123)
knn4=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="knn",preProcess=c("center","scale"),
           trControl=train_control,tuneGrid=expand.grid(k=seq(1,50,1)))
set.seed(123)
lasso4=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl=train_control,
             preProcess = c("center","scale"),tuneGrid=expand.grid(alpha=0,lambda=seq(0,5,0.5)))
set.seed(123)
ridge4=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl=train_control,
             preProcess = c("center","scale"),
             tuneGrid=expand.grid(alpha=1,lambda=seq(0,5,0.1)))
set.seed(123)
enet4=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl= train_control,
            preProcess = c("center", "scale"),
            tuneLength=20)
set.seed(123)
pcr4=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="pcr",preProcess=c("center","scale"),
           trControl = train_control,
           tuneGrid = data.frame(ncomp=1:length(ind[i])))
set.seed(123)
plsr4=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="pls",preProcess=c("center","scale"),
            trControl = train_control,
            tuneGrid = data.frame(ncomp=1:length(ind[i])))
set.seed(123)
spline4=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gamSpline",trControl = train_control,
              preProcess = c("center", "scale"),
              tuneGrid =data.frame(df=seq(1,15,by=.25)))
set.seed(123)
loess4=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gamLoess",trControl = train_control,
             preProcess = c("center", "scale"),
             tuneGrid =expand.grid(span = seq(0.3, 0.9, by=0.2), degree = 1))
set.seed(123)
tree4=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rpart",trControl=train_control,
            tuneGrid=data.frame("cp"=seq(.01,.5,.03)))
set.seed(123)
bag4=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="treebag",trControl=train_control)
set.seed(123)
rf4=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rf",trControl=train_control,
          tuneGrid=data.frame("mtry"=seq(1,length(unlist(ind[i])))))
set.seed(123)
tuneGrid=expand.grid(data.frame("shrinkage"=c(.01,.1,1,5),"n.trees"=c(30,50,100,150),"interaction.depth"=c(1,2,3,4),"n.minobsinnode"=c(3,7,10,12)))
set.seed(123)
boosted4=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gbm",trControl=train_control,
               tuneGrid=tuneGrid)

# tuning random forest
i=4
modellist4 <- list()
for (ntree in c(30,50,100,200,250,500,1000,2000,2500)) {
  set.seed(123)
  rfmod=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rf",trControl=train_control,
              tuneGrid=data.frame("mtry"=seq(1,length(unlist(ind[i]))))
              ,ntree=ntree)
  key <- toString(ntree)
  modellist4[[key]] <- rfmod$results[which.min(rfmod$results$RMSE),]
}
modellist4

modellist4_2 <- list()
for (ntree in c(10,20,30)) {
  set.seed(123)
  rfmod=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rf",trControl=train_control,
              tuneGrid=data.frame("mtry"=seq(1,length(unlist(ind[i]))))
              ,ntree=ntree)
  key <- toString(ntree)
  modellist4_2[[key]] <- rfmod$results[which.min(rfmod$results$RMSE),]
}
modellist4_2

knn4$results[which.min(knn4$results$RMSE),]
lasso4$results[which.min(lasso4$results$RMSE),]
ridge4$results[which.min(ridge4$results$RMSE),]
enet4$results[which.min(enet4$results$RMSE),]

pcr4$results[which.min(pcr4$results$RMSE),]
plsr4$results[which.min(plsr4$results$RMSE),]
spline4$results[which.min(spline4$results$RMSE),]
loess4$results[which.min(loess4$results$RMSE),]

tree4$results[which.min(tree4$results$RMSE),]
bag4$results[which.min(bag4$results$RMSE),]
rf4$results[which.min(rf4$results$RMSE),]
boosted4$results[which.min(boosted4$results$RMSE),]

### the 3pts model
i=5
set.seed(123)
knn5=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="knn",preProcess=c("center","scale"),
           trControl=train_control,tuneGrid=expand.grid(k=seq(1,50,1)))
set.seed(123)
lasso5=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl=train_control,
             preProcess = c("center","scale"),tuneGrid=expand.grid(alpha=0,lambda=seq(0,5,0.5)))
set.seed(123)
ridge5=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl=train_control,
             preProcess = c("center","scale"),tuneGrid=expand.grid(alpha=1,lambda=seq(0,5,0.1)))
set.seed(123)
enet5=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl= train_control,
            preProcess = c("center", "scale"),tuneLength=20)
set.seed(123)
pcr5=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="pcr",preProcess=c("center","scale"),
           trControl = train_control,tuneGrid = data.frame(ncomp=1:length(ind[i])))
set.seed(123)
plsr5=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="pls",preProcess=c("center","scale"),
            trControl = train_control,tuneGrid = data.frame(ncomp=1:length(ind[i])))
set.seed(123)
spline5=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gamSpline",trControl = train_control,
              preProcess = c("center", "scale"),tuneGrid =data.frame(df=seq(1,15,by=.25)))
set.seed(123)
loess5=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gamLoess",trControl = train_control,
             preProcess = c("center", "scale"),tuneGrid =expand.grid(span = seq(0.3, 0.9, by=0.2), degree = 1))
set.seed(123)
tree5=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rpart",trControl=train_control,
            tuneGrid=data.frame("cp"=seq(.01,.5,.03)))
set.seed(123)
bag5=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="treebag",trControl=train_control)
set.seed(123)
rf5=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rf",trControl=train_control,
          tuneGrid=data.frame("mtry"=seq(1,length(unlist(ind[i])))))

set.seed(123)
tuneGrid=expand.grid(data.frame("shrinkage"=c(.01,.1,1,5),"n.trees"=c(30,50,100,150),"interaction.depth"=c(1,2,3,4),"n.minobsinnode"=c(3,7,10,12)))
boosted5=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gbm",trControl=train_control,
               tuneGrid=tuneGrid)

# tuning random forest
i=5
modellist5 <- list()
for (ntree in c(10,20,30,50,100,200,250,500,1000,2000)) {
  set.seed(123)
  rfmod=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rf",trControl=train_control,
              tuneGrid=data.frame("mtry"=seq(1,length(unlist(ind[i])))),ntree=ntree)
  key <- toString(ntree)
  modellist5[[key]] <- rfmod$results[which.min(rfmod$results$RMSE),]
}
modellist5

modellist5_2 <- list()
for (ntree in c(5,10)) {
  set.seed(123)
  rfmod=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rf",trControl=train_control,
              tuneGrid=data.frame("mtry"=seq(1,length(unlist(ind[i])))),ntree=ntree)
  key <- toString(ntree)
  modellist5_2[[key]] <- rfmod$results[which.min(rfmod$results$RMSE),]
}
modellist5_2


# print the result with the lowest RMSE 
knn5$results[which.min(knn5$results$RMSE),]
lasso5$results[which.min(lasso5$results$RMSE),]
ridge5$results[which.min(ridge5$results$RMSE),]
enet5$results[which.min(enet5$results$RMSE),]

pcr5$results[which.min(pcr5$results$RMSE),]
plsr5$results[which.min(plsr5$results$RMSE),]
spline5$results[which.min(spline5$results$RMSE),]
loess5$results[which.min(loess5$results$RMSE),]

tree5$results[which.min(tree5$results$RMSE),]
bag5$results[which.min(bag5$results$RMSE),]
rf5$results[which.min(rf5$results$RMSE),]
boosted5$results[which.min(boosted5$results$RMSE),]

### the FT% model
i=6
set.seed(123)
knn6=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="knn",preProcess=c("center","scale"),
           trControl=train_control,tuneGrid=expand.grid(k=seq(1,50,1)))
set.seed(123)
lasso6=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl=train_control,
             preProcess = c("center","scale"),tuneGrid=expand.grid(alpha=0,lambda=seq(0,5,0.5)))
set.seed(123)
ridge6=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl=train_control,
             preProcess = c("center","scale"),tuneGrid=expand.grid(alpha=1,lambda=seq(0,5,0.1)))
set.seed(123)
enet6=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl= train_control,
            preProcess = c("center", "scale"),tuneLength=20)
set.seed(123)
pcr6=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="pcr",preProcess=c("center","scale"),
           trControl = train_control,tuneGrid = data.frame(ncomp=1:length(ind[i])))
set.seed(123)
plsr6=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="pls",preProcess=c("center","scale"),
            trControl = train_control,tuneGrid = data.frame(ncomp=1:length(ind[i])))
set.seed(123)
loess6=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gamLoess",trControl = train_control,
             preProcess = c("center", "scale"),tuneGrid =expand.grid(span = seq(0.3, 0.9, by=0.2), degree = 1))
set.seed(123)
spline6=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gamSpline",trControl = train_control,
              preProcess = c("center", "scale"),tuneGrid =data.frame(df=seq(1,15,by=.25)))
set.seed(123)
tree6=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rpart",trControl=train_control,
            tuneGrid=data.frame("cp"=seq(.01,.5,.03)))
set.seed(123)
bag6=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="treebag",trControl=train_control)
set.seed(123)
rf6=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rf",trControl=train_control,
          tuneGrid=data.frame("mtry"=seq(1,length(unlist(ind[i])))))
set.seed(123)
tuneGrid=expand.grid(data.frame("shrinkage"=c(.01,.1,1,5),"n.trees"=c(30,50,100,150),"interaction.depth"=c(1,2,3,4),"n.minobsinnode"=c(3,7,10,12)))
set.seed(123)
boosted6=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gbm",trControl=train_control,
               tuneGrid=tuneGrid)

# tuning random forest
modellist6 <- list()
for (ntree in c(10,20,30,50,100,200,250,500,1000,2000)) {
  set.seed(123)
  rfmod=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rf",trControl=train_control,
              tuneGrid=data.frame("mtry"=seq(1,length(unlist(ind[i])))),ntree=ntree)
  key <- toString(ntree)
  modellist6[[key]] <- rfmod$results[which.min(rfmod$results$RMSE),]
}
modellist6

# print the result with the lowest RMSE 
knn6$results[which.min(knn6$results$RMSE),]
lasso6$results[which.min(lasso6$results$RMSE),]
ridge6$results[which.min(ridge6$results$RMSE),]
enet6$results[which.min(enet6$results$RMSE),]

pcr6$results[which.min(pcr6$results$RMSE),]
plsr6$results[which.min(plsr6$results$RMSE),]
spline6$results[which.min(spline6$results$RMSE),]
loess6$results[which.min(loess6$results$RMSE),]

tree6$results[which.min(tree6$results$RMSE),]
bag6$results[which.min(bag6$results$RMSE),]
rf6$results[which.min(rf6$results$RMSE),]
boosted6$results[which.min(boosted6$results$RMSE),]

# The Blocks model
i=7
set.seed(123)
knn7=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="knn",preProcess=c("center","scale"),
           trControl=train_control,tuneGrid=expand.grid(k=seq(1,50,1)))
set.seed(123)
lasso7=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl=train_control,
             preProcess = c("center","scale"),tuneGrid=expand.grid(alpha=0,lambda=seq(0,5,0.5)))
set.seed(123)
ridge7=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl=train_control,
             preProcess = c("center","scale"),tuneGrid=expand.grid(alpha=1,lambda=seq(0,5,0.1)))
set.seed(123)
enet7=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl= train_control,
            preProcess = c("center", "scale"),
            tuneLength=20)
set.seed(123)
pcr7=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="pcr",preProcess=c("center","scale"),
           trControl = train_control,tuneGrid = data.frame(ncomp=1:length(ind[i])))
set.seed(123)
plsr7=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="pls",preProcess=c("center","scale"),
            trControl = train_control,tuneGrid = data.frame(ncomp=1:length(ind[i])))
set.seed(123)
loess7=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gamLoess",trControl = train_control,
             preProcess = c("center", "scale"),tuneGrid =expand.grid(span = seq(0.3, 0.9, by=0.2), degree = 1))
set.seed(123)
spline7=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gamSpline",trControl = train_control,
              preProcess = c("center", "scale"),tuneGrid =data.frame(df=seq(1,15,by=.25)))
set.seed(123)
loess7=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gamLoess",trControl = train_control,
             preProcess = c("center", "scale"),tuneGrid =expand.grid(span = seq(0.3, 0.9, by=0.2), degree = 1))
set.seed(123)
tree7=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rpart",trControl=train_control,
            tuneGrid=data.frame("cp"=seq(.01,.5,.03)))
set.seed(123)
bag7=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="treebag",trControl=train_control)
set.seed(123)
rf7=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rf",trControl=train_control,
          tuneGrid=data.frame("mtry"=seq(1,length(unlist(ind[i])))))
set.seed(123)
tuneGrid=expand.grid(data.frame("shrinkage"=c(.01,.1,1,5),"n.trees"=c(30,50,100,150),"interaction.depth"=c(1,2,3,4),"n.minobsinnode"=c(3,7,10,12)))
set.seed(123)
boosted7=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gbm",trControl=train_control,
               tuneGrid=tuneGrid)

# tuning random forest
modellist7 <- list()
for (ntree in c(10,20,30,50,100,200,250,500,1000,2000)) {
  set.seed(123)
  rfmod=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rf",trControl=train_control,
              tuneGrid=data.frame("mtry"=seq(1,length(unlist(ind[i])))),ntree=ntree)
  key <- toString(ntree)
  modellist7[[key]] <- rfmod$results[which.min(rfmod$results$RMSE),]
}
modellist7

# print the result with the lowest RMSE 
knn7$results[which.min(knn7$results$RMSE),]
lasso7$results[which.min(lasso7$results$RMSE),]
ridge7$results[which.min(ridge7$results$RMSE),]
enet7$results[which.min(enet7$results$RMSE),]

pcr7$results[which.min(pcr7$results$RMSE),]
plsr7$results[which.min(plsr7$results$RMSE),]
loess7$results[which.min(loess7$results$RMSE),]
spline7$results[which.min(spline7$results$RMSE),]

tree7$results[which.min(tree7$results$RMSE),]
bag7$results[which.min(bag7$results$RMSE),]
rf7$results[which.min(rf7$results$RMSE),]
boosted7$results[which.min(boosted7$results$RMSE),]