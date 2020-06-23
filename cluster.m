I_rgb = imread('rawdata/1.jpg'); %��ȡ�ļ�����
%ѹ��һ��
I_rgb = imresize(I_rgb,[1200,960]);
%����ɫͼ���RGBת����lab��ɫ�ռ�
C = makecform('srgb2lab'); %����ת����ʽ
I_lab = applycform(I_rgb, C);
%����K-mean���ཫͼ��ָ��3������
ab = double(I_lab(:,:,2:3)); %ȡ��lab�ռ��a������b����
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);
nColors = 4; %�ָ���������Ϊ4
[cluster_idx,cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean','Replicates',5); %����5��
pixel_labels = reshape(cluster_idx,nrows,ncols);
figure(1);
subplot(236);
imshow(pixel_labels,[]), title('������');
%��ʾ�ָ��ĸ�������
segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);
for k = 1:nColors
color = I_rgb;
color(rgb_label ~= k) = 0;
segmented_images{k} = color;
end
figure(1);
subplot(231);
imshow(I_rgb); %��ʾԭͼ
title('ԭʼͼ��');
subplot(232),imshow(segmented_images{1}), title('�ָ�����������1');
subplot(233),imshow(segmented_images{2}), title('�ָ�����������2');
subplot(234),imshow(segmented_images{3}), title('�ָ�����������3');
subplot(235),imshow(segmented_images{4}), title('�ָ�����������4');
% r=0;g=0;b=0;
% for k=1:nColors
%     num=0;
%     for i=1:size(I_rgb,1)
%         for j=1:size(I_rgb,2)
%         if(segmented_images{k}(i,j)>0)
%             r=r+double(segmented_images{k}(i,j,1));
%             g=g+double(segmented_images{k}(i,j,2));
%             b=b+double(segmented_images{k}(i,j,3));
%             num=num+1;
%         end
%         end
%     end
%     disp(r/num);
%     disp(g/num);
%     disp(b/num);
%     disp(k);
%     r=0;g=0;b=0;
% end