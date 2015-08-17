function E=myedge(V)
%This function looks at all of the points around a given vertex to
%calculate the edge weight 
%      |ii-R-1|ii-1|ii+R-1|
%      | ii-R | ii | ii+R |
%      |ii-R+1|ii+1|ii+R+1|
% Obviously, the above, proposed algorithm breaks down when analyzing any point at a
% corner or edge. Thus, the image in question is surrounded by another
% matrix such that each pixel is essentially in the "ii position" of the
% above visual representation of the algorithm. This new augmented matrix
% is referrerd to as "aug."
[R C]=size(V);
RC=numel(V);
tag=inf;
aug=tag*ones(R+2, C+2);
aug(2:end-1, 2:end-1)=V;
shift=R+3;
index=1;
%"E" needs to be preallocated for speed. As of now, I have not derived 
%the algorithm for determining its final size, so it isn't preallocated.
for ii=1:RC
%     info=[ii shift]; %test purposes
    if aug(shift+ii+1)~=tag && ii+1<=RC
        E(index,1)=ii;
        E(index,2)=ii+1;
        E(index,3)=weight(ii,ii+1,V);
        index=index+1;
    end
     if aug(shift+ii+R-1+2)~=tag && ii+R-1<=RC
        E(index,1)=ii;
        E(index,2)=ii+R-1;
        E(index,3)=weight(ii,ii+R-1,V);
        index=index+1;
    end
    if aug(shift+ii+R+2)~=tag && ii+R<=RC
        E(index,1)=ii;
        E(index,2)=ii+R;
        E(index,3)=weight(ii,ii+R,V);
        index=index+1;
    end
    if aug(shift+ii+R+1+2)~=tag && ii+R+1<=RC
        E(index,1)=ii;
        E(index,2)=ii+R+1;
        E(index,3)=weight(ii,ii+R+1,V);
        index=index+1;
    end
    if mod(ii,R)==0 && ii<RC
        shift=shift+2;
    end
end
E=sortrows(E,3); % This sorts E by non-decreasing edge weight (i.e. sorts by column 3).
% -------------------------------------------------------------------------
% Proof that the function "sortrows" actually sorts by columns while
% keeping row information intact. Rows were compared to one another.
% ELMO(:,1:3)=E;
% ELMO(:,4:6)=sortrows(E,3);
