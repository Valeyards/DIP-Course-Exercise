% Ƶ���ͨ�˲��� imidealflpf.m
%{
������    function ff=imidealflpf(I,freq)
����˵�������������Ƶ���ͨ�˲������� �˾���
����˵����I��Ϊ����ԭͼ��
         freq:Ϊ��ֹƵ��
����ֵ�� ��I�ȴ��Ƶ���˾�
 
 
%}
 
 function ff=imidealflpf(I,freq)
 
 [M,N]=size(I);
 ff=ones(M,N);
 for i=1:M
     for j=1:N
         if (sqrt ((i-M/2)^2+ (j-N/2)^2 ) >freq)  ff(i,j)=0; %���ڽ�ֹƵ�� ��Ϊ0
         end
     end
 end