xdata=[2,3,5,8];
 
Otsu=	[18.36	21.4	22.37	23.37];
Kapur=[19.91	21.5	25.18	29.22];

 bpcombine2=Kapur;bpcombine1=Otsu;
bpcombined = [bpcombine1(:), bpcombine2(:)];
hb = bar(xdata, bpcombined, 'grouped')
xlabel('Number of Thresholds');ylabel('PSNR');
title('Peak Signal to Noise Ratio');legend('Otsu','Kapur');
