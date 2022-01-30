load quake 
whos e n v
Time = (1/200)*seconds(1:length(e))';
whos Time
varNames = {'EastWest', 'NorthSouth', 'Vertical'};
quakeData = timetable(Time, e, n, v, 'VariableNames', varNames);
head(quakeData)
% subplot(3,1,1)
% plot(quakeData.Time,quakeData.EastWest)
% title('Loma Prieta Earthquake (East-West)')
% xlabel('\bftime (sec)')
% ylabel('\bfground acceleration (g)')
% subplot(3,1,2)
% plot(quakeData.Time,quakeData.Vertical)
% title('Loma Prieta Earthquake (Vertical Component)')
% xlabel('\bftime (sec)')
% ylabel('\bfground acceleration (g)')
% subplot(3,1,3)
% plot(quakeData.Time,quakeData.NorthSouth)
% title('Loma Prieta Earthquake (North-South)')
% xlabel('\bftime (sec)')
% ylabel('\bfground acceleration (g)')

quakeData.Variables = 0.098*quakeData.Variables;
% t1 = seconds(8)*[1;1];
% t2 = seconds(20)*[1;1];
% hold on 
% plot([t1 t2],ylim,'k','LineWidth',2)
% hold off
tr = timerange(seconds(8),seconds(11));
data1 = quakeData(tr,:);
figure
% 
% plot(dataOfInterest.Time,dataOfInterest.EastWest)
tr1 = timerange(seconds(11),seconds(15));
data2 =  quakeData(tr1,:);

% ylabel('Real part')
% title('Signal in time')
N = length(data1.EastWest);
X = fft(data1.EastWest);
 Ts = 0.005;
 Fs = 1 / Ts;
freq = (Fs/N) * (0 : floor(0.5*N)+1);
plot(freq,abs(X(1:length(freq))),'b','linewidth',1.5)
xlabel('\bffrequency (Hz)')
ylabel('\bfMagnitude Response (dB)')


edot = (1/200)*cumsum(data1.EastWest);
edot = edot - mean(edot);
vel = varfun(@velFun,data1);
head(vel)
pos = varfun(@velFun,velFun_EastWest);
head(pos)
%pos.Properties.VariableNames = varNames;
figure
plot(vel.Time,pos.Variables)
legend(quakeData.Properties.VariableNames,'Location','NorthWest')
title('Position')
edot1 = (1/200)*cumsum(data2.EastWest);
edot1 = edot1 - mean(edot1);
vel1 = varfun(@velFun,data2);
head(vel1)
pos1 = varfun(@velFun,vel1);
head(pos1)
pos1.Properties.VariableNames = varNames;
figure
plot(vel1.Time,pos1.Variables)
legend(quakeData.Properties.VariableNames,'Location','NorthWest')
title('Position')
% s = spectrogram(dataOfInterest.EastWest);
% spectrogram(dataOfInterest.EastWest,'yaxis')
% wvd(dataOfInterest.EastWest)
% % %wvd(dataOfInterest.Vertical)
% % c=dtfd_nonsep(dataOfInterest.EastWest,'cw',{N}); 
% % clf; vtfd(c,dataOfInterest.EastWest);
% % c1=dtfd_nonsep(dataOfInterest.Vertical,'cw',{30}); 
% % clf; vtfd(c1,dataOfInterest.Vertical);

