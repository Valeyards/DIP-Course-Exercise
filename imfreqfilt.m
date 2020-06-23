%% imfreqfilt.m
%{
������  function out=imfreqfilt(I,ff)
����˵����Ƶ���˲�����
����˵����I:����ԭͼ�񣨿ռ���ͼ��
         ff:Ƶ���˾�����С��ԭͼ����ȣ�
����ֵ�� �˲���ͼ�񣨿ռ���ͼ��
 
ע�⣺
       1�� �����ͼ��ӦΪ������Ŀ���ͼ�����ֵҲΪ����ͼ��
       2�� ��Ȼ���������Ϊ����ͼ����Ϊ�ν�Ƶ���˲���
          ��Ƶ���˲�����˵�˲���������Ƶ����У�������Ǿ���IFFT���任�ؿռ����ˣ������㿴����Ƶ������̡�
              �����ˣ�Ҫ���ֱ��󱳺�Ļ���������
%}
 
function out=imfreqfilt(I,ff)
 
%����RGB����ת��ΪGray
if(ndims(I)==3 && (size(I,3)==3) ) %RGBͼ��  size(I,3)��ʾI�ĵ���ά������С��ndims(I)����I��ά��
    I=rgb2fray(I);
end
 
%�������
if( size(I) ~=size(ff) )  % ��~=�������ں�
   msg1=sprintf('%s:�˾���ԭͼ�񲻵ȴ���������',mfilename);  % mfilename: File name of currently running code
   msg2=sprintf('%s:�˾������Ѿ�ȡ��',mfilename);
   eid=sprintf('Image:%s: ImgSizeNotEqual',mfilename);
   error(eid,'%s %s',msg1,msg2);
end
 
 
%����FFT
I1=fft2(I);
I1=fftshift(I1); % ��ԭ���ƶ���Ƶ������
 
%Ӧ���˾������任
G=I1.*ff;  % ��ӦԪ�����ʵ���˲��� Ƶ����� I(u,v)H(u,v)
G=ifftshift(G); %��ԭ���Ƶ�������ƻ�ԭλ
out=ifft2(G); % IFFT�ÿռ�����
 
%�����
out=abs(out);
 
%��һ���Ա���ʾ
out=out/(max(out(:)) );