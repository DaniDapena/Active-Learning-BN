clc 
clear all
close all
load errors_density_SVM_BN
dd=average_density;
plot(dd,1-(EE),'linewidth',2);
xlabel('Number of Labelled Images (ratio)')
ylabel('Classification Accuracy')

hold on 
load errors_density_Signal_reconstrtuction
dd=average_density;
plot(dd,1-(EE),'linewidth',2);

hold on 
load 1errors_density_RANDOM_ACTIVE_SVM
dd=average_density;
plot(dd,1-(EE),'linewidth',2);
hold on 

hold on 
load ERROR_SR_RAND
plot(dd,1-(EE),'linewidth',2);

load ER_RAND_SVM
dd=average_density;
plot(dd,1-(EE),'linewidth',2);


legend('SVM Blue Noise','Signal R Blue Noise' ,'Uncertaty Sampling','Pasive  Signal R','Pasive SVM')
hold off
xlim([0 0.08])