clc 
clear all
close all
load errors_density_SVM_BN
dd=average_density;
plot(dd,(EE),'linewidth',2);
xlabel('density')
ylabel('Error %')
title('MSE')

hold on 
load errors_density_Signal_reconstrtuction
dd=average_density;
plot(dd,(EE),'linewidth',2);

hold on 
load ER_RAND_SVM
dd=average_density;
plot(dd,(EE),'linewidth',2);
hold on 

hold on 
load ERROR_SR_RAND
dd=average_density;
plot(dd,(EE),'linewidth',2);

load 1errors_density_RANDOM_ACTIVE_SVM
dd=average_density;
plot(dd,(EE),'linewidth',2);


legend('SVM Blue Noise','Signal R Blue Noise' ,'Uncertaty Sampling','Pasive  Signal R','Pasive SVM')
hold off
xlim([0 0.08])