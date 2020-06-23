function resultPic=myFilter(h,originalPic)
[m1,n1]=size(h);
if (m1<=1||m1~=n1||mod(m1,2)==0)        %h为维度为奇数的方阵
    error('Input h must be a odd square Matrix')
end
[m1,n1]=size(originalPic);
if (m1<=1||n1<=1)
    error('Input originalPic must be a Matrix')
end

m=length(h);
n=(m-1)/2;
[M,N]=size(originalPic);
tempPic=zeros(M+n*2,N+n*2);                        %%补零
tempPic(n+1:M+n,n+1:N+n)=originalPic;              %%填充
resultPic=zeros(M,N);                              %%临时变量
for i=(n+1):(M+n)
    for j=(n+1):(N+n)
        resultPic((i-n),(j-n))=sum(sum(h.*tempPic((i-n):(i+n),(j-n):(j+n))));%%相关运算
    end
end
resultPic=uint8(resultPic);                         %%数据转换
end