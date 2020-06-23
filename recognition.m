%% ��������
clear;
 original_img=imread('rawdata/12.jpg');
%original_img=rec;
original_img=imresize(original_img,[800,600]);
gray = rgb2gray(original_img);
sh = graythresh(gray);
bw_img = imbinarize(gray,sh);
imshow(bw_img);
red=original_img(:,:,1);
green=original_img(:,:,2);
blue=original_img(:,:,3);
%% ��ƹ�ҾյĴ���
figure;imshow(original_img);
temp=red-green;
flower1=imbinarize(temp);
temp=blue-green;
flower2=imbinarize(temp);
flower=(flower1+flower2);
temp=green-red;
leaf=imbinarize(temp);
%������ЩҶ�ӱȽϰ�������һЩ�ϰ�������
temp=zeros(size(gray));
for i=1:size(gray,1)
    for j=1:size(gray,2)
        if(gray(i,j)<15)
            temp(i,j)=1;
        end
    end
end
temp=logical(temp);
leaf=(leaf+temp);
% temp=zeros(size(gray));
% for i=1:size(gray,1)
%     for j=1:size(gray,2)
%         if(red(i,j)>250)
%             temp(i,j)=1;
%         end
%     end
% end
% temp=logical(temp);
% flower=temp+flower;
figure;imshow(flower);title('��');
figure;imshow(leaf);title('Ҷ');
%��̬ѧ�����õ��պϵ����򣬻���Щ�ڲ��ǰ׵����һ��
%�׶����
se = strel('disk',3);
closef = imclose(flower,se);
flower=imfill(flower,'holes');
leaf=imfill(leaf,'holes');
figure;imshow(flower);title('flower');
figure;imshow(leaf);title('leaf')
%dilatef = imdilate(closef,se);
leaf=logical(leaf-closef.*leaf);
figure;
imshow(uint8(closef).*original_img);title('��������');
figure;
subplot(131);
imshow(original_img); title('ԭͼ')
colors1=imfuse(uint8(leaf).*original_img,uint8(closef).*original_img,'ColorChannels',[1 0 2]);
result = imadd(colors1,original_img);
subplot(132);
imshow(colors1); title('�ָ�����');
subplot(133);
imshow(result); title('�����ʾ' );
%% ��������Ĵ���
figure;imshow(original_img);
temp=blue-green;
flower=imbinarize(temp);
temp=green-red;
leaf=imbinarize(temp);
temp=zeros(size(gray));
temp=logical(temp);
leaf=(leaf+temp);
flower=logical(flower+temp);
figure;
imshow(flower);
figure;
imshow(leaf);
%��̬ѧ����
se = strel('disk',9);
closef = imclose(flower,se);
closel = imclose(leaf,se);
figure;
imshow(closef);title('������');
%�׶����
flower1=logical(imfill(closef,'holes'));
leaf1=imfill(closel,'holes');
figure;
subplot(121);imshow(flower1);title('�׶����');
subplot(122);imshow(leaf1);title('�׶����');
figure;
leaf1=logical(leaf1-flower1.*leaf1);
imshowpair(flower1,leaf1);
leaf11=uint8(leaf1).*original_img;
%����Ҷ�Ӳ��ֲ���һЩ��ɫ�ģ�ͨ������ͨ��������ȡ��ֵ������Ĳ��֣�����ɫ���֡�
temp=zeros(size(gray));
for i=1:size(gray,1)
    for j=1:size(gray,2)
        %����Ҷ�Ӱ�ɫ�Ĳ��ֲ��������Լӵ�����ʹ����ʾ������
        if(leaf11(i,j)~=0)
            leaf11(i,j)=leaf11(i,j)+100;
        end
        if(leaf11(i,j,3)>200)
            leaf11(i,j,:)=0;
        end
    end
end

% %����̫��û���㵽����Ļ���
% temp=zeros(size(gray));
% for i=1:size(gray,1)
%     for j=1:size(gray,2)
%         if(gray(i,j)>250)
%             temp(i,j)=1;
%         end
%     end
% end
% temp=logical(temp);
% flower1=temp+flower1;

figure;
imshow(uint8(flower1).*original_img);title('��������');

figure;
subplot(131);
imshow(original_img);title('ԭͼ')
colors1=imfuse(leaf11,uint8(flower1).*original_img,'ColorChannels',[1 2 0]);
result = imadd(colors1,original_img);
subplot(132);
imshow(colors1);title('�ָ�����')
subplot(133);
imshow(result);title('�����ʾ')
%% ����ˮ�ٺϵĴ���
figure;imshow(original_img);
temp=blue-green;
flower1=imbinarize(temp);
temp=red-green;
flower2=imbinarize(temp);
flower=(flower1+flower2);
%��������ɫ����

%ͬ���漰������Ե��ɫ������
temp=zeros(size(gray));
for i=1:size(gray,1)
    for j=1:size(gray,2)
        if(gray(i,j)>254)
            temp(i,j)=1;
        end
    end
end
temp=logical(temp);
flower=temp+flower;
temp=green-red;
leaf1=imbinarize(temp);
temp=green-blue;
leaf2=imbinarize(temp);
leaf=logical(leaf1+leaf2);

figure;imshow(leaf);
figure;imshow(flower);

%��̬ѧ����
se = strel('disk',11);
se1 = strel('disk',2);
closef = imclose(flower,se);
closel = imclose(leaf,se);
figure;
subplot(121);imshow(closef);title('�����㻨');
subplot(122);imshow(closel);title('������Ҷ');
%�׶����
flower1=logical(imfill(closef,'holes'));
leaf1=imfill(closel,'holes');
figure;
subplot(121);imshow(flower1);title('�׶����');
subplot(122);imshow(leaf1);title('�׶����');

%�ӵ��ɫ��
flower1 = imdilate(flower1,se1);
leaf1=logical(leaf1-flower1.*leaf1);
flower11=uint8(flower1).*original_img;
leaf11=uint8(leaf1).*original_img;
%������ЩҶ�ӱȽϰ�������һЩ�ϰ�������ȥ�����ڱ�����õ��İ�ɫ����
temp=zeros(size(gray));
for i=1:size(gray,1)
    for j=1:size(gray,2)
        if(leaf11(i,j,1)>220)
            leaf11(i,j)=0;
        end
        if(gray(i,j)<10)
            leaf11(i,j)=100;
        end
    end
end

%��ͼ
figure;
subplot(131);
imshow(original_img);title('ԭͼ')
colors1=imfuse(leaf11,flower11,'ColorChannels',[1 0 2]);
result = imadd(colors1,original_img);
subplot(132);
imshow(colors1);title('�ָ�����')
subplot(133);
imshow(result);title('�����ʾ')
figure;
imshow(flower11);title('��������')