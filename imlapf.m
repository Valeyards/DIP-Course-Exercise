%laplace滤波器滤镜 imlapf.m
%{
函数： function ff=imlapf(I)
函数说明：构造laplace滤镜
参数说明：I：输入图像
       
返回值：与原图像等大的laplace滤镜
 
%}
 
 
function ff=imlapf(I)
[M,N]=size(I);
 ff=ones(M,N);
 for i=1:M
     for j=1:N
         ff(i,j)= -((i-M/2)^2+(j-N/2)^2) ; % 
        
     end
 end
