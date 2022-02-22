% Solve a Pattern Recognition Problem with a Neural Network
% This script assumes these variables are defined:
%
%   x2009 - input data.
%   y2009 - target data.

x = x2009';
t = y2009';

% Choose a Training Function
% For a list of all training functions type: help nntrain
trainFcn = 'traingdx';
% Create a Pattern Recognition Network
hiddenLayerSize = 100;
net = patternnet(hiddenLayerSize, trainFcn);
net.trainParam.show = 50
net.trainParam.max_fail = 100000
net.trainParam.min_grad = 1e-100
net.trainParam.epochs = 1000000
% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 50/100;
net.divideParam.valRatio = 25/100;
net.divideParam.testRatio = 25/100;
% Train the Network
[net,tr] = train(net,x,t);
% Test the Network
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y)
tind = vec2ind(t);
yind = vec2ind(y);
percentErrors = sum(tind ~= yind)/numel(tind);

% View the Network
view(net)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotconfusion(t,y)
%figure, plotroc(t,y)
