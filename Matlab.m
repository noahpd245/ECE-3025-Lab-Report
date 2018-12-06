close all
%% Conversions
radians = (angle/360)*2*pi;
nW = (mV - 5.1)*2;
W = nW*10^(-9);
WNorm = W/max(W); %Ask buck about this
 
%% Measured and Computed Parameters
apetureRadius = .69/2*10^-3;
sphericalRadius = (149.63+5.00)*10^-3;
Ar = pi*(apetureRadius^2);
P0 = max(W);
I0 = P0/Ar;
K0 = I0*(sphericalRadius^2);
 
%% Least Squares fit 
N = length(radians);
x = 0:.1:100;
tempFit = zeros(N,1);
F_Least_Squares = zeros(length(x),1);

for index = 1:length(x)
%index = 2;
for i = 1:N
 tempFit(i) = (WNorm(i) - (cos(radians(i)) .^x(index))).^2;
end
F_Least_Squares(index) = (1/N)*sum(tempFit);
end
[minVal minIndex] = min(F_Least_Squares);
powerBestFit = x(minIndex)
smallestError = F_Least_Squares(minIndex)
%% Integral
angleIntegrand = radians(27:end);
WIntegrand = W(27:end);
integral_angle = ((WIntegrand*sphericalRadius^2)/Ar).*sin(angleIntegrand).*[diff(angleIntegrand); 0];
Total_power = 2*pi*sum(integral_angle)
Total_power_predicted = (2*pi*K0)/(powerBestFit +1)

 %% Plots
 
% Radians vs. Power Emitted
%Rad_vs_Power = figure;
%axes1 = axes('Parent',Rad_vs_Power);
%hold(axes1,'on');
%plot(radians,WNorm);
%hold on
%plot(radians,cos(radians).^powerBestFit);
%ylabel({'Power(Watts)'});
%xlabel({'Radians'});
%title({'Radians vs. Power Emitted'});
%hold off

% Least Squares Plot
figure2 = figure;
plot(x,F_Least_Squares)

% Radians vs. Power Emitted polar plot
figure3 = figure;
%axes1 = axes('Parent',Rad_vs_Power);
radiansplot = radians;
polarplot(radiansplot,WNorm);
hold on
polarplot(radians,cos(radians).^powerBestFit);
hold off
title({'Radians vs. Power Emitted Polar'});