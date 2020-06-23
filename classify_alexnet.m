%% 读入数据
trainImgs = imageDatastore('E:\Matlab2019b\mycode_new\DIP_course_design\data\train_images',... ?
    'IncludeSubfolders',true,... ?
    'LabelSource','foldernames','ReadFcn',@IMAGERESIZE);
testImgs = imageDatastore('E:\Matlab2019b\mycode_new\DIP_course_design\data\test_image','ReadFcn',@IMAGERESIZE);
numClasses = numel(categories(trainImgs.Labels));
Train_disp = countEachLabel(trainImgs);
disp(Train_disp);

%% 初始化并微调alexnet
net = alexnet;
layers = net.Layers;
layers(end-2) = fullyConnectedLayer(numClasses);
layers(end) = classificationLayer;

%% 设置参数训练了 
options = trainingOptions('sgdm','InitialLearnRate', 0.001);
[flowernet,info] = trainNetwork(trainImgs, layers, options);


%% 验证准确率（没有把有标签的分batch还是算了）
labels = classify(flowernet,testImgs);
%把train分批次之后再做这个还可以
%testLabels = testImgs.Labels;
accuracy = sum(labels == testLabels)/numel(labels);
disp(['accuracy:',num2str(accuracy)]); % 输出预测精度结果



%% 单独训练
a=imread('rawdata/4.jpg');
b=imresize(a,[227,227]);
[label,score]= classify(flowernet,b);
imshow(a);title({['probability:',num2str(max(score))]});
xlabel(['种类：',char(label)]);



%% show
[labels,scores] = classify(flowernet,testImgs);
numTest = length(testImgs.Files); 
for i = 1:numTest 
    testImage = readimage(testImgs,i); 
    figure(2);
    subplot(5,4,i);
    imshow(testImage); 
    title({['predictImage: ',char(labels(i))];['probability:',num2str(max(scores(i,:)))]}); 
end 