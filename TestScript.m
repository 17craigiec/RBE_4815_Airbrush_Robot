SHAPE_NAME = 'StarLine';
pathName = append('Geometric Shapes/', SHAPE_NAME, '/3D');

%PATH STATEMENTS
addpath('Functions', pathName);

%NOTE REMEBER TO CHANGE FILE TYPE TO .xml
modelXMLfile = '3dmodel.xml';

%modelXMLfile = '3dmodel.model';
obj = parseXML(modelXMLfile);

textureFile = append('Geometric Shapes/', SHAPE_NAME, obj.Children(2).Children(6).Attributes(3).Value );
% texture = fullfile(textureFile)



% u = obj.Children(2).Children(6).Children(2).Attributes(1).Value;
% v = obj.Children(2).Children(6).Children(2).Attributes(2).Value;

verticiesInd = length(obj.Children(2).Children) - 1;

%Gather the number of vertecies in the shape
numCycle = ( length(obj.Children(2).Children(verticiesInd).Children(2).Children(2).Children)- 1 )/2;
x = zeros(numCycle,1);
y = zeros(numCycle,1);
z = zeros(numCycle,1);

for i = 1:numCycle
    
    x(i) = str2double(obj.Children(2).Children(verticiesInd).Children(2).Children(2).Children(2*i).Attributes(1).Value);
    y(i) = str2double(obj.Children(2).Children(verticiesInd).Children(2).Children(2).Children(2*i).Attributes(2).Value);
    z(i) = str2double(obj.Children(2).Children(verticiesInd).Children(2).Children(2).Children(2*i).Attributes(3).Value);
    
    
end

rmpath(pathName);
scatter3(x,y,z,'.');
axis equal;

