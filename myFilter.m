function resultPic=myFilter(h,originalPic)
[m1,n1]=size(h);
if (m1<=1||m1~=n1||mod(m1,2)==0)        %hΪά��Ϊ�����ķ���
    error('Input h must be a odd square Matrix')
end
[m1,n1]=size(originalPic);
if (m1<=1||n1<=1)
    error('Input originalPic must be a Matrix')
end

m=length(h);
n=(m-1)/2;
[M,N]=size(originalPic);
tempPic=zeros(M+n*2,N+n*2);                        %%����
tempPic(n+1:M+n,n+1:N+n)=originalPic;              %%���
resultPic=zeros(M,N);                              %%��ʱ����
for i=(n+1):(M+n)
    for j=(n+1):(N+n)
        resultPic((i-n),(j-n))=sum(sum(h.*tempPic((i-n):(i+n),(j-n):(j+n))));%%�������
    end
end
resultPic=uint8(resultPic);                         %%����ת��
end