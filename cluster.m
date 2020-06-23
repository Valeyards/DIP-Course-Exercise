I_rgb = imread('rawdata/1.jpg'); %读取文件数据
%压缩一下
I_rgb = imresize(I_rgb,[1200,960]);
%将彩色图像从RGB转化到lab彩色空间
C = makecform('srgb2lab'); %设置转换格式
I_lab = applycform(I_rgb, C);
%进行K-mean聚类将图像分割成3个区域
ab = double(I_lab(:,:,2:3)); %取出lab空间的a分量和b分量
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);
nColors = 4; %分割的区域个数为4
[cluster_idx,cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean','Replicates',5); %迭代5次
pixel_labels = reshape(cluster_idx,nrows,ncols);
figure(1);
subplot(236);
imshow(pixel_labels,[]), title('聚类结果');
%显示分割后的各个区域
segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);
for k = 1:nColors
color = I_rgb;
color(rgb_label ~= k) = 0;
segmented_images{k} = color;
end
figure(1);
subplot(231);
imshow(I_rgb); %显示原图
title('原始图像');
subplot(232),imshow(segmented_images{1}), title('分割结果——区域1');
subplot(233),imshow(segmented_images{2}), title('分割结果——区域2');
subplot(234),imshow(segmented_images{3}), title('分割结果——区域3');
subplot(235),imshow(segmented_images{4}), title('分割结果——区域4');
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