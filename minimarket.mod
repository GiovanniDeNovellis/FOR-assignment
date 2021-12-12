param n;
param range;
set houses := 1..n;
param Cx{houses};
param Cy{houses};
param Dc{houses};
param usable{houses} binary;
param distance{i in houses, j in houses} :=
	sqrt((Cx[i]-Cx[j])**2 + (Cy[i]-Cy[j])**2);

var used{houses} binary;
var connected{houses, houses} binary;
var closeEnough{houses, houses} binary;


minimize obj:
	sum{house in houses}(Dc[house]*used[house]);

subject to usedIfUsable{house in houses}:
	used[house]<=usable[house];

subject to connectedClose{i in houses, j in houses}:
	connected[i,j] <= closeEnough[i,j];

subject to connectedUsed{i in houses, j in houses}:
	connected[i,j] <= used[j];

subject to closeEnoughConstraint{i in houses, j in houses}:
	closeEnough[i,j]*(range-distance[i,j])>=0;

subject to all_served{i in houses}:
	sum{j in houses} connected[i,j]>=1;


