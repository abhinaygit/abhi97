
library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)
library(arules)
library(arulesViz)
library(cluster)
project.data <- kc_house_data
filter.data <- project.data %>%
filter(yr_built%in% c(price))
nrow(project.data)
#Summary of Data
head(project.data)
tail(project.data)
#Missing Data.
project.data[!complete.cases(project.data),]
nrow(project.data[!complete.cases(project.data),])

# Clustering Analysis
mydata <- project.data[c("price","yr_built","yr_renovated")]
set.seed(2015)
kmeans.result.4 <- kmeans(mydata,centers = 4)
kmeans.result.5 <- kmeans(mydata,centers = 5)
kmeans.result.4
kmeans.result.5
plot(mydata[c("yr_built","price")], col = kmeans.result.4$cluster,
main = "Price & Year Built USING 4 CLUSTERS")
library(cluster)
plot(mydata[c("yr_built","price")], col = kmeans.result.5$cluster,
main = "Price & Year Built USING 5 CLUSTERS")
library(cluster)
#silhouette method
silhouette.cluster <- function(k){
km <- kmeans(mydata, centers = k, nstart=25)
ss <- silhouette(km$cluster, dist(mydata))
mean(ss[, 3])
}
k <- 4:5
average.silhouette <- sapply(k, silhouette.cluster)
plot(k, type='b',average.silhouette, xlab='No.of clusters',
ylab=’Average Silhouette Scores’, frame=FALSE)
new.data <- project.data[c("condition","grade","floors")]
set.seed(2015)
kvalue.max <- 6
#elbow method
elbow <- sapply (3: kvalue.max,function(k){
kmeans(new.data, k, nstart=50,iter.max = 15 )$tot.withinss})
elbow

plot(3:kvalue.max, elbow,
type="b", pch = 16, frame = FALSE,
xlab="Clusters",
ylab="sum of squares of within clusters")
new.kmeans.results.3 <- kmeans(new.data, centers = 3)
new.kmeans.results.4 <- kmeans(new.data, centers = 4)
new.kmeans.results.5 <- kmeans(new.data,centers = 5)
new.kmeans.results.6 <- kmeans(new.data,centers = 6)
new.kmeans.results.3
new.kmeans.results.4
new.kmeans.results.5
new.kmeans.results.6

kmeans.result.4$betweenss/kmeans.result.4$tot.withinss
kmeans.result.5$betweenss/kmeans.result.5$tot.withinss
new.kmeans.results.4$betweenss/new.kmeans.results.4$tot.withinss
new.kmeans.results.5$betweenss/new.kmeans.results.5$tot.withinss
#hierarchical clustering
dist.function <- head(mydata,20)
x <- dist(as.matrix(dist.function))
hierarchical.clustering.1 <- hclust(x, method = "single")
plot(hierarchical.clustering.1)
hierarchical.clustering.2 <- hclust(x, method = "complete")
plot(hierarchical.clustering.2)

