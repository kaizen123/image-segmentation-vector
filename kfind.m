function set=kfind(x,forest)
% "x" is an element in the forest. "forest" is an array that has
% information about the parent-child relationships.
% Negative numbers in the forest indicate parents. Other things belong to entries with
% negative numbers. Positive numbers point to their parent. Thus an element
% with a value of 4 means that it belongs to the 4th element in the array.
% If x is not a parent, then kfind is recursively called until the parent
% is found. This serves to update all elements in such a manner that they
% point to their parents and not just roots.
% -------------------------------------------------------------------------
% TEST
% forest=[2 -4 -1 9 6 9 2 4 -5 2];
% forest=[-2 1 -1; -1 -1 -1; -1 -1 -1];
% -------------------------------------------------------------------------

if forest(x)<0
    set=x;
else
    forest(x)=kfind(forest(x),forest);
    set=forest(x);
end
