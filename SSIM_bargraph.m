xdata=[2,3,5,8];
 
Otsu=	[0.5278	0.6732	0.791	0.8343];
Kapur=[0.6754	0.7407	0.816	0.8787];

 bpcombine2=Kapur;bpcombine1=Otsu;
bpcombined = [bpcombine1(:), bpcombine2(:)];
hb = bar(xdata, bpcombined, 'grouped')
xlabel('Number of Thresholds');ylabel('SSIM');
title('Structural Similarity Index Measure');legend('Otsu','Kapur');
