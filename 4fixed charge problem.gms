$title fixed charge problem

set i  the number of candidate hub /1*6/;
alias(i,j);

parameter destination(i) the destination of the network
          origin(i) the origin of the network
          intermediate(i) the intermediate nodes of network
          v(i) the capacity of each hub
          /1 5
           2 4
           3 1
           4 2
           5 3
           6 7/
          fc(i) the fixed cost for bulding hub
          /1 100
           2 700
           3 200
           4 500
           5 800
           6 300/ ;

*build network
table arc(i,j) whether the link is connected
               1  2  3  4  5  6
            1  0  1  1  1  0  0
            2  0  0  0  0  0  1
            3  0  0  0  1  0  0
            4  0  1  0  0  0  1
            5  0  0  1  1  0  1
            6  0  0  0  0  0  0     ;
table c(i,j) transportation cost of link
               1      2      3      4      5      6
            1  10000  300    300    500    10000  10000
            2  10000  10000  10000  10000  10000  700
            3  10000  10000  10000  100    10000  10000
            4  10000  200    10000  10000  10000  500
            5  10000  10000  500    300    10000  100
            6  10000  10000  10000  10000  10000  10000     ;
table cap(i,j)  the capacity of link
                1  2  3  4  5  6
             1  0  1  2  5  0  0
             2  0  0  0  0  0  7
             3  0  0  0  1  0  0
             4  0  2  0  0  0  5
             5  0  0  5  3  0  1
             6  0  0  0  0  0  0  ;

*OD
origin('1')=1;
destination('6')=1;
intermediate(i)=(1-origin(i))*(1-destination(i));

scalar s the total amount of flow /3/
       b the total budget /2000/;

positive variable x(i,j) the amount of flow on link;
binary variable y(i) whether the hub is selected or not;
variable z the total cost;

equation  obj the objective function is mimimizing total cost
          des(i) the destination constraint
          ori(i) the origin constraint
          int(i) the intermediate nodes constraint
          hc(i) the hub capacity constraint
          tb the total budget constraint
          lv(i,j) the link volume constraint;
obj..z=e=sum((i,j),x(i,j)*c(i,j))+sum(i,fc(i)*y(i));
des(i)$(destination(i)=1)..sum(j$(arc(j,i)>0.1),x(j,i))=e=s;
ori(i)$(origin(i)=1)..sum(j$(arc(i,j)>0.1),x(i,j))=e=s;
int(i)$(intermediate(i)=1)..sum(j$(arc(j,i)>0.1),x(j,i))=e=sum(j$(arc(i,j)>0.1),x(i,j));
hc(i)..sum(j$(arc(i,j)>0.1),x(i,j)) =l=y(i)*v(i);
tb..sum(i,fc(i)*y(i))=l=b;
lv(i,j)..x(i,j)=l=cap(i,j);

model FCP /all/;
solve FCP using mip minimizing z;
display x.l,y.l,z.l;
