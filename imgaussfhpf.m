%高斯高通滤波器滤镜 imgaussfhpf.m
%{
函数： function ff=imgaussfhpf(I,sigma)
函数说明：构造高斯高通滤镜
参数说明：I：输入图像
         sigma：标准差
返回值：与原图像等大的高斯高通滤镜
 
%}
 
 
function ff=imgaussfhpf(I,sigma)
[M,N]=size(I);
 ff=ones(M,N);
 for i=1:M
     for j=1:N
         ff(i,j)= 1-exp( -((i-M/2)^2+(j-N/2)^2) /2/(sigma^2) ); %  1-(gauss)
        
     end
 end
