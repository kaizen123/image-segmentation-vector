function [Sfinal S I ]=main(string1, ~)
% -------------------------------------------------------------------------
%                                 Help
% -------------------------------------------------------------------------
% "string1" takes the form 'image_name.image_type'
% An example: string1='sampleimage.jpg'
% Revision History:
% Xavier Waller 3/3/2011
% Xavier Waller 7/25/2011
% -------------------------------------------------------------------------
%            Reading of the input image by Matlab
% -------------------------------------------------------------------------

% string1='bob.tif';
I=imread(string1);
  I = double(I);
% % -------------------------------------------------------------------------
% % Use GAUSSIAN filter with sigma=0.8 to remove artifacts and digitization.
% %            without affecting the image in any significant way
% % -------------------------------------------------------------------------
%   sig=0.8;
%   I = fspecial('gaussian', size(I), sig);


% -------------------------------------------------------------------------
%           Conversion of color image to intensity image
% ------------------------------------------------------------------------- 
V = round(0.299*I(:,:,1) + 0.587*I(:,:,2) + .114*I(:,:,3)); 
  V=V+1;
% -------------------------------------------------------------------------
%                                  TEST
% -------------------------------------------------------------------------
% V=255*ones(4);
% V(2:end-1,2:end-1)=zeros(2);
% V=V+1;
% -------------------------------------------------------------------------
%                       Generation of edge matrix
% -------------------------------------------------------------------------
   E=myedge(V);
  [Erow ~]=size(E);
% -------------------------------------------------------------------------
k=100; %constant for tau function.
% -------------------------------------------------------------------------
% Initialization of segementation struct
% -------------------------------------------------------------------------
  S=struct('segmentations',[]); 
  S.segmentations.S0=-1*ones(size(V));
% -------------------------------------------------------------------------
% dbstop if error
for q=1:Erow
    
        q %test. Although it is a helpful way to see that Matlab isnt frozen.
    vi=E(q,1);%ith pixel
    vj=E(q,2);%jth pixel
    w=E(q,3); %weight of qth edge
    segstring=['S.segmentations.S',num2str(q-1)];
    fcalli=['rooti=kfind(vi,',segstring,');'];
    fcallj=['rootj=kfind(vj,',segstring,');'];
    eval(fcalli),eval(fcallj)
    if rooti==rootj
        %   We are in the same component and nothing merges.
        %   Thus, the final segmentation is the same as the previous one.
        %   i.e seg_q = seg_q-1
        call=['S.segmentations.S',num2str(q),'=S.segmentations.S', num2str(q-1),';']; %generates name titles S1, S2, etc. by changing index,q, to a string
        eval(call)
        % Example: S.segmentations.S3=S.segmentations.S2 if q==3.
    else
         [int1 num1]=IntDif(V,eval(segstring),rooti);
         [int2 num2]=IntDif(V,eval(segstring),rootj);
         tau1=thresh(num1,k);
         tau2=thresh(num2,k);
         MInt=mint(int1, int2, tau1, tau2);
         if w<=MInt 
             call=['S.segmentations.S',num2str(q),'=kunion(rooti,rootj,S.segmentations.S',num2str(q-1),');'];
             eval(call)
             %   Takes the form: Snew=kunion(rooti,rootj,Sprev);
         else         
             %   Thus, the final segmentation is the same as the previous one.
             %   seg_q = seg_q-1
             call=['S.segmentations.S',num2str(q),'=S.segmentations.S', num2str(q-1),';']; %generates name titles S1, S2, etc. by changing index,q, to a string
             eval(call)        
         end
    end
%        structcall=['S.segmentations.S',num2str(q),'=Snew;']; %generates name titles S1, S2, etc. by changing index,q, to a string
%        eval(structcall)
end
       structcall2=['Sfinal=','S.segmentations.S',num2str(Erow)]; %generates name titles S1, S2, etc. by changing index,q, to a string
       eval(structcall2)
    totsegcall=[totseg
% -------------------------------------------------------------------------
%                  Adding color to the segmentations
% -------------------------------------------------------------------------
parent=find(Sfinal<0); %This will give you the indices of the parents of the components.
len=length(parent);
R=round(255*(rand(len,1)));
G=round(255*(rand(len,1)));
B=round(255*(rand(len,1)));
A=zeros(size(Sfinal));
B=A;
C=A;

for ii=1:len
   A(parent(ii))=R(ii);
   A(Sfinal==parent(ii))=R(ii);
   
   B(parent(ii))=G(ii);
   B(Sfinal==parent(ii))=G(ii);
   
   C(parent(ii))=B(ii);
   C(Sfinal==parent(ii))=B(ii);
end
I=cat(3,A,B,C)
I=uint8(I)
imshow(I)





% for ii=1:len %ii is the component you are currently looking at.
%     found=find(Sfinal==parent(ii) | Sfinal==Sfinal(parent(ii)));
%     for jj=1:numel(found)
%     if Sfinal(found(jj))==parent(ii) || Sfinal(found(jj))==Sfinal(parent(ii))
%         [a b]=ind2sub(size(Sfinal),found(jj));
%         I(a,b,1)=R(ii);
%         I(a,b,2)=G(ii);
%         I(a,b,3)=B(ii);
%     end
%     end
% end
%  I=uint8(I); % You have to convert from double to uint8 to display images
%     
% 






