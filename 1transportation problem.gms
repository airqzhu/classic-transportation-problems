$Title Transportation Problem

Sets
      i  supply modes  /1*2/
      j  demand modes  /1*3/;

Parameters
      S(i)  supply of node i
            /1 10
             2 15/
      D(j)  demand of node j
            /1 9
             2 6
             3 7/;
Table  c(i,j)  transportation cost of link
                 1    2    3
            1    0.5  0.7  0.3
            2    0.2  0.9  0.4;
Variables
       x(i,j)  flow volume on the link
       z       total transportation cost;
Positive Variable x;
Equations
         cost       define objective function
         supply(i)  supply limit at i
         demand(j)  demand limit at j;
cost..       z  =e=  sum((i,j),c(i,j)*x(i,j));
supply(i)..  sum(j,x(i,j))  =l=  S(i);
demand(j)..  sum(i,x(i,j))  =g=  D(j);
Model transport/all/;
Solve transport using lp minimizing z;
Display x.l,x.m,z.l;

