$title knapsack problem

set i the knapsacks of items /1*5/;

parameter
     u(i) the utility of iterms
     /1 6
      2 3
      3 5
      4 4
      5 6/
      c(i) the cost of items
      /1 2
       2 2
       3 6
       4 5
       5 4/;
scalar b the capacity of knapsacks /10/;

binary variable x(i) whether the iterm is selected or not;
variable z the total utility of the knapsack;

equation
        obj the total utility be maximized
        sub the capacity constrain of knapsack;
obj..z=e=sum(i,u(i)*x(i));
sub..sum(i,c(i)*x(i))=l=b;

model KP /all/;
solve KP using MIP maximizing z;
display x.l,z.l ;
