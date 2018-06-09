function [Y,Xf,Af] = rnn_created_Fnc(X,Xi,~)
%RNN_CREATED_FNC neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 07-Jun-2018 16:08:30.
% 
% [Y,Xf,Af] = rnn_created_Fnc(X,Xi,~) takes these arguments:
% 
%   X = 2xTS cell, 2 inputs over TS timesteps
%   Each X{1,ts} = 6xQ matrix, input #1 at timestep ts.
%   Each X{2,ts} = 4xQ matrix, input #2 at timestep ts.
% 
%   Xi = 2x2 cell 2, initial 2 input delay states.
%   Each Xi{1,ts} = 6xQ matrix, initial states for input #1.
%   Each Xi{2,ts} = 4xQ matrix, initial states for input #2.
% 
%   Ai = 2x0 cell 2, initial 2 layer delay states.
%   Each Ai{1,ts} = 10xQ matrix, initial states for layer #1.
%   Each Ai{2,ts} = 4xQ matrix, initial states for layer #2.
% 
% and returns:
%   Y = 1xTS cell of 2 outputs over TS timesteps.
%   Each Y{1,ts} = 4xQ matrix, output #1 at timestep ts.
% 
%   Xf = 2x2 cell 2, final 2 input delay states.
%   Each Xf{1,ts} = 6xQ matrix, final states for input #1.
%   Each Xf{2,ts} = 4xQ matrix, final states for input #2.
% 
%   Af = 2x0 cell 2, final 0 layer delay states.
%   Each Af{1ts} = 10xQ matrix, final states for layer #1.
%   Each Af{2ts} = 4xQ matrix, final states for layer #2.
% 
% where Q is number of samples (or series) and TS is the number of timesteps.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [0;0;0;0;0;0];
x1_step1.gain = [3.7037037037037;5;2.7027027027027;2.8169014084507;4.65116279069768;5.88235294117647];
x1_step1.ymin = -1;

% Input 2
x2_step1.xoffset = [-0.601061;-0.78758;-0.390241;-0.838936];
x2_step1.gain = [1.50063176597347;2.33322678264359;1.84940652544598;4.40545130544536];
x2_step1.ymin = -1;

% Layer 1
b1 = [-2.006124701429650603;0.65648590959061237093;1.3615922578955568234;0.04164013460370959846;0.0030775844074990036867;-0.053752226679075608418;-0.065400655272675523033;-0.95621862082721786891;0.10718533839199884117;-0.56039914763779397067];
IW1_1 = [0.098067403076915679594 -0.10711608637025740731 0.40017801047172696371 -0.077565233459660792859 -0.0880035354598334707 0.27793412636779768476 0.075375956332439736363 0.25805196944397967851 -0.78379633277270044367 -0.2744286563419764402 0.12591215577589287555 -0.14505640981768047615;-0.039158602925963098551 0.098036191515476683866 0.0074817142208600598274 0.15003968281050117373 0.05198652615929012788 -0.0044762908390651029444 0.05309711361280283759 -0.09368210595455112033 0.0095535493661977610724 -0.15499704763098684501 -0.048164626254635183045 0.0066901074715909770313;-0.10280684349618698925 -0.13781097756239468755 -0.21678003405421619743 0.28045663123693087559 -0.062122853070589442726 0.22238644972546423029 0.15105883423314758751 0.12885366846073736946 0.22941666649941999667 -0.34449686325452599789 0.15260268835293253065 -0.23663431613636845552;0.13625045554631051714 -0.24536223075515803393 -0.22628658376666929697 -0.049901963047667051432 0.0084188896639867186189 -0.17238678579043309469 -0.15692365671701272167 0.21678452590400815181 0.25946647038220022052 0.0480650249065564944 -0.043528926415832412677 0.11842827104277230121;-0.1155513800789182699 0.21085054277964856984 0.15174213445492559793 0.047832432430419354052 0.058208312491823378798 0.049455175908400372808 0.12167351674069408485 -0.19680426880905954601 -0.15675484045976809111 -0.025276978688484372237 -0.046246160001034007647 -0.025471421801585087535;0.1797804426110686804 -0.32903211245507807403 -0.25120197798978033399 -0.11144940883763643225 -0.071983058844090896944 -0.13117947349687530956 -0.19910848243589543416 0.30233061179014331099 0.26676948893599838897 0.088185451227870373381 0.039174296968670328789 0.086772518053442812547;0.073189596585978358712 -0.13393186356245984081 -0.063063213888592498102 -0.099348202576193020419 -0.1252627880332889132 0.051473036955168777196 -0.077855852339498682335 0.13805154451766213364 0.034064936518176137936 0.074789158907027253331 0.12069561165983160034 -0.031572488387273965615;0.17213563436840648158 -0.062141498443371079308 -0.0023353099513763616278 -0.060927179708462245178 -0.018372029779395251253 -0.020636818027674676268 -0.18515735302888641778 0.055702564757474634649 -0.011264386483520839183 0.052962506762056091314 0.0032042036962402868638 0.016256646946181049773;0.059578187026902269807 -0.11970758392758878985 -0.051839335651576654018 -0.064359905115139684484 -0.088688531334441780829 0.027381617275320256633 -0.06007133355642686745 0.12077678491229333624 0.032558781774163811362 0.033290519217530303853 0.084726804046695095018 -0.018455361001243911212;-0.090126043223560894924 0.21844352492012347744 0.091181042610281759497 0.17045453245546757226 0.13492904959615914517 0.032488703971738266962 0.10356251879482127054 -0.21790859205535983989 -0.069711654664940586601 -0.15028995294083755119 -0.10357124112455548537 -0.037628808029221763598];
IW1_2 = [0.083264447677204006526 -0.28372522549283185622 0.11831319018326519332 0.29731586846933094614 0.10550612235300170505 0.045888932873379022215 -0.0079089984055644400873 -0.034648273737070335587;-0.063889928200410339709 -0.39605517512813803727 0.088570340644514078399 -0.18223041685976235082 -0.078131331737281178862 0.020202704936637547184 -0.16802667740743484903 0.040147582419383244512;-0.32166643448544157691 0.14230688484561451745 -0.063573616556780149223 -0.48993242188427804651 0.22372831815489011009 0.076344560942830930195 -0.18355773856168219882 0.37857151848276315853;0.25360006971205273363 0.31263572616684065508 -0.22112878057450810476 0.11536090284966205033 -0.46487908185070431211 -0.17014248384151062221 0.082491586920374088132 0.20368038203248947648;-0.33101036948982953678 0.81437700461953632658 -0.21512704014240258132 0.094181496037941098143 0.20768078246349042093 -0.474254190595524594 -0.027890025874302129538 -0.16068716930553336719;0.20705944104916082504 -0.19964873008666497722 -0.25651596568851964264 -0.86445090420633174944 -0.29552053568037384146 0.24686608814041932636 0.25253153064637168246 0.5670440155707969776;-0.90813085079228794694 -1.0045222677782505993 -0.26258635382650752366 0.029368837507237906259 0.53147375864175427918 0.90011862156616040398 0.28098870630063821352 -0.031922753671150466692;0.1656219971424548465 -0.061957327671485241949 -0.4728958295160320402 0.22850547576059024313 0.14370405870153871164 0.24704663547827271364 0.074604546128566928687 -0.080434357250107446635;0.014437312705889411915 -0.22215080723949143238 0.096277700225465931427 0.039730683915706721532 0.091971883687342104174 0.42303692083493887877 0.16611514575083033418 -0.017554563621141008878;-0.73195746519866566882 0.39160615302795992454 1.3561523403423889622 -0.1903717290290045383 0.34003260687199310386 -0.59231014396991366056 -0.83944499576804354479 0.10209444460803436538];

