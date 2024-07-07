threshold1=0.002
threshold2=0.15
threshold3=0.5

%Untuk 2 Hari

%Untuk mengetahui data ke berapa, tanggal yg diinput  
IndexHari1=find(contains(ABBA.DATE,' 2008-05-12'))
%Untuk mengetahui data ke berapa, tanggal yg diinput  
IndexHari2=find(contains(ABBA.DATE,' 2008-05-08'))
%Untuk mengetahui data ke berapa, Index yang matched
IndexMatched=find(ABBA.matched~=0)
%Untuk mengetahui data ke berapa, status diinput
IndexStatus=find(contains(ABBA.Status,' W '))
%Intersect yg matched dan tanggal
Date1=intersect(IndexHari1,IndexMatched)
%Intersect yg matched dan tanggal
Date2=intersect(IndexHari2,IndexMatched)
%untuk mengetahui ,mana yang buy dan mana yang sell untuk hari pertama
Index2=find(contains(ABBA.BuySell,' B '))
Index1=find(contains(ABBA.BuySell,' S '))
%Data Buy/Sell pada hari yang diinput
Buy1 = intersect(Index2,Date1)
Sell1 = intersect(Index1,Date1)
%Data Buy/Sell pada hari yang diinput
Buy2 = intersect(Index2,Date2)
Sell2 = intersect(Index1,Date2)

%buy/sell matched hari pertama
buy1=[ABBA.price(Buy1)]
sell1=[ABBA.price(Sell1)]

%buy/sell matched hari kedua
buy2=[ABBA.price(Buy2)]
sell2=[ABBA.price(Sell2)]

%pumpcondition
pumpcond1=(max(buy2)-min(buy1))/max(buy2)
 if pumpcond1>threshold1
     pump=1
 else pump=0
 end
%dumpcondition1
dump=(max(sell1)-min(sell2))/max(sell1)
 if dump>threshold2
     dumpcond1=1
 else dumpcond1=0
 end
 %dumpcondition2
 volum=[ABBA.volum(buy1)]
 Eb= mean(volum)
 %Intersect yg Date matched dan withdrawal
 Status=intersect(Date2,IndexStatus)
 %masukkan data intersect ke dalam data volum
 vbc=sum(ABBA.volum(Status))
 if vbc>threshold3*volum
     dumpcond2=1
 else dumpcond2=0
 end
 dump = dumpcond1&dumpcond2
 pumpdump= pump& dump 
     
