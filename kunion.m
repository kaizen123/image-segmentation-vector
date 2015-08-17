function array=kunion(root1,root2,array)
% Kruskal union. This is the function that will perform a UNION operation
% during the implementation of Kruskal's algorithm. This is the standard
% UNION operation used by disjoint-set data structures.
% 
% 1. Compare the size of two trees.
%      Note: The size of a tree is stored in the array at the position of 
%      the root as a negative number. For example: If the second point has 
%      5 elements in its tree (including itself), then array(2)=-5.
% 
% 2. Add the smaller tree to the larger tree. Since both roots have
% negative values, by adding the two, you get an even larger negative
% number.
%      For example: Suppose there are two roots to two different trees: 2,6.
%      Assume 6 is the only element of the tree. Thus, array(2)=-5 (from above)
%      and array(6)=-1. 2 is a larger tree than 6, so the tree having a root of
%      6 will be added to the tree having a root of 2. Thus,
%      array(2)=-5+(-1)=-6.
% 
% 3. Make root of larger tree the root of smaller tree.
%  -------------------------------------------------------------------------
if array(root1)>=0 
    root1=kfind(root1,array);
end
if array(root2)>=0
    root2=kfind(root2,array);
end
% If either root1>=0 or root2>=0, then your are not looking at two roots
% and cannot perform the union.
% -------------------------------------------------------------------------
if array(root2)<array(root1)
    array(root2)=array(root2)+array(root1);
    array(root1)=root2;
    array(array==root1)=root2;
else
    array(root1)=array(root1)+array(root2);
    array(root2)=root1;
    array(array==root2)=root1;
end
    
