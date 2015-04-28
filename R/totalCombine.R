# RJava bug �ѨM
install.packages('rJava', repos='http://www.rforge.net/')   
Sys.getenv("JAVA_HOME")
if (Sys.getenv("JAVA_HOME")!="")
  Sys.setenv(JAVA_HOME="")

#��Ʈw�s�ɮ�
library(lubridate)
library(RODBC);
channel = odbcConnect("agriculture", uid="sa", pwd="passw0rd");
market_ponkan = sqlQuery(channel, "select * from market_ponkan");
ponkan_production_price = sqlQuery(channel, "select * from ponkan_production_price");
weather = sqlQuery(channel, "select * from weather");
close(channel);
#�˹��ݩ�
str(ponkan_production_price)
head(ponkan_production_price)
#�إߪŪ���
bindtemp = data.frame()

#��2003>2013�j��]�Ѯ�
for(i in 2003:2013){
  #�ɦW���~��+�ɮצW��  
  weathername = paste("weather",i,sep="")
  #�~���϶�
  startday = paste(i,'-01-01',sep="")  
  enday = paste(i,'-12-31',sep="")  
  #�N�ɦW�ήɶ����X�A�@�_
  weathername = weather[weather$date>=startday & weather$date<=enday,]
  #��n�����
  w = c(1,2) 
  weathername = weathername[,w]  
  #��2004>2014�j��]�����P���a���
  for(j in 2004:2014){
    #�R�W���
    producname = paste("ponkan_production_price",j,sep="")
    marketname = paste("market_ponkan",j,sep="")  
    totalname = paste("total",j,sep="") 
    #�~���϶�
    startday = paste(j,'-01-01',sep="")  
    enday = paste(j,'-12-31',sep="")  
    #�N�ɦW�ήɶ����X�A�@�_
    marketname = market_ponkan[market_ponkan$date>=startday & market_ponkan$date<=enday,]
    #����ݭn�����
    m = c(1,7)
    marketname = marketname[,m]
    #�~��-1�Ϯɶ��@�P
    year(marketname$date) = year(marketname$date)-1 
    #�N�ɦW�ήɶ����X�A�@�_
    producname = na.omit(ponkan_production_price[ponkan_production_price$date>=startday & ponkan_production_price<=enday,])
    #�~��-1�Ϯɶ��@�P
    year(producname$date) = year(producname$date)-1 
    #�B�z-1��
    producname$priceNovosti[producname$priceNovosti==-1]= 0
    producname$priceIshioka[producname$priceIshioka==-1]= 0
    
    #�X�����
    merge1 = merge(weathername,producname,by.x='date',all.x=TRUE)
    merge2 = merge(merge1,marketname,by.x='date',all.x=TRUE)
    #�̫����b���R�W
    totalname = na.omit(merge2)
    
   #�]���]�ܦh�Ū���A�ҥH�ΧP�_�����������
    if (nrow(totalname)>0){
      str(totalname)
      bindtemp= rbind(bindtemp,totalname)  
    }    
  } 
  
}
#�˹��ݩ�
str(bindtemp)
#�g�X�ɮ׽T�{���e
#write.xlsx(bindtemp,file='bindtemp.xlsx')

#���W�Ƥ���
nor = function(e){
  x = (e-min(e))/(max(e)-min(e))
  x
}
#�o��Τ�ʥ�����ӵe�ϡA�]���@���u��e�@�i
bindtemp2=bindtemp[bindtemp$date>='2003-01-01' & bindtemp$date<='2003-12-31',]
str(bindtemp2)
dataRawNormalize = bindtemp2
dataRawNormalize = dataRawNormalize[,-1]
#���W��
for(i in 1:ncol(dataRawNormalize)){
  dataRawNormalize[,i] = nor(dataRawNormalize[,i])
}

#���s�N�����[�^�h���s��data.frame
dateT = bindtemp2[,1]
dataRawNormalizeponkan = data.frame(dateT,dataRawNormalize)

#�e�ϽT�{
#boxplot(ponkanjoin4$avg_price~ponkanjoin4$air_temp ,ylab='avg_price',xlab='air_temp')
#abline(v=105,lwd=3,col='red')

plot(dataRawNormalizeponkan$trade~dataRawNormalizeponkan$date,
     xlab = "date",
     ylab = "trade",    
     type ="l"
)
#�W�[��L�ѼƽT�{������
points(x=dataRawNormalizeponkan$date,y=dataRawNormalizeponkan$priceNovosti,col='blue',type='l')
points(x=dataRawNormalizeponkan$date,y=dataRawNormalizeponkan$priceIshioka,col='red',type='l')
#points(x=dataRawNormalizeponkan$date,y=dataRawNormalizeponkan$avg_price,col='red',type='l')
legend("topright",c('trade','priceNovosti','priceIshioka'),cex = 0.75,lwd=c(2.5,2.5,2.5),col=c("black","blue","red"))



