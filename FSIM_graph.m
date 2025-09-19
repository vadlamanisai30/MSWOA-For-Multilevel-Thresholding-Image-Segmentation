xdata=[2,3,5,8];
 
Otsu=	[0.5855	0.7251	0.8241	0.8497];
Kapur=[0.7328	0.7963	0.8474	0.9158];

 bpcombine2=Kapur;bpcombine1=Otsu;
bpcombined = [bpcombine1(:), bpcombine2(:)];
hb = bar(xdata, bpcombined, 'grouped')
xlabel('Number of Thresholds');ylabel('FSIM');
title('Feature Similarity Index Measure');legend('Otsu','Kapur');
