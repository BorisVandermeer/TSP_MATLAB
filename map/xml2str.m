function str=xml2str(xml,expr,i)
%提取xml中的数据 xml为字符
%如果有多项匹配的话 取第一项
%如果没有匹配 返回0
    xmlmatch=regexp(xml,expr,'match');
    if(isempty(xmlmatch)==0)
        str=Lab2str(xmlmatch{i},expr);
    else
        str=strings(1);
    end
end

function str=Lab2str(lab,expr)
%提取lab中的数据
    s=max(size(expr));
    s=(s-4)/2;
    l=max(size(lab));
    str=lab(s+1:l-s-1);
end