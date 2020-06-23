img=imread('rawdata/5.jpg');
img = imresize(img,[1200,960]);
img1=process.gray(img);
process.showhist(img);
%% ������
%% �������
% img1 = imnoise(img1,'gaussian',0,0.1); %��˹��������ֵΪ0������0.1
img1 = imnoise(img1,'salt & pepper',0.2);%�����������ܶ�Ϊ0.2
%% ��ֵ�˲�
img2=process.avgfilt(img1,3);
img3=process.avgfilt(img1,5);
img4=process.avgfilt(img1,9);
figure;
subplot(221);imshow(img1);title('ԭͼ');
subplot(222);imshow(img2);title('3x3');
subplot(223);imshow(img3);title('5x5');
subplot(224);imshow(img4);title('9x9');
%% ��ֵ�˲�
img2=process.medfilt(img1,3);
img3=process.medfilt(img1,5);
img4=process.medfilt(img1,9);
figure;
subplot(221);imshow(img1);title('ԭͼ');
subplot(222);imshow(img2);title('3x3');
subplot(223);imshow(img3);title('5x5');
subplot(224);imshow(img4);title('9x9');
%% ��Ե��ȡ
process.edge(img1);
process.edge(img2);
process.edge(img3);
process.edge(img4);

%% Ƶ����
%%�鿴Ƶ��
[M,N]=size(img1);

%% �����ͨ�˲�
I1=img1;
I=imnoise(I1,'salt & pepper');
%�����˾� (��ֹƵ��Ϊ20)
ff=imidealflpf(I,20);
%Ӧ���˾���Ƶ���˲�
out=imfreqfilt(I,ff);
%�����˾� ����ֹƵ��Ϊ40��
ff1=imidealflpf(I,40);
%Ӧ���˾���Ƶ���˲�
out1=imfreqfilt(I,ff1);
%�����˾� ����ֹƵ��Ϊ60��
ff2=imidealflpf(I,60);
%Ӧ���˾���Ƶ���˲�
out2=imfreqfilt(I,ff2);
%��ʾ�ռ���ͼ��
subplot(1,4,1);
imshow(I);
title('ԭͼ');
subplot(1,4,2);
imshow(out);
title('f=20');
subplot(1,4,3);
imshow(out1);
title('f=40');
subplot(1,4,4);
imshow(out2);
title('f=60');
 
%��ʾƵ��ͼ��(fft--fftshift--abs--log)
If=fft2(I);
If=fftshift(If);
If=abs(If);   %������
If=log(1+If); %ѹ����Χ
outf=fft2(out);
outf=fftshift(outf);
outf=abs(outf);   %������
outf=log(1+outf); %ѹ����Χ
out1f=fft2(out1);
out1f=fftshift(out1f);
out1f=abs(out1f);   %������
out1f=log(1+out1f); %ѹ����Χ
out2f=fft2(out2);
out2f=fftshift(out2f);
out2f=abs(out2f);   %������
out2f=log(1+out2f); %ѹ����Χ

figure,
subplot(1,4,1);
imshow(If,[]);
title('ԭͼ'); 
subplot(1,4,2);
imshow(outf,[]);
title('f=20');
subplot(1,4,3);
imshow(out1f,[]);
title('f=40');
subplot(1,4,4);
imshow(out2f,[]);
title('f=60');
%% ��˹��ͨ�˲�
 
I1=img1;
I=imnoise(I1,'salt & pepper');
 
%�����˾� (sigma=20)
ff=imgaussflpf(I,20);
%Ӧ���˾���Ƶ���˲�
out=imfreqfilt(I,ff);
 
 
%�����˾� ��sigma=40��
ff1=imgaussflpf(I,40);
%Ӧ���˾���Ƶ���˲�
out1=imfreqfilt(I,ff1);
 
%�����˾� ��sigma=60��
ff2=imgaussflpf(I,60);
%Ӧ���˾���Ƶ���˲�
out2=imfreqfilt(I,ff2);
 
%��ʾ�ռ���ͼ��
subplot(1,4,1);
imshow(I);
title('ԭͼ');
 
subplot(1,4,2);
imshow(out);
title('sigma=20');
 
subplot(1,4,3);
imshow(out1);
title('sigma=40');
 
subplot(1,4,4);
imshow(out2);
title('sigma=60');
 
 
%��ʾƵ��ͼ��(fft--fftshift--abs--log)
If=fft2(I);
If=fftshift(If);
If=abs(If);   %������
If=log(1+If); %ѹ����Χ
 
 
outf=fft2(out);
outf=fftshift(outf);
outf=abs(outf);   %������
outf=log(1+outf); %ѹ����Χ
 
