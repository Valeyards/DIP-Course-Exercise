function output = IMAGERESIZE(input)
input = imread(input);
if numel(size(input)) == 2
    input = cat(3,input,input,input);% 用于将图片改为3通道
end
output = imresize(input,[227,227]);
end