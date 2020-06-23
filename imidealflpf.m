% 频域低通滤波器 imidealflpf.m
%{
函数：    function ff=imidealflpf(I,freq)
函数说明：构造理想的频域低通滤波器（即 滤镜）
参数说明：I：为输入原图像
         freq:为截止频率
返回值： 与I等大的频域滤镜
 
 
%}
 
 function ff=imidealflpf(I,freq)
 
 [M,N]=size(I);
 ff=ones(M,N);
 for i=1:M
     for j=1:N
         if (sqrt ((i-M/2)^2+ (j-N/2)^2 ) >freq)  ff(i,j)=0; %高于截止频率 设为0
         end
     end
 end