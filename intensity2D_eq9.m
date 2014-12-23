function out = intensity2D_eq9(S,XLens,YLens,XDet,YDet,M,G)
    %% FIND ELEMENTS OF S TO INTEGRATE OVER
    [I, J] = find(S > mean(S(:)));    % arbitrary
    out = zeros(size(S));
    
    XG = - M * XLens;
    YG = - M * YLens;
    tic
    for jt = 1:numel(XDet)
%         XG = XDet(jt) - M * XLens;
%         YG = YDet(jt) - M * YLens;
        gLocal = G(XG + XDet(jt),YG + YDet(jt));
%         [K, L] = find(gLocal > mean(gLocal(:)));
%         integrateME = gLocal.*S;
        score = 0;

%         for kt = 1:length(K)
            for it = 1:length(I)
                 score = score + S(I(it),J(it)) * gLocal(I(it),J(it));
            end
%         end
        out(jt) = score;
        
        if (mod(jt,1000) == 1)
            display([num2str(jt) ' after ' num2str(toc)]);
        end
    end

%     imagesc(gLocal);
end