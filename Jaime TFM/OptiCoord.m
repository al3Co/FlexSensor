%Jaime Lorenzo
%Optitrack data reading
function [ArmPos,ArmAngle,Reference,Verticality,RealTime] = OptiCoord(ficherocsv)

%Import text of data
[num,txt,~] = xlsread(ficherocsv);
[TR] = RealTimeOpti(txt);
Frames = num(1,12) + 6;
Time = csvread(ficherocsv,7,1,[7,1,Frames,1]); 
%Matrix with time data
RealTime = Time;
%Matrix with real time data
for i=1:size(RealTime,1)
    RealTime(i,1) = seconds(TR) + RealTime(i,1);
end

ArmPos = csvread(ficherocsv,7,6,[7,6,Frames,8]); 

ArmAngle = csvread(ficherocsv,7,2,[7,2,Frames,4]);

Reference = csvread(ficherocsv,7,34,[7,34,Frames,36]);

Verticality = csvread(ficherocsv,7,9,[7,9,Frames,11]);

%Mostrar posiciones respecto al tiempo
% plot(Time,ArmAngle(:,1),'Color','b')
% hold on
% plot(Time,ArmAngle(:,2),'Color','g')
% plot(Time,ArmAngle(:,3),'Color','r')
% title('Posición Hombro')
% xlim([0 Time(size(Time,1),1)]);
% xlabel('Tiempo');
% ylabel('XYZ');
% set(gca,'XGrid','on','YGrid','on');

end