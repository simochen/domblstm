function [res, maxNum] = priMax(a,b,c)
%�����ֵʱa�����ȼ���ߣ�c�����ȼ����
    res = [-1,-1];      %����
    maxNum = a;
    if(b > maxNum)
        maxNum = b;
        res = [0,-1];   %���
    end
    if(c > maxNum)
        maxNum = c;
        res = [-1,0];   %�ϱ�
    end
end