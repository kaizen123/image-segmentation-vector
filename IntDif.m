function [int num]=IntDif(V,seg, root,E)
% S will eventually be replaced with a substruct that will point to the 
% appropriate  segmentation. For now, it will just represent a sample 
% segmentation.

%Internal difference needs to be zero if only one element in it because no
%weight for one pixel.
%--------------------------------------------------------------------------
% TEST
% S=[-3 -3 -3; 1 4 7; 1 4 7]; 
% S=[-3 1 9; 5 -3 1; 5 9 -3];
% root=1;
% V=[255,254,8;0,32,24;160,16,9];
%--------------------------------------------------------------------------
tag=inf;
component=seg;

if component(root)==-1
    int=0; %internal difference is zero if component has only one element.
else
component(component~=root)=0; %rewriting of component so only its elements 
                              %are being looked at and other components are 
                              %ignored.
component(root)=root;
V2=V;
V2(component==0)=tag;
[~, int]=kruskal(V2);
end
num=length(find(component~=0));
%int=maximum weight in a given component
% num is the number of elements in a component.
