function out = intensity2D_eq9(S,XLens,YLens,XDet,YDet,M,G)
    %% FIND ELEMENTS OF S TO INTEGRATE OVER
    [I, J] = find(S > mean(S(:)));    % arbitrary
    out = zeros(size(S));
    
    halfSize = length(XLens(1,:))/2
    
    
    XG = - M * XLens;
    YG = - M * YLens;
    
    dx = XG(1,2) - YG(1,1);
    dx = abs(dx)

    G_ZERO = G(XG,YG);
    tic
    for jt = 1:numel(XDet)
%         XG = XDet(jt) - M * XLens;
%         YG = YDet(jt) - M * YLens;
%         gLocal = G(XG + XDet(jt),YG + YDet(jt));
        shiftVector = [XDet(jt)/dx YDet(jt)/dx];
        G_LOCAL = circshift(G_ZERO,int16(shiftVector));
%         [K, L] = find(gLocal > mean(gLocal(:)));
%         integrateME = gLocal.*S;
        score = 0;

%         for kt = 1:length(K)
            for it = 1:length(I)
                 score = score + S(I(it),J(it)) * G_LOCAL(I(it),J(it));
            end
%         end
        out(jt) = score;
        
        if (mod(jt,1000) == 1)
            display([num2str((jt-1)/1000) ' of ' ...
                    num2str(4*halfSize^2/1e3) ...
                    ' after ' num2str(toc)]);
        end
    end

%     imagesc(gLocal);
end