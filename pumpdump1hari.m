threshold1=0.002
threshold2=0.15
threshold3=0.5

%Untuk 1 Hari

%Untuk mengetahui data ke berapa, tanggal yg diinput  
IndexHari=find(contains(ABBA.DATE,' 2008-05-11'))
%Untuk mengetahui data ke berapa, Index yang matched
IndexMatched=find(ABBA.matched~=0)
%Untuk mengetahui data ke berapa, status diinput
IndexStatus=find(contains(ABBA.Status,' W '))
%Intersect yg matched dan tanggal
Date=intersect(IndexHari,IndexMatched)
%untuk mengetahui ,mana yang buy dan mana yang sell untuk hari pertama
Index2=find(contains(ABBA.BuySell,' B '))
Index1=find(contains(ABBA.BuySell,' S '))
%Data Buy/Sell pada hari yang diinput
Buy = intersect(Index2,Date)
Sell = intersect(Index1,Date)

%1Hari

%buy/sell matched
buy=[ABBA.price(Buy)]
sell=[ABBA.price(Sell)]
%pumpcondition
pumpcond1=(max(buy)-min(buy))/max(buy)
 if pumpcond1>threshold1
     pump=1
 else
     pump=0
 end
%dumpcondition1
dump=(max(sell)-min(sell))/max(sell)
 if dump>threshold2
     dumpcond1=1
 else dumpcond1=0
 end
 %dumpcondition2
 volum=[ABBA.volum(buy)]
 Eb= mean(volum)
 %Intersect yg Date matched dan withdrawal
 Status=intersect(Date,IndexStatus)
 %masukkan data intersect ke dalam data volum
 vbc=sum(ABBA.volum(Status))
 if vbc>threshold3*volum
     dumpcond2=1
 else dumpcond2=0
 end
 dump = dumpcond1&dumpcond2
 pumpdump= pump& dump 
     