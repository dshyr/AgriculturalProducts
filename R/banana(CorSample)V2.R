#��Ʈw�s�ɮ�
library(lubridate)
library(RODBC);
channel = odbcConnect("agriculture", uid="sa", pwd="passw0rd");

market_banana = sqlQuery(channel, "select * from market_banana");
banana_production_price = sqlQuery(channel, "select * from banana_production_price");
weather = sqlQuery(channel, "select * from weather");

close(channel);
#�ˬd�ݩ�
str(market_banana)
head(weather)
##############
#���N��������β��a����ɶ���ܩһݥͪ��϶�
year(market_banana$date) = year(market_banana$date)-1
year(banana_production_price$date) = year(banana_production_price$date)-1

#�X�֮�ԻP�����}����NULL��
MarketPriceCorbanana = na.omit(merge(weather,market_banana,by.x='date',all.x=TRUE))

#��ԻP������������Y��
TempPrice = cor(MarketPriceCorbanana$avg_price,MarketPriceCorbanana$air_temp)
dew_pointPrice = cor(MarketPriceCorbanana$avg_price,MarketPriceCorbanana$dew_point)
RHPrice = cor(MarketPriceCorbanana$avg_price,MarketPriceCorbanana$RH)
precp_daPrice = cor(MarketPriceCorbanana$avg_price,MarketPriceCorbanana$precp_da)
wind_speed_meanPrice = cor(MarketPriceCorbanana$avg_price,MarketPriceCorbanana$wind_speed_mean)
sunPrice = cor(MarketPriceCorbanana$avg_price,MarketPriceCorbanana$sun)
solar_radPrice = cor(MarketPriceCorbanana$avg_price,MarketPriceCorbanana$solar_rad)
evapPrice = cor(MarketPriceCorbanana$avg_price,MarketPriceCorbanana$evap)

#��ԻP����q�����Y��
air_temptrade= cor(MarketPriceCorbanana$trade,MarketPriceCorbanana$air_temp)
dew_pointtrade = cor(MarketPriceCorbanana$trade,MarketPriceCorbanana$dew_point)
RHPrice = cor(MarketPriceCorbanana$trade,MarketPriceCorbanana$RH)
precp_datrade = cor(MarketPriceCorbanana$trade,MarketPriceCorbanana$precp_da)
wind_speed_meantrade = cor(MarketPriceCorbanana$trade,MarketPriceCorbanana$wind_speed_mean)
suntrade = cor(MarketPriceCorbanana$trade,MarketPriceCorbanana$sun)
solar_radtrade = cor(MarketPriceCorbanana$trade,MarketPriceCorbanana$solar_rad)
evaptrade = cor(MarketPriceCorbanana$trade,MarketPriceCorbanana$evap)

#�X�֮�ԻP������ƨé���NULL��
ProductionPriceCorbanana = na.omit(merge(weather,banana_production_price,by.x='date',all.x=TRUE))
str(ProductionPriceCorbanana)

#��ԻP���������Y��1
air_tempPRprice1= cor(ProductionPriceCorbanana$priceWufeng,ProductionPriceCorbanana$air_temp)
dew_pointPRprice1 = cor(ProductionPriceCorbanana$priceWufeng,ProductionPriceCorbanana$dew_point)
RHPRprice1 = cor(ProductionPriceCorbanana$priceWufeng,ProductionPriceCorbanana$RH)
precp_daPRprice1 = cor(ProductionPriceCorbanana$priceWufeng,ProductionPriceCorbanana$precp_da)
wind_speed_meanPRprice1 = cor(ProductionPriceCorbanana$priceWufeng,ProductionPriceCorbanana$wind_speed_mean)
sunPRprice1 = cor(ProductionPriceCorbanana$priceWufeng,ProductionPriceCorbanana$sun)
solar_radPRprice1 = cor(ProductionPriceCorbanana$priceWufeng,ProductionPriceCorbanana$solar_rad)
evapPRprice1 = cor(ProductionPriceCorbanana$priceWufeng,ProductionPriceCorbanana$evap)

#��ԻP���������Y��2,�p�G���ĤG�Ӳ��a�A�N�n��
#air_tempPRprice2= cor(ProductionPriceCorbanana$priceWufeng,ProductionPriceCorbanana$air_temp)
#dew_pointPRprice2 = cor(ProductionPriceCorbanana$priceWufeng,ProductionPriceCorbanana$dew_point)
#RHPRprice2 = cor(ProductionPriceCorbanana$priceWufeng,ProductionPriceCorbanana$RH)
#precp_daPRprice2 = cor(ProductionPriceCorbanana$priceWufeng,ProductionPriceCorbanana$precp_da)
#wind_speed_meanPRprice2 = cor(ProductionPriceCorbanana$priceWufeng,ProductionPriceCorbanana$wind_speed_mean)
#sunPRprice2 = cor(ProductionPriceCorbanana$priceWufeng,ProductionPriceCorbanana$sun)
#solar_radPRprice2 = cor(priceWufeng$priceWufeng,ProductionPriceCorbanana$solar_rad)
#evapPRprice2 = cor(ProductionPriceCorbanana$priceWufeng,ProductionPriceCorbanana$evap)

�p�G�S���ĤG�Ӳ��a�N�γo��
air_tempPRprice2= 0
dew_pointPRprice2 = 0
RHPRprice2 = 0
precp_daPRprice2 = 0
wind_speed_meanPRprice2 = 0
sunPRprice2 = 0
solar_radPRprice2 =0
evapPRprice2 = 0




#�Ҧ������Y�ƦX��
BananaCorlation = cbind(TempPrice,dew_pointPrice,RHPrice,precp_daPrice,wind_speed_meanPrice,sunPrice,solar_radPrice,evapPrice,
                        air_temptrade,dew_pointtrade,RHPrice,precp_datrade,wind_speed_meantrade,suntrade,solar_radtrade,evaptrade,
                        air_tempPRprice1,dew_pointPRprice1,RHPRprice1,precp_daPRprice1,wind_speed_meanPRprice1,sunPRprice1,solar_radPRprice1,
                        evapPRprice1,air_tempPRprice2,dew_pointPRprice2,RHPRprice2,precp_daPRprice2,wind_speed_meanPRprice2,sunPRprice2,solar_radPRprice2,
                        evapPRprice2
                        )
  





