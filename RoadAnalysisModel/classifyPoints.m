function classifyPoints(roadPointsOnImagePlane,actualIndices,Ct,i)
    if (~Constants.drawClassification)
        return
    end
    
    C1 = roadPointsOnImagePlane(:,:,1);
    C2 = roadPointsOnImagePlane(:,:,2);
    len = sum((sum(C2~=0,1)~=0));

    for j=1:len
        i2 = actualIndices(:,2);
        i1 = actualIndices(:,1);
        currIndex = find(i1==i2(j));
        if (size(currIndex,1)==0)
           continue
        end
        V2 = C2(:,j) - Ct(:,i);
        V1 = C1(:,currIndex) - Ct(:,i-1);
        A = [V1(1) -V2(1) ; V1(2) -V2(2) ; V1(3) -V2(3)];
        b = Ct(:,i) - Ct(:,i-1);
        a = pinv(A)*b;
        X1 = Ct(:,i-1) + a(1)*V1;
        X2 = Ct(:,i) + a(2)*V2;
        X= (X1+X2)/2;
        if (X(2) < 1.0e-05)
           plot3(X(1),X(2),X(3),'om')
        else
           plot3(X(1),X(2),X(3),'og')
        end
            %plot3( [Ct(1,1) X1(1)], [Ct(2,1)  X1(2)], [Ct(3,1)  X1(3)], '-k')
            %plot3( [Ct(1,2) X2(1)], [Ct(2,2)  X2(2)], [Ct(3,2)  X2(3)], '-k')
    end       
end

