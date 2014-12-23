function [out] = makeImageWithProfile(PARENT,IM,x,y,cutPoint,name)
% function prepares VBoxFlex element with 2D image and 
% its cross section at selected point

theGrid = uiextras.VBoxFlex('Parent',PARENT,'Spacing',5);

% make 2D image
box1 = uiextras.BoxPanel('Parent',theGrid,...
                         'Title', name,...
                         'Padding',5);
axImage = axes('Parent',box1,...
               'ActivePositionProperty',...
               'OuterPosition' );
           
imagesc(x,y,IM,'Parent',axImage);  
colormap gray

% make cross section
box2 = uiextras.BoxPanel('Parent',theGrid,...
                         'Title', [name ' profile'],...
                         'Padding',5);

axPlot = axes('Parent',box2,...
               'ActivePositionProperty',...
               'OuterPosition' );
           
plot(axPlot,x,IM(cutPoint,:));

% must be set after creation of cildren
set(theGrid, 'Sizes', [-5 -2] );

out = theGrid;
end