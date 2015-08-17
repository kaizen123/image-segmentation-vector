function dif=dif(vi, vj, V, S);
% This function defines the differrence between two components C1 and C2,
% which are subsets of V, to be the  minimum weight edge connecting the two
% components. Since the edges are being traversed through E in a
% non-decreasing manner, if a connection exists between the two components,
% since all other edge weights after this connection will be greater
% than or equal to the current edge weight, it is safely assumed that the
% weight betweeen v1 and v2 is the minimum weight edge connecting the two
% components.
vi=4;
vj=8;
% S; %S is the current segmentation.
V=[1 2 3; 4 5 6; 7 8 9]'; %test
E=myedge(V);%test

if kfind(vi,S)~=kfind(vj, S) 
    index= E(:,1)==vi & E(:,2)==vj;
    dif=E(index,3);
else
    dif=inf;
end