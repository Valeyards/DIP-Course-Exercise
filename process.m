classdef process
    methods (Static = true)
        %灰度化
        function a=gray(b)
            a=rgb2gray(b);
        end
        %查看各通道分量图像及其灰度直方图
        function showhist(obj)
            figure;
            R=obj(:,:,1);
            G=obj(:,:,2);
            B=obj(:,:,3);
            %montage
            f=[R;G;B];
            subplot(321);imhist(R);title('R通道灰度直方图');
            subplot(323);imhist(G);title('G通道灰度直方图');
            subplot(325);imhist(B);title('B通道灰度直方图');
            subplot(3,2,[2,4,6]);imshow(f);title('R/G/B通道分量');
            figure;
            R=histeq(R);
            G=histeq(G);
            B=histeq(B);
            f=[R;G;B];
            subplot(321);imhist(R);title('R通道灰度直方图(直方图均衡后)');
            subplot(323);imhist(G);title('G通道灰度直方图（直方图均衡后）');
            subplot(325);imhist(B);title('B通道灰度直方图（直方图均衡后）');
            subplot(3,2,[2,4,6]);imshow(f);title('R/G/B通道分量（直方图均衡后）');
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
            [width,height]=size(x);%得到图像的长和宽
            for ii=1:width-(n-1)
                for jj=1:height-(n-1)%height表示的个数为可完整滤波的格子数
                    tmp1=d(ii:ii+(n-1),jj:jj+(n-1));%取出要滤波的n*n的方阵
                    tmp2=tmp1(1,:);
                    for kk=2:n
                        tmp2=[tmp2,tmp1(kk,:)];%把所有的行排成一行方便后面求中值
                    end
                    y= median(tmp2);
                    d(ii+(n-1)/2,jj+(n-1)/2)=y;
                end
            end
        end
        function d=avgfilt(x,n)
            a(1:n,1:n)=1;   %a即n×n模板,元素全是1
            [height, width]=size(x);   %输入图像是hight x width的,且hight>n,width>n
            x1=double(x);
            x2=x1;
            for i=1:height-n+1
                for j=1:width-n+1
                    c=x1(i:i+(n-1),j:j+(n-1)).*a; %取出x1中从(i,j)开始的n行n列元素与模板相乘
                    s=sum(sum(c));                 %求c矩阵中各元素之和
                    x2(i+(n-1)/2,j+(n-1)/2)=s/(n*n); %将与模板运算后的各元素的均值赋给模板中心位置的元素
                end
            end
            %未被赋值的元素取原值
            d=uint8(x2);
        end
        function result=yuzhi(img)
            %使用大津阈值获取T0
            if length(img>1200*960)
                img = rgb2gray(img);
            end
%             T00=graythresh(img);
%             %做开运算消除光照影响
              se=strel('disk',10);
%             f1=imopen(img,se);
%             T=f1+T0;
            %顶帽变换等效
            ft=imtophat(img,se);
            T=graythresh(ft);
            result=T;
            figure;
            imshow(imbinarize(ft,T));
        end
    end
end