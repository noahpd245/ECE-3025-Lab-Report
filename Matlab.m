close all
%% Conversions
radians = (angle/360)*2*pi;
V = (mV-5.1)*(10^-3);
W = V*(.5*(10^-6));
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
angleIntegrand = radians(23:end);
WIntegrand = W(23:end);
Total_power_empirical = 2*pi*trapz(angleIntegrand,((WIntegrand*sphericalRadius^2)/Ar).*sin(angleIntegrand))
Total_power_predicted = (2*pi*K0)/(powerBestFit +1)
Actual_Power_Consumed = (9-6.54)*(6.54/1182)

%% Re-Fitted Model
N = length(radians);
x = 0:.1:200;
tempFitNew = zeros(N,1);
F_Least_Squares_New = zeros(length(x),1);

for index = 1:length(x)
%index = 2;
for i = 1:N
 tempFitNew(i) = (WNorm(i) - ((cos(radians(i)-.1396).^x(index))+(cos(radians(i)+.1396).^x(index))) ).^2;
end
F_Least_Squares_New(index) = (1/N)*sum(tempFitNew);
end
[minValNew minIndexNew] = min(F_Least_Squares_New);
powerBestFitNew = x(minIndexNew)
smallestErrorNew = F_Least_Squares_New(minIndexNew)

plot(radians,K0*((cos(radians-.1396).^powerBestFitNew)+(cos(radians+.1396).^powerBestFitNew)),radians,((W*sphericalRadius^2)/Ar))