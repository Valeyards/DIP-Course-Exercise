function output = IMAGERESIZE(input)
input = imread(input);
if numel(size(input)) == 2
    input = cat(3,input,input,input);% ���ڽ�ͼƬ��Ϊ3ͨ��
end
output = imresize(input,[227,227]);
end