%% GET DATA
SIZE = 512;
t = linspace(-1,1,SIZE);
[X, Y] = meshgrid(t,t);
gaus = exp(-X.^2 - Y.^2);

%% SETUP PARAMETERS
focal = 14e-3;
Dist = 171e-3;
Magnif = (focal - Dist)/focal;

%% LENS
LENS = struct();
LENS.diameter = 2.4e-3; % METERS
LENS.line = linspace(-LENS.diameter/2,LENS.diameter/2,SIZE);
[LENS.X, LENS.Y] = meshgrid(LENS.line,LENS.line);
LENS.fun = @(X,Y)simpleLens2D(X,Y,LENS.diameter/2,SIZE);
% LENS.shape = simpleLens2D(LENS.X,LENS.Y,LENS.diameter/2,SIZE);
LENS.shape = LENS.fun(LENS.X,LENS.Y);
%% GAUSS
E = 30;
THc = 30/E*1e-3;
GG = @(X,Y) 1/2/pi/THc^2 * exp(-0.5*(X.^2+Y.^2)/THc^2/Dist^2);
%% DETECTOR PLANE
DET.X = Magnif * LENS.X;
DET.Y = Magnif * LENS.Y;
%% CALCULATE eq9 WITHOUT OBJECT
NoObjEq9 = intensity2D_eq9(LENS.shape,LENS.X,LENS.Y,DET.X,DET.Y,Magnif,GG);


%% INIT FIGURE f
f = figure('Name', 'XCAMPO 2 DIMENSIONAL MODEL', ...
           'MenuBar', 'none', ...
           'Toolbar', 'figure', ...
           'NumberTitle', 'off',...
           'units','normalized');
%% INIT TABS tabs       
tabs = uiextras.TabPanel('Parent',f,'Padding',5);   

%% FILL FIRST TAB | OBJECT && LENS
mainGrid = uiextras.HBoxFlex( 'Parent', tabs, 'Spacing', 5 );
%% FILL LENS SIDE (left)
leftGrid = makeImageWithProfile(mainGrid,...
                                LENS.shape,...
                                LENS.line,...
                                LENS.line,...
                                round(SIZE/2),...
                                'LENS');

%% FILL OBJECT SIDE (right)                            
rightGrid = makeImageWithProfile(mainGrid,...
                                 gaus,...
                                 X(1,:),X(1,:),...
                                 round(SIZE/2),...
                                 'DUPA');
%% FILL EQ9 NO OBJECT (test)
thirdGrid = makeImageWithProfile(mainGrid,...
                                 NoObjEq9,...
                                 DET.X(1,:),DET.X(1,:),...
                                 round(SIZE/2),...
                                 'DUPA');

%% SET TABS NAMES
tabs.TabNames = {'Objects'};