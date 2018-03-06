%Real time correction
function [Tiempo] = RealTimeOpti(txt)
%recibimos la parte de texto de los resultados de la grabación
TimeChar = char(txt(1,10));
%comprobamos si es AM o PM para así sumar 12 horas en caso de ser necesario
AoP = 0;
if TimeChar(1,25) == 'P'
    AoP = 1;
end
%Eliminamos la fecha y el formato de la hora
for i=1:(size(TimeChar,2)-15)
    TimeChar(1,i)='x';
end
for i=1:3
    TimeChar(1,i+23)='x';
end

TStr = erase(string(TimeChar),'x');
%Generamos un nuevo array de caracteres para cada uno de los datos
%referentes al tiempo
TStrh = char(TStr);
TStrm = char(TStr);
TStrs = char(TStr);

%En esta parte eliminamos lo que no sea correspondiente en cada caso
%horas
for i=1:(size(TStrh,2)-2)
    TStrh(1,i+2) = 'x';
end
TStrh = erase(string(TStrh),'x');
if AoP == 1
    TStrh = num2str(str2num(char(TStrh)) + 12);
end

%minutos
for i=1:(size(TStrm,2)-5)
    TStrm(1,i+5) = 'x';
end
for i=1:3
    TStrm(1,i) = 'x';
end
TStrm = erase(string(TStrm),'x'); 

%segundos
for i=1:6
    TStrs(1,i) = 'x';
end
TStrs = erase(string(TStrs),'x'); 

%Convertimos los strings anteriores a formato de duración
Tiempo = hours(str2num(char(TStrh))) + minutes(str2num(char(TStrm))) + seconds(str2num(char(TStrs)));

end

