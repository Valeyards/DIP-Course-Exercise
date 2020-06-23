img=imread('rawdata/5.jpg');
img = imresize(img,[1200,960]);
img1=process.gray(img);
process.showhist(img);
%% 空域处理
%% 添加噪声
% img1 = imnoise(img1,'gaussian',0,0.1); %高斯噪声，均值为0，方差0.1
img1 = imnoise(img1,'salt & pepper',0.2);%椒盐噪声，密度为0.2
%% 均值滤波
img2=process.avgfilt(img1,3);
img3=process.avgfilt(img1,5);
img4=process.avgfilt(img1,9);
figure;
subplot(221);imshow(img1);title('原图');
subplot(222);imshow(img2);title('3x3');
subplot(223);imshow(img3);title('5x5');
subplot(224);imshow(img4);title('9x9');
%% 中值滤波
img2=process.medfilt(img1,3);
img3=process.medfilt(img1,5);
img4=process.medfilt(img1,9);
figure;
subplot(221);imshow(img1);title('原图');
subplot(222);imshow(img2);title('3x3');
subplot(223);imshow(img3);title('5x5');
subplot(224);imshow(img4);title('9x9');
%% 边缘提取
process.edge(img1);
process.edge(img2);
process.edge(img3);
process.edge(img4);

%% 频域处理
%%查看频域
[M,N]=size(img1);

%% 理想低通滤波
I1=img1;
I=imnoise(I1,'salt & pepper');
%生成滤镜 (截止频率为20)
ff=imidealflpf(I,20);
%应用滤镜，频域滤波
out=imfreqfilt(I,ff);
%生成滤镜 （截止频率为40）
ff1=imidealflpf(I,40);
%应用滤镜，频域滤波
out1=imfreqfilt(I,ff1);
%生成滤镜 （截止频率为60）
ff2=imidealflpf(I,60);
%应用滤镜，频域滤波
out2=imfreqfilt(I,ff2);
%显示空间域图像
subplot(1,4,1);
imshow(I);
title('原图');
subplot(1,4,2);
imshow(out);
title('f=20');
subplot(1,4,3);
imshow(out1);
title('f=40');
subplot(1,4,4);
imshow(out2);
title('f=60');
 
%显示频域图像(fft--fftshift--abs--log)
If=fft2(I);
If=fftshift(If);
If=abs(If);   %幅度谱
If=log(1+If); %压缩范围
outf=fft2(out);
outf=fftshift(outf);
outf=abs(outf);   %幅度谱
outf=log(1+outf); %压缩范围
out1f=fft2(out1);
out1f=fftshift(out1f);
out1f=abs(out1f);   %幅度谱
out1f=log(1+out1f); %压缩范围
out2f=fft2(out2);
out2f=fftshift(out2f);
out2f=abs(out2f);   %幅度谱
out2f=log(1+out2f); %压缩范围

figure,
subplot(1,4,1);
imshow(If,[]);
title('原图'); 
subplot(1,4,2);
imshow(outf,[]);
title('f=20');
subplot(1,4,3);
imshow(out1f,[]);
title('f=40');
subplot(1,4,4);
imshow(out2f,[]);
title('f=60');
%% 高斯低通滤波
 
I1=img1;
I=imnoise(I1,'salt & pepper');
 
%生成滤镜 (sigma=20)
ff=imgaussflpf(I,20);
%应用滤镜，频域滤波
out=imfreqfilt(I,ff);
 
 
%生成滤镜 （sigma=40）
ff1=imgaussflpf(I,40);
%应用滤镜，频域滤波
out1=imfreqfilt(I,ff1);
 
%生成滤镜 （sigma=60）
ff2=imgaussflpf(I,60);
%应用滤镜，频域滤波
out2=imfreqfilt(I,ff2);
 
%显示空间域图像
subplot(1,4,1);
imshow(I);
title('原图');
 
subplot(1,4,2);
imshow(out);
title('sigma=20');
 
subplot(1,4,3);
imshow(out1);
title('sigma=40');
 
subplot(1,4,4);
imshow(out2);
title('sigma=60');
 
 
%显示频域图像(fft--fftshift--abs--log)
If=fft2(I);
If=fftshift(If);
If=abs(If);   %幅度谱
If=log(1+If); %压缩范围
 
 
outf=fft2(out);
outf=fftshift(outf);
outf=abs(outf);   %幅度谱
outf=log(1+outf); %压缩范围
 