% Layer 2
b2 = [0.069930414051614611659;-0.58297308239068101887;0.16223181708187431327;0.12105747362557910118];
LW2_1 = [-0.24611825180746835229 -0.16304752024648264119 0.042672689980259047304 -0.6040427071508823742 -0.8495572685404110258 -0.11875423733681013394 -1.208162461277053179 0.823460420717818109 0.33777116077894087098 -0.53557558532802129747;-0.14905614191293217741 -0.49903886361336807775 0.48349815699071208019 0.42012677525670960588 1.472389437548389024 0.26223074752480463046 -0.47303763751951899419 -0.21909069679463619162 1.4111314168274107228 0.10739217432698981713;-0.18218809709769040461 -0.53485413081834276561 -0.66658998492680143766 -0.087601587275209252814 -0.46346805942973279269 -0.046034168863243879466 -0.31249494376028885689 -1.0635668013712877844 1.2825999462790722561 0.79061481972645453187;0.16319553936160274832 -0.1867315808913431463 0.050939356068582623827 1.2843249052143226319 -0.66480960858574078554 -1.7227911904371473462 0.20362679926460541813 0.17863286005458084427 0.32949168852837618093 -0.1160375752446961839];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = [1.50063176597347;2.33322678264359;1.84940652544598;4.40545130544536];
y1_step1.xoffset = [-0.601061;-0.78758;-0.390241;-0.838936];

% ===== SIMULATION ========

% Format Input Arguments
isCellX = iscell(X);
if ~isCellX
  X = {X};
end
if (nargin < 2), error('Initial input states Xi argument needed.'); end

% Dimensions
TS = size(X,2); % timesteps
if ~isempty(X)
  Q = size(X{1},2); % samples/series
elseif ~isempty(Xi)
  Q = size(Xi{1},2);
else
  Q = 0;
end

% Input 1 Delay States
Xd1 = cell(1,3);
for ts=1:2
    Xd1{ts} = mapminmax_apply(Xi{1,ts},x1_step1);
end

% Input 2 Delay States
Xd2 = cell(1,3);
for ts=1:2
    Xd2{ts} = mapminmax_apply(Xi{2,ts},x2_step1);
end

% Allocate Outputs
Y = cell(1,TS);

% Time loop
for ts=1:TS

      % Rotating delay state position
      xdts = mod(ts+1,3)+1;
    
    % Input 1
    Xd1{xdts} = mapminmax_apply(X{1,ts},x1_step1);
    
    % Input 2
    Xd2{xdts} = mapminmax_apply(X{2,ts},x2_step1);
    
    % Layer 1
    tapdelay1 = cat(1,Xd1{mod(xdts-[1 2]-1,3)+1});
    tapdelay2 = cat(1,Xd2{mod(xdts-[1 2]-1,3)+1});
    a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*tapdelay1 + IW1_2*tapdelay2);
    
    % Layer 2
    a2 = repmat(b2,1,Q) + LW2_1*a1;
    
    % Output 1
    Y{1,ts} = mapminmax_reverse(a2,y1_step1);
end

% Final Delay States
finalxts = TS+(1: 2);
xits = finalxts(finalxts<=2);
xts = finalxts(finalxts>2)-2;
Xf = [Xi(:,xits) X(:,xts)];
Af = cell(2,0);

% Format Output Arguments
if ~isCellX
  Y = cell2mat(Y);
end
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