hierarchical.clustering.avg <- hclust(x, method = "average")
plot(hierarchical.clustering.avg)
#Assosiation rule mining
para <- project.data[c("price","yr_built","yr_renovated","grade","condition")]
a_matrix<-data.matrix(para)
a_matrix<-a_matrix[,-1]
housing <-apply(a_matrix,2,as.logical)
house <-as(housing,"transactions")
rules <- apriori(house, parameter=list(support=0.03, confidence=0.9))
rules <- sort(rules, by="lift")
inspect(rules)
plot(rules,measure = c("support","confidence"),shading = "lift",jitter=1)
plot(rules, method = "paracoord")
rule2 <- eclat(housing,
parameter = list(supp = 0.03))
inspect(ruleInduction(rule2))
#data split
logreg <- sample(2,nrow(para),replace = TRUE,prob = c(0.7,0.3)s
traindata <- para[logreg==1,]
testdata <- para[logreg==2,]
nrow(traindata)
nrow(testdata)
summary(traindata)
summary(testdata)
#Logestic Regression Model:
response.test <-testdata$yr_renovated
testdata$yr_renovated <- NA
input <- yr_renovated~yr_built+price+grade+condition
as.factor(input$yr_renovated)
model <- glm(as.factor(yr_renovated)~.,family = binomial,data = traindata)
model
predict.probability <- predict(model,new = data.frame(testdata))
output <-ifelse(predict.probability >= 0.5,1,0)
output <- as.factor(output)
#confusion matrix
confus.matrix <- table(Actual = output, Predicted = response.test)
confus.matrix
accuracy.glm <- (confus.matrix[1,1]+confus.matrix[2,2]/sum(confus.matrix))
accuracy.glm
precision.type <- confus.matrix[1,1]/sum(confus.matrix[1,])
precision.type
recall <- confus.matrix[1,1]/sum(confus.matrix[,1])
recall
#F Score
f.score <- 2*precision.type*recall/(precision.type+recall)
f.score
#prediction using testdata
library(pROC)
library(caret)
library(lattice)
roc(response.test,predict.probability)
plot(roc(response.test,predict.probability),print.auc= TRUE)
# 10-flod cross validation
library(tidyverse)
library(caret)
library(kernlab)
set.seed(100)
trctrl <- trainControl(method = "cv", number = 10, savePredictions=TRUE)
nb_fit <- train(input, data = para, method = "glm", trControl=trctrl)
nb_fit


#Decision Tree
library(party)
library(partykit)
library(libcoin)
decisionTree <- ctree(data = traindata,input)
print(decisionTree)
plot(decisionTree)
train.predict <-predict(decisionTree,traindata)
test.predict <-predict(decisionTree,testdata)
confus.matrix.decision.tree <-table(Actual=response.test,Predicted= test.predict)
confus.matrix.decision.tree
accuracy.decision.tree <- (confus.matrix.decision.tree[1,1]+confus.matrix.decision.tree[2,2])/sum(confus.matrix.decision.tree)
accuracy.decision.tree
precition.decision.tree <- confus.matrix.decision.tree[1,1]/sum(confus.matrix.decision.tree[1,])
precition.decision.tree
recall.decision.tree <- confus.matrix.decision.tree[1,1]/sum(confus.matrix.decision.tree[,2])
recall.decision.tree
f.score.decision.tree <- 2*precition.decision.tree*recall.decision.tree/(precition.decision.tree+recall.decision.tree)
f.score.decision.tree
roc(response.test,as.numeric(test.predict))
plot(roc(response.test,as.numeric(test.predict)),print.auc = TRUE)
#SVM model
train.svm <- train(input,data = traindata,method ="svmLinear",trControl = trctrl)
svm.model <- predict(train.svm,testdata)
confus.matrix.svm <- table(Actual=response.test,Predicted=svm.model)
confus.matrix.svm


accuracy.svm <- (confus.matrix.svm[1,1]+confus.matrix.svm[2,2]/sum(confus.matrix.svm))
accuracy.svm
precision.svm <- confus.matrix.svm[1,1]/sum(confus.matrix.svm[1,])
precision.svm
recall.svm <- confus.matrix.svm[1,1]/sum(confus.matrix.svm)
recall.svm
f.score.svm <- 2*precision.svm*recall.svm/(precision.svm+recall.svm)
f.score.svm
roc(response.test,as.numeric(svm.model))
plot(roc(response.test,as.numeric(svm.model)),print.auc = TRUE)
#Naive Bayes
library(klaR)
library(caTools)
library(naivebayes)
library(e1071)
set.seed(120)
library(dplyr)
library(caret)
library(RWeka)
library(MASS)
library(rpart)
library(mlbench)
library(ggplot2)
train.nb <- train(input,data = traindata,method ="naivebayes",trControl = trctrl)
nb <- naiveBayes(price~.,data =traindata,laplace=5)
nb
model.nb <- predict(nb,testdata)
confus.matrix.nb <-table(Actual= response.test,Predicted = model.nb)
confus.matrix.nb
accuracy.nb <-(confus.matrix.nb[1,1]+confus.matrix.nb[2,2]/sum(confus.matrix.nb))
accuracy.nb
precision.nb <- confus.matrix.nb[1,1]/sum(confus.matrix.nb[1,])
precision.nb
recall.nb <- confus.matrix.nb[1,1]/sum(confus.matrix.nb[,1])
recall.nb
f.score.nb <- 2*precision.nb*recall.nb/(precision.nb+recall.nb)
f.score.nb
#RandomForest model
library(randomForest)
randomforest <- train(input,data = traindata,method = "rf",trControl=trctrl)
model.rf <- predict(randomforest,testdata)
confus.matrix.rf <- table(Actual= response.test,Predicted = model.rf)
confus.matrix.rf
accuracy.rf <- (confus.matrix.rf[1,1]+confus.matrix.rf[2,2]/sum(confus.matrix.rf))
accuracy.rf
precision.rf <- confus.matrix.rf[1,1]/sum(confus.matrix.rf[1,])
precision.rf
recall.rf <- confus.matrix.rf[1,1]/sum(confus.matrix.rf[,1])
recall.rf
f.score.rf <- 2*precision.rf*recall.rf/(precision.rf+recall.rf)
f.score.rf
roc(response.test,as.numeric(model.rf))
plot(roc(response.test,as.numeric(model.rf)),print.auc = TRUE























