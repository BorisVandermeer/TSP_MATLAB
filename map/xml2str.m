function str=xml2str(xml,expr,i)
%��ȡxml�е����� xmlΪ�ַ�
%����ж���ƥ��Ļ� ȡ��һ��
%���û��ƥ�� ����0
    xmlmatch=regexp(xml,expr,'match');
    if(isempty(xmlmatch)==0)
        str=Lab2str(xmlmatch{i},expr);
    else
        str=strings(1);
    end
end

function str=Lab2str(lab,expr)
%��ȡlab�е�����
    s=max(size(expr));
    s=(s-4)/2;
    l=max(size(lab));
    str=lab(s+1:l-s-1);
end