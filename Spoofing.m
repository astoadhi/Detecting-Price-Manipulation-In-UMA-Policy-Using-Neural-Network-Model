threshold1=0.005
threshold2=5
threshold3=0.5

%Untuk 1 Hari

%Untuk mengetahui data ke berapa, tanggal yg diinput  
IndexHari=find(contains(ABBA.DATE,' 2008-05-19'))
%Untuk mengetahui data ke berapa, Index yang matched
IndexMatched=find(ABBA.matched~=0)
%Untuk mengetahui data ke berapa, status diinput
IndexStatus=find(contains(ABBA.Status,' W '))
%Intersect yg matched dan tanggal
Date=intersect(IndexHari,IndexMatched)
%untuk mengetahui ,mana yang buy dan mana yang sell untuk hari pertama
Index2=find(contains(ABBA.BuySell,' B '))
Index1=find(contains(ABBA.BuySell,' S '))
%Intersect yg Date matched dan withdrawal
 Status=intersect(IndexHari,IndexStatus)
%Data Buy/Sell pada hari yang diinput
Buy = intersect(Index2,Date)
Sell = intersect(Index1,Date)
Buy1 = intersect(Index2,Status)
Sell1 = intersect(Index1,Status)
%1Hari
%buy matched
buy=[ABBA.price(Buy)]
%Sell withdraw
sell=[ABBA.price(Sell1)]
%volum
volum=[ABBA.volum(Sell1)]
%spoofcondition1
spoofcond1=abs((mean(sell)-buy(end))/mean(sell))
 if spoofcond1<threshold1
     spoof1=1
 else
     spoof1=0
 end
 
%spoofcondition2
spoofcond2= sum(volum)
 if spoofcond2>threshold2
     spoof2=1
 else
     spoof2=0
 end

%spoofcondition3
spoofcond3= sum(ABBA.volum(Buy))
 if spoofcond3>threshold3
     spoof3=1
 else
     spoof3=0
 end
spoof=spoof1&spoof2&spoof3