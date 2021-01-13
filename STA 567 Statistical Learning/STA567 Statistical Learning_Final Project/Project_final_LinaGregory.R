# Title: Statistical Learning Project: predicting 2019 basketball scores for each player
# Teamname: Flyhigh
# Time: Dec.2
# Author: Lina Lee and Gregory Keslin
  
setwd("C:/Users/linal/Desktop/Miami2019/STA567/Project/final_2")
#### made by Gregory ####------------------------------------------------------------------------
library(caret)

 ## 1. Create two datasets data17 and data18 ##


load("wnba2017_2018.RData")
#Remove worthless row
wnba2017=wnba2017[,-1]
wnba2017=data.frame(wnba2017)
#Make an empty data frame row and name the rows
k=data.frame("",0,0,0,0,0,0,0,0)
name=c("Name","Games","Points","Rebounds","Steals","Assists","3pm","FT%","Blocks")
names(k)=name
#Calculate Averages for the 7 outcomes we predict per player
for(i in 1:nrow(wnba2018)){
  if(wnba2018$PLAYER[i] %in% k[,1]){
    ind=which(k[,1]==wnba2018$PLAYER[i])
    k[ind,2]=k[ind,2]+wnba2018$GP[i]
    k[ind,3]=k[ind,3]+wnba2018$PTS[i]
    k[ind,4]=k[ind,4]+wnba2018$REB[i]
    k[ind,5]=k[ind,5]+wnba2018$STL[i]
    k[ind,6]=k[ind,6]+wnba2018$AST[i]
    k[ind,7]=k[ind,7]+wnba2018$`3PM`[i]
    k[ind,8]=k[ind,8]+wnba2018$`FT%`[i]
    k[ind,9]=k[ind,9]+wnba2018$BLK[i]
  }else{
    tmp=data.frame(wnba2018$PLAYER[i],wnba2018$GP[i],wnba2018$PTS[i],wnba2018$REB[i],wnba2018$STL[i],wnba2018$AST[i],wnba2018$`3PM`[i],wnba2018$`FT%`[i],wnba2018$BLK[i])
    names(tmp)=name
    k=rbind(k,tmp)
  }
}
#Remove empty row and find average
k=k[-1,]
k=cbind(k[,1],cbind(k[,2],k[,-c(1,2)]*1/k[,2]))
names(k)=name

data18=k
#Same process but for all sections of 2017 data
for(i in 1:nrow(wnba2017)){
  if(i==1){
    k=data.frame(wnba2017[i,])
    names(k)=names(wnba2017)
    next
  }
  if(wnba2017$PLAYER[i] %in% k[,1]){
    ind=which(k[,1]==wnba2017$PLAYER[i])
    k[ind,-c(1,2,3)]=k[ind,-c(1,2,3)]+wnba2017[i,-c(1,2,3)]
  }else{
    tmp=data.frame(wnba2017[i,])
    names(tmp)=names(wnba2017)
    k=rbind(k,tmp)
  }
}
k=cbind(k[,1:6],k[,7:ncol(k)]/k[,4])
names(k)=names(wnba2017)

data17=k
data17=data17[order(data17$PLAYER),]
data18$Name=as.character(data18$Name)
#Find which players are in both 2017 and 2018 data and the indices of the player in each data set
sim=intersect(data17$PLAYER,data18$Name)
for(i in 1:length(sim)){
  ind17=which(data17$PLAYER==sim[i])
  ind18=which(data18$Name==sim[i])
  if(i==1)
    compInd=c(ind17,ind18) else
      compInd=rbind(compInd,c(ind17,ind18))
}


res=c(0,0)
#Column numbers corresponding to predictors for each response of interest
ind=list(c(3,7,8,9,10,11,12,13,14,15,16,17),c(7,12,13,15,16,18,19,20),seq(3,27),seq(3,27),c(7,12,13,14,18,19,20),c(7,seq(12,20)),seq(3,27))
#10 Fold CV
train_control=trainControl(method="cv",number=10)
#Scale all data
data17=data.frame(data17[,c(1,2)],scale(data17[,-c(1,2)]))
data18=data.frame(data18[,1],scale(data18[,-1]))

# save(data17,file="data17.RData")
# save(data17,file="data18.RData")

##### made by Lina ####-------------------------------------


  ## 2. modeling ##


# Note:To create comparison tables, we tried all the types of models listed below individually in the "comparison models"  R file.

