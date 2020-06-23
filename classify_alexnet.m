%% ��������
trainImgs = imageDatastore('E:\Matlab2019b\mycode_new\DIP_course_design\data\train_images',... ?
    'IncludeSubfolders',true,... ?
    'LabelSource','foldernames','ReadFcn',@IMAGERESIZE);
testImgs = imageDatastore('E:\Matlab2019b\mycode_new\DIP_course_design\data\test_image','ReadFcn',@IMAGERESIZE);
numClasses = numel(categories(trainImgs.Labels));
Train_disp = countEachLabel(trainImgs);
disp(Train_disp);

%% ��ʼ����΢��alexnet
net = alexnet;
layers = net.Layers;
layers(end-2) = fullyConnectedLayer(numClasses);
layers(end) = classificationLayer;

%% ���ò���ѵ���� 
options = trainingOptions('sgdm','InitialLearnRate', 0.001);
[flowernet,info] = trainNetwork(trainImgs, layers, options);


%% ��֤׼ȷ�ʣ�û�а��б�ǩ�ķ�batch�������ˣ�
labels = classify(flowernet,testImgs);
%��train������֮���������������
%testLabels = testImgs.Labels;
accuracy = sum(labels == testLabels)/numel(labels);
disp(['accuracy:',num2str(accuracy)]); % ���Ԥ�⾫�Ƚ��



%% ����ѵ��
a=imread('rawdata/4.jpg');
b=imresize(a,[227,227]);
[label,score]= classify(flowernet,b);
imshow(a);title({['probability:',num2str(max(score))]});
xlabel(['���ࣺ',char(label)]);



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