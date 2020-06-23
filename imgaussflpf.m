%高斯低通滤波器滤镜 imgaussflpf.m
%{
函数： function ff=imgaussflpf(I,sigma)
函数说明：构造高斯低通滤镜
参数说明：I：输入图像
         sigma：标准差
返回值：与原图像等大的高斯低通滤镜
 
%}
 
 
function ff=imgaussflpf(I,sigma)
[M,N]=size(I);
 ff=ones(M,N);
 for i=1:M
     for j=1:N
         ff(i,j)= exp( -((i-M/2)^2+(j-N/2)^2) /2/(sigma^2) ); %高斯函数
        
     end
 end