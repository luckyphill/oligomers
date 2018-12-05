% Testing to make sure vectorised is correct compared to full looped
clear all
x = 1;
p.n = 30;
p.q = 4;
p.K1 = 1; p.K2 =1; p.K6 = 1;

M = [1:p.n, 101:(100+p.n)]';

nonv = MnUBacmb(x,M,p);
yesv = MnUBacmb2(x,M,p);

nonv-yesv

norm(nonv-yesv)