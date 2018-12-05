function dMdx = MUB(x,M,p)
    dMdx =[M(2) ; p.K1*M(1)/(p.K2+M(1))];
end