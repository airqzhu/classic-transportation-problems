$title shortest path problem

set i nodes /1*6/;
alias(i,j);

parameter
        origin(i)          origin of network
        destination(i)     destination of network
        intermediate(i)    intermediate point of the network

*buld network
 table arc(i,j) 'whether arc(i,j) is connected'
         1  2  3  4  5  6
      1  0  1  1  1  0  0
      2  0  0  0  0  0  1
      3  0  0  0  1  0  0
      4  0  1  0  0  0  1
      5  0  0  1  1  0  1
      6  0  0  0  0  0  0     ;
table c(i,j) the cost of a link
         1  2  3  4  5  6
      1  0  3  2  5  0  0
      2  0  0  0  0  0  7
      3  0  0  0  1  0  0
      4  0  2  0  0  0  5
      5  0  0  5  3  0  1
      6  0  0  0  0  0  0  ;

origin('1')=1;
destination('6')=1;
intermediate(i)=(1-origin(i))*(1-destination(i));

binary variable
               x(i,j) whether the flow passes;
variable       z      total cost ;

equation obj     the objective function
         des_con the constrain from destination
         ori_con the constrain from origin
         int_con(i) the constrain from intermidiate nodes  ;
obj..  z=e=sum((i,j),x(i,j)*c(i,j));
des_con.. sum((i)$(arc(i,'6')>0.1),x(i,'6'))=e=1 ;
ori_con.. sum((i)$(arc('1',i)>0.1),x('1',i))=e=1;
int_con(i)$(intermediate(i)=1)..sum((j)$(arc(j,i)>0.1),x(j,i))=e=sum((j)$(arc(i,j)>0.1),x(i,j));

model SPP /all/;
solve SPP using MIP minimizing z;
display x.l,z.l;
