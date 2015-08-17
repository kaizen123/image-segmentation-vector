function [forest lw total]=kruskal(V,E,tag)
if nargin==1
    tag=inf;
end
%This is a standard implementation of Kruskal's algorithm.
%--------------------------------------------------------------------------
% TEST
% V=[1 2 3; 4 5 6; 7 8 9]'; %TEST
% --
% V=inf*ones(3); testing functionallity of first "if" statement
% V(6)=2;
%--------------------------------------------------------------------------

forest=-1*ones(size(V)); %current segmentation
forest(V==tag)=0;% for times when the segmentation is not rectangular in form and has to be augmented to make it square.
if nargin==1
    E=myedge(V);%
end
[Erow ~]=size(E);
total=0;
truesize=-1*length(find(V>=0 & V<=255)); %anything within 0<=x<=255 is a pixel. Otherwise, it is a filler for augmentation.

if length(find(V~=tag))<=1
    lw=0;
    return
end
        for index=1:Erow
         if kfind(E(index,1),forest)~=kfind(E(index,2),forest)
             forest=kunion(E(index,1),E(index,2),forest);
              total=total+E(index,3);
         end
          if ~~find(forest==truesize)
             lw=E(index,3);  
        % This is the largest weight used in constructing the MST.
             return
          end
        end
       

