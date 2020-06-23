classdef process
    methods (Static = true)
        %�ҶȻ�
        function a=gray(b)
            a=rgb2gray(b);
        end
        %�鿴��ͨ������ͼ����Ҷ�ֱ��ͼ
        function showhist(obj)
            figure;
            R=obj(:,:,1);
            G=obj(:,:,2);
            B=obj(:,:,3);
            %montage
            f=[R;G;B];
            subplot(321);imhist(R);title('Rͨ���Ҷ�ֱ��ͼ');
            subplot(323);imhist(G);title('Gͨ���Ҷ�ֱ��ͼ');
            subplot(325);imhist(B);title('Bͨ���Ҷ�ֱ��ͼ');
            subplot(3,2,[2,4,6]);imshow(f);title('R/G/Bͨ������');
            figure;
            R=histeq(R);
            G=histeq(G);
            B=histeq(B);
            f=[R;G;B];
            subplot(321);imhist(R);title('Rͨ���Ҷ�ֱ��ͼ(ֱ��ͼ�����)');
            subplot(323);imhist(G);title('Gͨ���Ҷ�ֱ��ͼ��ֱ��ͼ�����');
            subplot(325);imhist(B);title('Bͨ���Ҷ�ֱ��ͼ��ֱ��ͼ�����');
            subplot(3,2,[2,4,6]);imshow(f);title('R/G/Bͨ��������ֱ��ͼ�����');
        end
        function edge(obj)
            if(length(obj)>1200*960)
            obj=rgb2gray(obj);
            end
            obj1=edge(obj,'canny');
            figure;
            imshow(obj1);
        end
        function bi(obj)
            obj=rgb2gray(obj);
            
            figure;
            imshow(obj1);
        end
        function d=medfilt(x,n)
            d=x;
            [width,height]=size(x);%�õ�ͼ��ĳ��Ϳ�
            for ii=1:width-(n-1)
                for jj=1:height-(n-1)%height��ʾ�ĸ���Ϊ�������˲��ĸ�����
                    tmp1=d(ii:ii+(n-1),jj:jj+(n-1));%ȡ��Ҫ�˲���n*n�ķ���
                    tmp2=tmp1(1,:);
                    for kk=2:n
                        tmp2=[tmp2,tmp1(kk,:)];%�����е����ų�һ�з����������ֵ
                    end
                    y= median(tmp2);
                    d(ii+(n-1)/2,jj+(n-1)/2)=y;
                end
            end
        end
        function d=avgfilt(x,n)
            a(1:n,1:n)=1;   %a��n��nģ��,Ԫ��ȫ��1
            [height, width]=size(x);   %����ͼ����hight x width��,��hight>n,width>n
            x1=double(x);
            x2=x1;
            for i=1:height-n+1
                for j=1:width-n+1
                    c=x1(i:i+(n-1),j:j+(n-1)).*a; %ȡ��x1�д�(i,j)��ʼ��n��n��Ԫ����ģ�����
                    s=sum(sum(c));                 %��c�����и�Ԫ��֮��
                    x2(i+(n-1)/2,j+(n-1)/2)=s/(n*n); %����ģ�������ĸ�Ԫ�صľ�ֵ����ģ������λ�õ�Ԫ��
                end
            end
            %δ����ֵ��Ԫ��ȡԭֵ
            d=uint8(x2);
        end
        function result=yuzhi(img)
            %ʹ�ô����ֵ��ȡT0
            if length(img>1200*960)
                img = rgb2gray(img);
            end
%             T00=graythresh(img);
%             %����������������Ӱ��
              se=strel('disk',10);
%             f1=imopen(img,se);
%             T=f1+T0;
            %��ñ�任��Ч
            ft=imtophat(img,se);
            T=graythresh(ft);
            result=T;
            figure;
            imshow(imbinarize(ft,T));
        end
    end
end