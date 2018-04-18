function [y1,xf1,xf2] = ann_TimeSeriesFunction(x1,x2,xi1,xi2)
%ANN_TIMESERIESFUNCTION neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 18-Apr-2018 11:45:05.
% 
% [y1,xf1,xf2] = ann_TimeSeriesFunction(x1,x2,xi1,xi2) takes these arguments:
%   x1 = 10xTS matrix, input #1 [1.54;2.08;1.52;1.7;1.5;1.14;2.29;1.8;1.51;1.81]
%   x2 = 4xTS matrix, input #2 [0.983733;-0.12504;-0.12691;0.022987]
%   xi1 = 10x1 matrix, initial 1 delay states for input #1. [1.54;2.08;1.52;1.7;1.5;1.14;2.29;1.8;1.51;1.81]
%   xi2 = 4x1 matrix, initial 1 delay states for input #2. [0.983626;-0.124455;-0.128225;0.023457]
% and returns:
%   y1 = 4xTS matrix, output #1
%   xf1 = 10x1 matrix, final 1 delay states for input #1.
%   xf2 = 4x1 matrix, final 1 delay states for input #2.
% where TS is the number of timesteps.

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [1.46;1.81;1.38;1.51;1.1;1.08;1.88;1.74;1.42;1.69];
x1_step1.gain = [12.5;6.06060606060606;10.5263157894737;7.69230769230769;4.44444444444444;22.2222222222223;4.34782608695652;16.6666666666667;16.6666666666667;11.1111111111111];
x1_step1.ymin = -1;

% Input 2
x2_step1.xoffset = [0.713659;-0.31698;-0.651002;-0.569113];
x2_step1.gain = [7.39669589594328;5.59788176154143;2.94108564294338;3.00483929368248];
x2_step1.ymin = -1;

% Layer 1
b1 = [0.18356736598392542348;-0.33574259508367970684;0.78725702993142676611;0.4736072809015735019;0.032331633587502246752;-0.082593143385708417403;-0.53092143478264619549;-2.7520124334195465998;-1.4776711854949859948;2.2216472107502394095];
IW1_1 = [0.057422699757650047525 -0.084849975475361133492 -0.029454925699143649082 -0.014775485345086325495 0.038782989544850696162 -0.0011231038778930710342 0.038364450014167321423 -0.037482720947438534498 0.027073049048377605813 -0.050582630252200742882;-0.64824868642179156453 0.78553066543808558464 0.14082021203849998114 0.28984396251980071302 -0.225419806673312767 0.016427377045594139526 -0.41767317609305193438 0.38235670352545436668 -0.16063939295248472194 0.18396087948514711075;-0.76071448701144173121 1.1967983929506935681 0.093296370852920598726 0.4130111233335383436 -0.35852947859484951554 0.027773501082067005019 -0.66785500103671269212 0.53220456487742140439 -0.24643281974696260028 0.36280693977866579347;0.33159130359596172832 -0.42019503312070671797 -0.11570048610470112793 0.026227992069836291583 -0.24984316643013707027 0.26535458331983902136 0.23441664837990544568 -0.22039845356205411964 -0.28029976360722869133 0.21700845008809588332;0.10573299549841681799 -0.14172383327612861348 -0.047028957964133095981 -0.046988713605916318516 0.058358647003799828112 -0.036420919148400933418 0.07614292545149957403 -0.040211108387168577327 0.065271763558920642412 -0.043344405310266238829;0.13281306185462479763 -0.17284589019218349337 -0.034356295233584049909 -0.07012500108593260062 0.079115892368551002378 -0.037904515018838534635 0.10172843400359064814 -0.073109657924803603257 0.089613509327035309471 -0.056927529444715498086;-0.63938163433085448695 0.71831856149308825898 0.20431735410945661702 0.23724712630091518428 -0.36201754607814590203 0.051618886836505152582 -0.43114903459238945738 0.34961935037872937659 -0.25447238498065821721 0.2702525356868622497;1.5216199206605751648 -2.3804027610135038984 0.32619402455668738972 -0.61151789905834053052 0.48978225960621396551 0.19181592593912061284 1.1104574896298580189 -1.6443712984781722053 0.28654077164577212988 -0.80531123118621428247;-0.0006402173814295461507 -0.068916816785329279571 0.29480901621422123116 -0.36096660488220394525 0.21856747525002040433 -0.74802459222210304635 -0.47060001104150378515 -0.11708504926806151403 0.13583866110037973174 -0.15616125884634809995;-0.060125230598531607951 0.29476990732174496168 -0.033668926231968855645 -0.29413614576196983608 -0.11830005585755377917 -0.033877064739725945564 0.25244943770307187725 0.23047136810707408161 -0.12289405699557856555 0.51758204388695960851];
IW1_2 = [0.32139848410934879208 0.31672391293015161873 0.059671220572496089241 -0.63908291744796552614;-0.13640878032277400922 -0.46410990473353469499 -0.76447506608807358486 0.32004376637262782479;-0.34460948243014433157 0.045693973660044580332 -1.2093619916401281422 0.50325891289955115848;0.0090356484817140161891 -0.61500654382090691463 0.57588729460681842287 -0.052021204219157013426;0.16522052595057734603 -0.50100150822716937871 -0.35091721512578399889 -0.32547789242180702463;-0.43623831276034763516 0.1398075041687737996 0.65361708127586903849 -0.060817386829333255904;-0.33803853151852669701 0.044249559649095451808 -0.83249399763588116663 0.30776761069171598706;0.92381549876779267549 1.0939371837028666334 1.8766965241689723687 -1.2034816528796223878;-0.255578327405228789 0.34899336601545294378 0.75167350037855684697 -0.065046168692762501573;0.40670622176414661375 0.2509796023396945186 -0.45306928818446934315 -0.3569442245033850325];