out1f=fft2(out1);
out1f=fftshift(out1f);
out1f=abs(out1f);   %幅度谱
out1f=log(1+out1f); %压缩范围
 
out2f=fft2(out2);
out2f=fftshift(out2f);
out2f=abs(out2f);   %幅度谱
out2f=log(1+out2f); %压缩范围
 
figure,
subplot(1,4,1);
imshow(If,[]);
title('原图');
 
subplot(1,4,2);
imshow(outf,[]);
title('sigma=20');
 
subplot(1,4,3);
imshow(out1f,[]);
title('sigma=40');
 
subplot(1,4,4);
imshow(out2f,[]);
title('sigma=60');

%% 高斯高通滤波提取边缘
 
I=img1;
 
%若是RGB，需转换为Gray
if(ndims(I)==3 && (size(I,3)==3) ) %RGB图像  size(I,3)表示I的第三维分量大小，ndims(I)代表I的维数
    I=rgb2gray(I);
end
 
%生成滤镜 (sigma=20)
ff=imgaussfhpf(I,20);
%应用滤镜，频域滤波
out=imfreqfilt(I,ff);
 
 
%生成滤镜 （sigma=40）
ff1=imgaussfhpf(I,40);
%应用滤镜，频域滤波
out1=imfreqfilt(I,ff1);
 
%生成滤镜 （sigma=60）
ff2=imgaussfhpf(I,60);
%应用滤镜，频域滤波
out2=imfreqfilt(I,ff2);
 
%显示空间域图像
subplot(1,4,1);
imshow(I);
title('原图');
 
subplot(1,4,2);
imshow(out);
title('sigma=20');
 
subplot(1,4,3);
imshow(out1);
title('sigma=40');
 
subplot(1,4,4);
imshow(out2);
title('sigma=60');
 
 
%显示频域图像(fft--fftshift--abs--log)
If=fft2(I);
If=fftshift(If);
If=abs(If);   %幅度谱
If=log(1+If); %压缩范围
 
 
outf=fft2(out);
outf=fftshift(outf);
outf=abs(outf);   %幅度谱
outf=log(1+outf); %压缩范围
 
out1f=fft2(out1);
out1f=fftshift(out1f);
out1f=abs(out1f);   %幅度谱
out1f=log(1+out1f); %压缩范围
 
out2f=fft2(out2);
out2f=fftshift(out2f);
out2f=abs(out2f);   %幅度谱
out2f=log(1+out2f); %压缩范围
 
figure,
subplot(1,4,1);
imshow(If,[]);
title('原图');
 
subplot(1,4,2);
imshow(outf,[]);
title('sigma=20');
 
subplot(1,4,3);
imshow(out1f,[]);
title('sigma=40');
 
subplot(1,4,4);
imshow(out2f,[]);
title('sigma=60');

%% Laplace滤波器提取边缘 
I=img1;
 
%若是RGB，需转换为Gray
if(ndims(I)==3 && (size(I,3)==3) ) %RGB图像  size(I,3)表示I的第三维分量大小，ndims(I)代表I的维数
    I=rgb2gray(I);
end
 
%生成滤镜 
ff=imlapf(I);
%应用滤镜，频域滤波
out=imfreqfilt(I,ff);
 
 
%显示空间域图像
subplot(1,2,1);
imshow(I);
title('原图');
 
subplot(1,2,2);
imshow(out);
title('laplace');
 
 
%显示频域图像(fft--fftshift--abs--log)
If=fft2(I);
If=fftshift(If);
If=abs(If);   %幅度谱
If=log(1+If); %压缩范围
 
 
outf=fft2(out);
outf=fftshift(outf);
outf=abs(outf);   %幅度谱
outf=log(1+outf); %压缩范围
 
 
 
figure,
subplot(1,2,1);
imshow(If,[]);
title('原图');
 
subplot(1,2,2);
imshow(outf,[]);
title('laplace');
%% 边缘增强
filter = [0 -1 0; -1 4 -1; 0 -1 0]/5;
img2 = filter2(filter, img1);
xishu=0.6;
result=img1+uint8(xishu*img2);
imshowpair(result,img1,'montage');
%% 灰度阈值分割
%% 直接全局阈值分割
T=graythresh(img1);
img5=imbinarize(img1,T);
imshow(img5);
%% 消除光照影响的阈值分割
T=process.yuzhi(img);
figure;
sh = graythresh(gray);
bw_img = imbinarize(gray,sh);
imshow(bw_img);