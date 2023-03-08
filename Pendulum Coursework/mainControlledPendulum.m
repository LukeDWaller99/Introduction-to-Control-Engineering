close all
clear
clc

%Setup the time points 
dt = 0.02; %increment value of the simulation
tFinal = 3; % final time value of the simulation 
t = 0 : dt : tFinal;

%set up variables, [need to this twice, once for the lunenberger observer and
%once for the integral action]
mu = 0.05;
g = 9.81;
l = 0.64;
M = 0.314;
I = (1/12) * M * l^2;

a1 = (mu)/(I + M*l^2);
a2 = -(M*g*l)/(I + M*l^2);
b0 = (M*l)/(I + M*l^2);

D = [0 0 0 0];

%setting up the Lunenberger observer, L [2x2 matrices]
A = [0 1; -a2 -a1];
C = [1 0];
P = 10 * [-1; -1.1];
L = place(A, C', P);

%setting up the integral action gain, K [4x4 matrices]
A = [0 1 0 0; -a2 -a1 0 0; 0 0 0 0; 0 0 1 0];      
B = [b0; -a1*b0; 1; 0];    
C = [1 0 0 0];
P = 4 *[-1 -1.1 -1.2 -1.3];
K = place(A, B, P);

%Creates the title for the graphs, Title and Student No.
titleMessage = 'Controlled Inverted Pendulum: 10618407';
disp(titleMessage)

%initialise the arrays
xData=[];
yData=[];
tData=[];
kickFlag=[];

%for the number of sub loop runs 
runs = 1; %Pendulum does 3 runs
for kick = 1 : runs
    
    %for each run randomly generate the initial conditions
    x0 = [0; 3 * (rand - 0.5); 0; 0];
    
    %run the Euler integration 
    [y, t, x] = myStateSpaceIntergrator (@VCPEndDotCB, a1, a2, b0, C, D, K, L, t, x0);
    
    %get the time 
    newTime = (kick - 1) * t(end) + t; 
    
    %show the kick only at the start of the run 
    frames = length(t);
    kickFlagK = zeros(1,frames);
    if(x0(2) > 0)
        %scale arrow to size of kick
        kickFlagK(1: floor(frames/4)) = -abs(x0(2));
    else
        %scale arrow to size of kick
        kickFlagK(1: floor(frames/4)) = abs(x0(2));
    end
    
    %concatenate data between the runs
    xData = [xData x];
    yData = [yData y];
    tData = [tData newTime];
    kickFlag = [kickFlag kickFlagK];
end

%Plot all of the state variables
plotStateVariable(xData, tData, titleMessage);

%for all of the points, animate the results
figure
range = 1;

%sets where the cart is along the track
distance = yData(1,:);

%use the animate function 
animatePendulumCart((yData + pi),  distance, 0.6, tData, range, kickFlag, titleMessage);

