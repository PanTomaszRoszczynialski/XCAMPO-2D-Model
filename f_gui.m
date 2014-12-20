%% GET DATA
SIZE = 1001;
t = linspace(-1,1,SIZE);
[X, Y] = meshgrid(t,t);
gaus = exp(-X.^2 - Y.^2);
%% LENS
LENS = struct();
LENS.diameter = 2.4e-3; % METERS
LENS.line = linspace(-LENS.diameter/2,LENS.diameter/2,SIZE);
[LENS.X, LENS.Y] = meshgrid(LENS.line,LENS.line);
LENS.shape = simpleLens2D(LENS.X,LENS.Y,LENS.diameter/2,SIZE);


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
                                500,...
                                'LENS');

%% FILL OBJECT SIDE (right)                            
rightGrid = makeImageWithProfile(mainGrid,...
                                 gaus,...
                                 X(1,:),X(1,:),...
                                 500,...
                                 'DUPA');                            

if(true)
    
%     
%     % BOX1 
%     box11 = uiextras.BoxPanel('Parent',grid11,...
%                               'Title', 'Lens',...
%                               'Padding',5);
%     axes1 = axes('Parent',box11,...
%                  'ActivePositionProperty',...
%                  'OuterPosition' );
%     imagesc(X(1,:),X(1,:),gaus,'Parent',axes1);
%     colormap gray
%     % BOX2
%     box12 = uiextras.BoxPanel('Parent',grid11,...
%                               'Title', 'Lens Profile',...
%                               'Padding',5);
%     axes2 = axes('Parent',box12,...
%                  'ActivePositionProperty',...
%                  'OuterPosition' );
%     plot(axes2,X(1,:),gaus(500,:));
    
    
end



%% SET TABS NAMES
tabs.TabNames = {'Objects'};