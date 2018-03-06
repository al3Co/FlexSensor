function [X,Y,Z,XV,YV,ZV] = QuaternTimeCheck(SensorFile,ArmAngle,Verticality,RealTime)

SensorTime = STCorrection(SensorFile);

X = zeros(size(SensorTime,1),1);
Y = zeros(size(SensorTime,1),1);
Z = zeros(size(SensorTime,1),1);
XV = zeros(size(SensorTime,1),1);
YV = zeros(size(SensorTime,1),1);
ZV = zeros(size(SensorTime,1),1);
h = 1;

for ii=1:size(SensorTime,1)
     if SensorTime(ii,1) >= RealTime(1,1)
        h = ii+4;
        break
     end
end
    
for i=h:size(SensorTime,1)
    for j=1:size(RealTime,1)
        if SensorTime(i,1) <= RealTime(j,1)
            t = j;
            tv = j;
            break
        end
    end
    v = t-1;
    vv = t-1;
    while ArmAngle(v,1) == 0
        v = v-1;
    end
    while ArmAngle(t,1) == 0
        t = t+1;
    end   
    while Verticality(vv,1) == 0
        vv = vv-1;
    end
    while Verticality(tv,1) == 0
        tv = tv+1;
    end   
    if SensorTime(i,1) == RealTime(t,1)
          X(i,1) = ArmAngle(t,1);
          Y(i,1) = ArmAngle(t,2);
          Z(i,1) = ArmAngle(t,3);
          XV(i,1) = Verticality(tv,1);
          YV(i,1) = Verticality(tv,2);
          ZV(i,1) = Verticality(tv,3);
    else
          X(i,1) = ArmAngle(v,1) + ((ArmAngle(t,1)-((ArmAngle(v,1)/(RealTime(t,1)-RealTime(v,1)))*(SensorTime(i,1)-(RealTime(v,1))))));
          Y(i,1) = ArmAngle(v,2) + ((ArmAngle(t,2)-((ArmAngle(v,2)/(RealTime(t,1)-RealTime(v,1)))*(SensorTime(i,1)-(RealTime(v,1))))));
          Z(i,1) = ArmAngle(v,3) + ((ArmAngle(t,3)-((ArmAngle(v,3)/(RealTime(t,1)-RealTime(v,1)))*(SensorTime(i,1)-(RealTime(v,1))))));
          XV(i,1) = Verticality(vv,1) + ((Verticality(tv,1)-((Verticality(vv,1)/(RealTime(tv,1)-RealTime(vv,1)))*(SensorTime(i,1)-(RealTime(vv,1))))));
          YV(i,1) = Verticality(vv,2) + ((Verticality(tv,2)-((Verticality(vv,2)/(RealTime(tv,1)-RealTime(vv,1)))*(SensorTime(i,1)-(RealTime(vv,1))))));
          ZV(i,1) = Verticality(vv,3) + ((Verticality(tv,3)-((Verticality(vv,3)/(RealTime(tv,1)-RealTime(vv,1)))*(SensorTime(i,1)-(RealTime(vv,1))))));
    end
end