out1f=fft2(out1);
out1f=fftshift(out1f);
out1f=abs(out1f);   %������
out1f=log(1+out1f); %ѹ����Χ
 
out2f=fft2(out2);
out2f=fftshift(out2f);
out2f=abs(out2f);   %������
out2f=log(1+out2f); %ѹ����Χ
 
figure,
subplot(1,4,1);
imshow(If,[]);
title('ԭͼ');
 
subplot(1,4,2);
imshow(outf,[]);
title('sigma=20');
 
subplot(1,4,3);
imshow(out1f,[]);
title('sigma=40');
 
subplot(1,4,4);
imshow(out2f,[]);
title('sigma=60');

%% ��˹��ͨ�˲���ȡ��Ե
 
I=img1;
 
%����RGB����ת��ΪGray
if(ndims(I)==3 && (size(I,3)==3) ) %RGBͼ��  size(I,3)��ʾI�ĵ���ά������С��ndims(I)����I��ά��
    I=rgb2gray(I);
end
 
%�����˾� (sigma=20)
ff=imgaussfhpf(I,20);
%Ӧ���˾���Ƶ���˲�
out=imfreqfilt(I,ff);
 
 
%�����˾� ��sigma=40��
ff1=imgaussfhpf(I,40);
%Ӧ���˾���Ƶ���˲�
out1=imfreqfilt(I,ff1);
 
%�����˾� ��sigma=60��
ff2=imgaussfhpf(I,60);
%Ӧ���˾���Ƶ���˲�
out2=imfreqfilt(I,ff2);
 
%��ʾ�ռ���ͼ��
subplot(1,4,1);
imshow(I);
title('ԭͼ');
 
subplot(1,4,2);
imshow(out);
title('sigma=20');
 
subplot(1,4,3);
imshow(out1);
title('sigma=40');
 
subplot(1,4,4);
imshow(out2);
title('sigma=60');
 
 
%��ʾƵ��ͼ��(fft--fftshift--abs--log)
If=fft2(I);
If=fftshift(If);
If=abs(If);   %������
If=log(1+If); %ѹ����Χ
 
 
outf=fft2(out);
outf=fftshift(outf);
outf=abs(outf);   %������
outf=log(1+outf); %ѹ����Χ
 
out1f=fft2(out1);
out1f=fftshift(out1f);
out1f=abs(out1f);   %������
out1f=log(1+out1f); %ѹ����Χ
 
out2f=fft2(out2);
out2f=fftshift(out2f);
out2f=abs(out2f);   %������
out2f=log(1+out2f); %ѹ����Χ
 
figure,
subplot(1,4,1);
imshow(If,[]);
title('ԭͼ');
 
subplot(1,4,2);
imshow(outf,[]);
title('sigma=20');
 
subplot(1,4,3);
imshow(out1f,[]);
title('sigma=40');
 
subplot(1,4,4);
imshow(out2f,[]);
title('sigma=60');

%% Laplace�˲�����ȡ��Ե 
I=img1;
 
%����RGB����ת��ΪGray
if(ndims(I)==3 && (size(I,3)==3) ) %RGBͼ��  size(I,3)��ʾI�ĵ���ά������С��ndims(I)����I��ά��
    I=rgb2gray(I);
end
 
%�����˾� 
ff=imlapf(I);
%Ӧ���˾���Ƶ���˲�
out=imfreqfilt(I,ff);
 
 
%��ʾ�ռ���ͼ��
subplot(1,2,1);
imshow(I);
title('ԭͼ');
 
subplot(1,2,2);
imshow(out);
title('laplace');
 
 
%��ʾƵ��ͼ��(fft--fftshift--abs--log)
If=fft2(I);
If=fftshift(If);
If=abs(If);   %������
If=log(1+If); %ѹ����Χ
 
 
outf=fft2(out);
outf=fftshift(outf);
outf=abs(outf);   %������
outf=log(1+outf); %ѹ����Χ
 
 
 
figure,
subplot(1,2,1);
imshow(If,[]);
title('ԭͼ');
 
subplot(1,2,2);
imshow(outf,[]);
title('laplace');
%% ��Ե��ǿ
filter = [0 -1 0; -1 4 -1; 0 -1 0]/5;
img2 = filter2(filter, img1);
xishu=0.6;
result=img1+uint8(xishu*img2);
imshowpair(result,img1,'montage');
%% �Ҷ���ֵ�ָ�
%% ֱ��ȫ����ֵ�ָ�
T=graythresh(img1);
img5=imbinarize(img1,T);
imshow(img5);
%% ��������Ӱ�����ֵ�ָ�
T=process.yuzhi(img);
figure;
sh = graythresh(gray);
bw_img = imbinarize(gray,sh);
imshow(bw_img);