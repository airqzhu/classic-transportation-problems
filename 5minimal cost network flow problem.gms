$title minimal cost network flow problem

set i node of network /1*6/;
alias(i,j);

parameter
     destination(i) the destination of network
     origin(i) the origin of network
     intermediate(i) the intermediate node of network
table
     arc(i,j) whether the link is connected
               1  2  3  4  5  6
            1  0  1  1  1  0  0
            2  0  0  0  0  0  1
            3  0  0  0  1  0  0
            4  0  1  0  0  0  1
            5  0  0  1  1  0  1
            6  0  0  0  0  0  0     ;
table
     cap(i,j) the capacity of link
                1  2  3  4  5  6
             1  0  1  2  5  0  0
             2  0  0  0  0  0  7
             3  0  0  0  1  0  0
             4  0  2  0  0  0  5
             5  0  0  5  3  0  1
             6  0  0  0  0  0  0  ;
table
     c(i,j) the transportation cost of link
               1      2      3      4      5      6
            1  10000  300    300    500    10000  10000
            2  10000  10000  10000  10000  10000  700
            3  10000  10000  10000  100    10000  10000
            4  10000  200    10000  10000  10000  500
            5  10000  10000  500    300    10000  100
            6  10000  10000  10000  10000  10000  10000     ;
scalar s  the total volume to be transported /3/;
destination('6')=1;
origin('1')=1;
intermediate(i)=(1-destination(i))*(1-origin(i));

positive variable x(i,j) the  link volume;
variable z the total transportation cost;

equation
        obj  the objective function is to minimize the total transportation cost
        des  the destination constraint
        ori  the origin constranint
        int(i)  the intermediate nodes constraint
        lvc(i,j) link volume constraint;
obj..z=e=sum((i,j),x(i,j)*c(i,j));
des..sum(i$(arc(i,'6')>0.1),x(i,'6'))=e=s;
ori..sum(i$(arc('1',i)>0.1),x('1',i))=e=s;
int(i)$(intermediate(i)=1)..sum(j$(arc(j,i)>0.1),x(j,i))=e=sum(j$(arc(i,j)>0.1),x(i,j));
lvc(i,j)..x(i,j)=l=cap(i,j);

model MCNF /all/;
solve MCNF using lp minimizing z;
display x.l,z.l ;
