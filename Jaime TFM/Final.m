prompt = ('Enter sensor data file name: ');
SensorFile = input(prompt,'s');
prompt = ('Enter optitrack data file name: ');
ficherocsv = input(prompt,'s');

[ArmPos,ArmAngle,Reference,Verticality,RealTime] = OptiCoord(ficherocsv);
[X,Y,Z,XV,YV,ZV] = QuaternTimeCheck(SensorFile,ArmAngle,Verticality,RealTime);
BrazoGF = [X,Y,Z];
EspaldaGF = [XV,YV,ZV];