#Loop through every response and find the best model for each response
for(i in 1:7) {
  tree=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rpart",trControl=train_control,tuneGrid=data.frame("cp"=seq(.01,.5,.03)))
  bag=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="treebag",trControl=train_control)
  rf=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="rf",trControl=train_control,tuneGrid=data.frame("mtry"=seq(1,length(unlist(ind[i])))))
  tuneGrid=expand.grid(data.frame("shrinkage"=c(.01,.1,1,5),"n.trees"=c(30,50,100,150),"interaction.depth"=c(1,2,3,4),"n.minobsinnode"=c(3,7,10,12)))
  boosted=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gbm",trControl=train_control,tuneGrid=tuneGrid)
  knn=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="knn",preProcess=c("center","scale"),trControl=train_control,tuneGrid=expand.grid(k=seq(1,50,1)))
  lasso=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl=train_control,preProcess = c("center","scale"),tuneGrid=expand.grid(alpha=0,lambda=seq(0,5,0.5)))
  ridge=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl=train_control,preProcess = c("center","scale"),
              tuneGrid=expand.grid(alpha=1,lambda=seq(0,5,0.1)))
  enet=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl= train_control,preProcess = c("center", "scale"),
             tuneLength=20)
  pcr=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="pcr",preProcess=c("center","scale"),trControl = train_control,
            tuneGrid = data.frame(ncomp=1:length(ind[i])))
  plsr=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="pls",preProcess=c("center","scale"),trControl = train_control,
             tuneGrid = data.frame(ncomp=1:length(ind[i])))
  loess=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gamLoess",trControl = train_control,preProcess = c("center", "scale"),
              tuneGrid =expand.grid(span = seq(0.3, 0.9, by=0.2), degree = 1))
  #Find which model corresponds to lowest RMSE
  vec=c(min(tree$results$RMSE),min(bag$results$RMSE),min(rf$results$RMSE),min(boosted$results$RMSE),min(knn$results$RMSE),min(lasso$results$RMSE),min(ridge$results$RMSE),min(enet$results$RMSE),min(pcr$results$RMSE),min(plsr$results$RMSE),min(loess$results$RMSE))
  min=min(vec)
  res=cbind(res,c(which(vec==min),min))
}

#Looking at the results, fit the correct model for each response
i=1
tuneGrid=expand.grid(data.frame("shrinkage"=.1,"n.trees"=50,"interaction.depth"=1,"n.minobsinnode"=3))
PointsMod=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gbm",trControl=train_control,tuneGrid=tuneGrid)

i=2
tuneGrid=expand.grid(data.frame("shrinkage"=.1,"n.trees"=50,"interaction.depth"=1,"n.minobsinnode"=7))
RebMod=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gbm",trControl=train_control,tuneGrid=tuneGrid)

i=3
StealsMod=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl=train_control,preProcess = c("center","scale"),
                tuneGrid=expand.grid(alpha=0.8105,lambda=0.0992))
i=4
AssistsMod=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl=train_control,preProcess = c("center","scale"),
                 tuneGrid=expand.grid(alpha=1,lambda=0.1))
i=5
threeMod=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl= train_control,preProcess = c("center", "scale"),
               tuneGrid=expand.grid(alpha=1,lambda=0.0337))
i=6
FtMod=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl=train_control,preProcess = c("center","scale"),
            tuneGrid=expand.grid(alpha=1,lambda=0.0638))
tuneGrid=expand.grid(data.frame("shrinkage"=.1,"n.trees"=30,"interaction.depth"=4,"n.minobsinnode"=10))
FtMod2=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="gbm",trControl=train_control,tuneGrid=tuneGrid)
i=7
BlockMod=train(data17[compInd[,1],unlist(ind[i])],data18[compInd[,2],2+i],method="glmnet",trControl= train_control,preProcess = c("center", "scale"),
               tuneGrid=expand.grid(alpha=1,lambda=0.1))

#### made by Gregory ####------------------------------------------------------------------------
 

## 3. Calcuating predictions ##


#Tabulate averages for each player for 2018 data
for(i in 1:nrow(wnba2018)){
  if(i==1){
    k=data.frame(wnba2018[i,])
    names(k)=names(wnba2018)
    next
  }
  if(wnba2018$PLAYER[i] %in% k[,1]){
    ind=which(k[,1]==wnba2018$PLAYER[i])
    k[ind,-c(1,2,3)]=k[ind,-c(1,2,3)]+wnba2018[i,-c(1,2,3)]
  }else{
    tmp=data.frame(wnba2018[i,])
    names(tmp)=names(wnba2018)
    k=rbind(k,tmp)
  }
}
k=cbind(k[,1:6],k[,7:ncol(k)]/k[,4])
names(k)=names(wnba2018)

