function audio = call4api(text)
text=urlencode(text);
%text=urlencode(text);
global url_token
if isempty(url_token)==1
    api_key='GAqks0OVj1WqvbLlC2gYb4xt';
    secret_key='5HTMc0KTqdaID1B9aClXGzoyrFpdqK0j';
    url_0 = ['https://openapi.baidu.com/oauth/2.0/token?grant_type=client_credentials&client_id=',api_key,'&client_secret=',secret_key];
    url_cont = webread(url_0);
    url_token = url_cont.access_token;
end

url='http://tsn.baidu.com/text2audio';

options = weboptions('RequestMethod', 'post');
options.Timeout =20;
m = struct;
m.tex = text;
m.lan='zh';
m.ctp=1;
m.tok=url_token;
m.cuid='hellopy123456';
data = ['tex=',m.tex,'&lan=zh','&ctp=1&per=0&pit=8&spd=8&tok=',m.tok,'&cuid=',m.cuid];
Content = webwrite(url,data,options);
audio = Content;
end




