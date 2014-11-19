covmtx = zeros(1,784);
i=0;
while i~=784
    i = i+1
    covmtx(1,i:i+15) = cov(temp(i:i+15,1));
    i = i+15;
end