data18Pred=k
data18Unscaled=k
#Scale the data again
data18Pred=data.frame("PLAYER"=data18Pred[,1],"TEAM"=data18Pred[,2],scale(data18Pred[,-c(1,2)]))
#Read in the names of players that we can draft in 2019
names=read.csv("players2019.csv")
names=as.character(names[,1])
#Find which players are in both 2018 and 2019 data and the indices of the player in the 2018 data
sim=intersect(names,data18Pred$PLAYER)
for(i in 1:length(sim)){
  if(i==1)
    compInd=which(data18Pred$PLAYER==sim[i]) else
      compInd=c(compInd,which(data18Pred$PLAYER==sim[i]))
}


#Refresh old predictor list
ind=list(c(3,7,8,9,10,11,12,13,14,15,16,17),c(7,12,13,15,16,18,19,20),seq(3,27),seq(3,27),c(7,12,13,14,18,19,20),c(7,seq(12,20)),seq(3,27))
#Predict for all the players in both 2018 and 2019 their data for all the responses
Points=predict(PointsMod,data18Pred[compInd,unlist(ind[1])])
Rebounds=predict(RebMod,data18Pred[compInd,unlist(ind[2])])
Steals=predict(StealsMod,data18Pred[compInd,unlist(ind[3])])
Assists=predict(AssistsMod,data18Pred[compInd,unlist(ind[4])])
threes=predict(threeMod,data18Pred[compInd,unlist(ind[5])])
Fts=(predict(FtMod,data18Pred[compInd,unlist(ind[6])])+predict(FtMod2,data18Pred[compInd,unlist(ind[6])]))/2
Blocks=predict(BlockMod,data18Pred[compInd,unlist(ind[7])])
#Push all the above data into a dataframe
Data19=data.frame(data18Pred$PLAYER[compInd],Points,Rebounds,Steals,Assists,threes,Fts,Blocks)
# save(Data19,file="predictions2019.RData")


#Push all the above data into a dataframe
Data19=data.frame(data18Pred$PLAYER[compInd],Points,Rebounds,Steals,Assists,threes,Fts,Blocks)
#Sort the players by their "fitness", which is just the squared standard deviations, adding back the negative, summed up. This helps overreward being above the pack in skills
indices=order(rowSums(Data19[,-1]^2*ifelse(Data19[,-1]<0,-1,1)),decreasing = TRUE)
Data19=Data19[indices,]
save(Data19,file="predictions2019.RData")


   ## 4. The application of the strategy ##


