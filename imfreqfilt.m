%% imfreqfilt.m
%{
函数：  function out=imfreqfilt(I,ff)
函数说明：频域滤波函数
参数说明：I:输入原图像（空间域图像）
         ff:频域滤镜（大小与原图像相等）
返回值： 滤波后图像（空间域图像）
 
注意：
       1、 输入的图像应为待处理的空域图像，输出值也为空域图像
       2、 既然输入输出都为空域图像，那为何叫频域滤波？
          答：频域滤波，是说滤波过程是在频域进行，但结果是经过IFFT反变换回空间域了，所以你看不到频域处理过程。
              年轻人，要发现表象背后的机理啊哈哈哈
%}
 
function out=imfreqfilt(I,ff)
 
%若是RGB，需转换为Gray
if(ndims(I)==3 && (size(I,3)==3) ) %RGB图像  size(I,3)表示I的第三维分量大小，ndims(I)代表I的维数
    I=rgb2fray(I);
end
 
%检查输入
if( size(I) ~=size(ff) )  % ‘~=’不等于号
   msg1=sprintf('%s:滤镜与原图像不等大，请检查输入',mfilename);  % mfilename: File name of currently running code
   msg2=sprintf('%s:滤镜操作已经取消',mfilename);
   eid=sprintf('Image:%s: ImgSizeNotEqual',mfilename);
   error(eid,'%s %s',msg1,msg2);
end
 
 
%快速FFT
I1=fft2(I);
I1=fftshift(I1); % 将原点移动到频率中心
 
%应用滤镜及反变换
G=I1.*ff;  % 对应元素相乘实现滤波。 频域相乘 I(u,v)H(u,v)
G=ifftshift(G); %将原点从频率中心移回原位
out=ifft2(G); % IFFT得空间域函数
 
%求幅度
out=abs(out);
 
%归一化以便显示
out=out/(max(out(:)) );