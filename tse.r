clean_corpus<-function(mycorpus){
  mycorpus<-tm_map(mycorpus,tolower)
  mycorpus<-tm_map(mycorpus,removePunctuation)
  mycorpus<-tm_map(mycorpus,removeWords,stopwords('english'))
  mycorpus<-tm_map(mycorpus,removeNumbers)
  mycorpus<-tm_map(mycorpus,stemDocument)
}


library(XML)
library(tm)

#clean corpus


doc<-xmlParse("pages.dat")
doc<-xmlToDataFrame(doc)


text<-as.vector(doc$text)
n.text<-length(text)

names(text)<-paste0(doc$title)

tse<-function(query){
query<-query

docs<-VectorSource(c(text,query))
names(docs[263])<-"query"

corpus<-Corpus(docs)

clean_corpus(corpus)

tdm<-TermDocumentMatrix(corpus)

tfidf<-weightTfIdf(tdm,normalize = TRUE)
tfidf2<-as.matrix(tfidf)
tfidf2<-scale(tfidf2,center = FALSE,scale = sqrt(colSums(tfidf2^2)))
query2<-tfidf2[,n.text+1]
tfidf2<-tfidf2[,1:n.text]
text.score<-t(query2)%*%tfidf2

result<-data.frame(doc=names(text),score=t(text.score),text=unlist(text))
result<-result[order(result$score,decreasing = TRUE),]

final<-result$doc[1:10]
return(final)
}

