%laplace�˲����˾� imlapf.m
%{
������ function ff=imlapf(I)
����˵��������laplace�˾�
����˵����I������ͼ��
       
����ֵ����ԭͼ��ȴ��laplace�˾�
 
%}
 
 
function ff=imlapf(I)
[M,N]=size(I);
 ff=ones(M,N);
 for i=1:M
     for j=1:N
         ff(i,j)= -((i-M/2)^2+(j-N/2)^2) ; % 
        
     end
 end