#Since the predictions are the normalized predictions, convert the normalized predictions back to the original form
dic=c("PTS","REB","STL","AST","3PM","FT%","BLK")
for(i in 1:(ncol(Data19)-1)){
  col=which(names(data18Unscaled)==dic[i])
  st=sd(data18Unscaled[,col])
  me=mean(data18Unscaled[,col])
  Data19[,i+1]=Data19[,i+1]*st+me
}
# Our draft strategy, in short uses recursion
DraftSelection=function(teamSel,Players,Num,teamNum,Data19){
  #Determine if we have simulated up to the round specified and evaluate to stop the recursion
  min=min(length(unlist(teamSel[length(teamSel)])),length(unlist(teamSel[1])))
  if(min==Num){
    #Determine, based on the predicted values, which categories our picked player permutation wins at versus all other teams permutations
    prob=0
    for(i in 1:length(teamSel)){
      if(i==teamNum)
        next
      oppTeam=colSums(Data19[unlist(teamSel[i]),-1])
      Team=colSums(Data19[unlist(teamSel[teamNum]),-1])
      winNum=length(which((oppTeam<Team)==TRUE))
      #If we win in more than three categories we beat the team
      if(winNum>3)
        prob=prob+1
    }
    #Return the percentage of teams we beat
    return(c(0,prob/(length(teamSel)-1)))
  }
  #Since this is a snake draft, determine which round we are in to determine which team goes next
  round=200
  for(i in 1:length(teamSel)){
    if(length(unlist(teamSel[i]))<round)
      round=length(unlist(teamSel[i]))
  }
  #Based on the round, we can figure out which player goes next
  if(round%%2==0){
    newPlayer=1
    for(i in 2:length(teamSel)){
      if(length(unlist(teamSel[i]))<length(unlist(teamSel[newPlayer])))
        newPlayer=i
    }
  }else{
    newPlayer=length(teamSel)
    for(i in (length(teamSel)-1):1){
      if(length(unlist(teamSel[i]))<length(unlist(teamSel[newPlayer])))
        newPlayer=i
    }
  }
  #Only consider the five remaining players with the highest fitness values (can be changed to reduce time complexity)
  total=min(5,length(Players))
  #Employ minimax, recursively, on all players to be considered
  for(i in 1:total){
    tmp=teamSel
    #Add ith player to this team
    tmp[newPlayer]=list(c(unlist(tmp[newPlayer]),Players[i]))
    #Max part of minimax if the next team to pick is us, min part of minimax if the next player to pick is not us
    if(newPlayer==teamNum){
      if(i==1)
        Probs=BestDraft(tmp,Players[-i],Num,teamNum,Data19)[2] else
          Probs=c(Probs,BestDraft(tmp,Players[-i],Num,teamNum,Data19)[2])
    } else{
      if(i==1)
        Probs=DraftSelection(tmp,Players[-i],Num,teamNum,Data19)[2] else
          Probs=c(Probs,DraftSelection(tmp,Players[-i],Num,teamNum,Data19)[2])
    }
  }
  #Since this team is not us, consider only the player they picked that results in the worst possible outcome for us
  mn=min(Probs)
  Play=min(which(Probs==mn))
  #Return player and probability of us winning against all teams
  return(c(Players[Play],mn))
}
#Very similiar code and idea, just at the end, since this is the max part of minimax, we recursively pick the player that mazimizes our probability
BestDraft=function(teamSel,Players,Num,teamNum,Data19){
  min=min(length(unlist(teamSel[length(teamSel)])),length(unlist(teamSel[1])))
  if(min==Num){
    prob=0
    for(i in 1:length(teamSel)){
      if(i==teamNum)
        next
      oppTeam=colSums(Data19[unlist(teamSel[i]),-1])
      Team=colSums(Data19[unlist(teamSel[teamNum]),-1])
      winNum=length(which((oppTeam<Team)==TRUE))
      if(winNum>3)
        prob=prob+1
    }
    return(c(0,prob/(length(teamSel)-1)))
  }
  round=200
  for(i in 1:length(teamSel)){
    if(length(unlist(teamSel[i]))<round)
      round=length(unlist(teamSel[i]))
  }
  if(round%%2==0){
    newPlayer=1
    for(i in 2:length(teamSel)){
      if(length(unlist(teamSel[i]))<length(unlist(teamSel[newPlayer])))
        newPlayer=i
    }
  }else{
    newPlayer=length(teamSel)
    for(i in (length(teamSel)-1):1){
      if(length(unlist(teamSel[i]))<length(unlist(teamSel[newPlayer])))
        newPlayer=i
    }
  }
  total=min(5,length(Players))
  for(i in 1:total){
    tmp=teamSel
    tmp[newPlayer]=list(c(unlist(tmp[newPlayer]),Players[i]))
    if(i==1)
      Probs=DraftSelection(tmp,Players[-i],Num,teamNum,Data19)[2] else
        Probs=c(Probs,DraftSelection(tmp,Players[-i],Num,teamNum,Data19)[2])
  }
  #Max part of minimax
  mx=max(Probs)
  Play=min(which(Probs==mx))
  return(c(Players[Play],mx))
}
#Quick function to streamline adding arbitrary player, based on name, to arbitrary team
AddPlayer=function(List,Name,Team,Data19){
  ind=which(Data19$data18Pred.PLAYER.compInd.==Name)
  List[Team]=list(c(unlist(List[Team]),ind))
  return(List)
}


#Create the drafted list
DraftedPlayers=list(rep(NULL,5))
#Stop Running Code Here
#Use first function below to add drafted players, only change the quotations to include the name of the drafted player and 1 to the team that drafted
#For a round, put player's name on "", and put team number on the position of 1.
#Fill DraftedPlayers for the other teams.
#Use second function below to figure out who to draft, don't touch anything in the second function besides changing the two to the correct next round and the three to whatever position we are drafting in
#Third Line is just the name of the player

DraftedPlayers=AddPlayer(DraftedPlayers,"",1,Data19)
PlayerPick=BestDraft(DraftedPlayers,seq(1,nrow(Data19))[-unlist(DraftedPlayers)],2,3,Data19)
Data19$data18Pred.PLAYER.compInd.[PlayerPick[1]]


#To test and play around:
#BestDraft(list(c(1),c(2,9),c(3,8),c(4,7),c(5,6)),seq(4,nrow(Data19)),3,1,Data19)