% Layer 2
b2 = [-1.2673387923473669048;-0.25776079153846725989;-0.66803994959447920987;0.83292027126739520693];
LW2_1 = [0.57337431442751407573 0.94237238572113180002 -0.85263000166138480651 0.12637848054646530493 -1.3377498973817898431 -1.6897291657690218791 -1.1855572582690732109 -1.9009084959972286644 0.6708812353259568928 0.06267617045970136358;0.21846644067612322471 -0.99944626467850661289 0.49666962206042836181 -0.35935744956468890221 -0.56908358444355477967 -0.18344827836443519664 0.53647014413777927011 1.5227847014166464579 -0.35785213720722713893 1.1977760344701819939;0.62218150450823994646 1.3164918560878986487 -0.78092273742816831206 0.37141173766238044784 -1.2488332024740682602 0.34388887108124083225 -0.94289049161093507756 -2.0621385349376759599 0.83776446377852442637 -0.3300669563109016047;-1.2904174326448043519 -0.11958377539680949131 -0.22929751319805072307 -0.14723429000283547174 -0.86295540538619430748 -0.97172913725217557879 -0.35810213531054579938 0.044975379948642771333 0.12636173258876753911 -0.49997446174645709949];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = [7.39669589594328;5.59788176154143;2.94108564294338;3.00483929368248];
y1_step1.xoffset = [0.713659;-0.31698;-0.651002;-0.569113];

% ===== SIMULATION ========

% Dimensions
TS = size(x1,2); % timesteps

% Input 1 Delay States
xd1 = mapminmax_apply(xi1,x1_step1);
xd1 = [xd1 zeros(10,1)];

% Input 2 Delay States
xd2 = mapminmax_apply(xi2,x2_step1);
xd2 = [xd2 zeros(4,1)];

% Allocate Outputs
y1 = zeros(4,TS);

% Time loop
for ts=1:TS

      % Rotating delay state position
      xdts = mod(ts+0,2)+1;
    
    % Input 1
    xd1(:,xdts) = mapminmax_apply(x1(:,ts),x1_step1);
    
    % Input 2
    xd2(:,xdts) = mapminmax_apply(x2(:,ts),x2_step1);
    
    % Layer 1
    tapdelay1 = reshape(xd1(:,mod(xdts-1-1,2)+1),10,1);
    tapdelay2 = reshape(xd2(:,mod(xdts-1-1,2)+1),4,1);
    a1 = tansig_apply(b1 + IW1_1*tapdelay1 + IW1_2*tapdelay2);
    
    % Layer 2
    a2 = b2 + LW2_1*a1;
    
    % Output 1
    y1(:,ts) = mapminmax_reverse(a2,y1_step1);
end

% Final delay states
finalxts = TS+(1: 1);
xits = finalxts(finalxts<=1);
xts = finalxts(finalxts>1)-1;
xf1 = [xi1(:,xits) x1(:,xts)];
xf2 = [xi2(:,xits) x2(:,xts)];
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings)
  y = bsxfun(@minus,x,settings.xoffset);
  y = bsxfun(@times,y,settings.gain);
  y = bsxfun(@plus,y,settings.ymin);
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n,~)
  a = 2 ./ (1 + exp(-2*n)) - 1;
end

% Map Minimum and Maximum Output Reverse-Processing Function
function x = mapminmax_reverse(y,settings)
  x = bsxfun(@minus,y,settings.ymin);
  x = bsxfun(@rdivide,x,settings.gain);
  x = bsxfun(@plus,x,settings.xoffset);
end
