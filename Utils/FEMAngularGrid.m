function scheme = FEMAngularGrid(M)
% scheme = FEMAngularGrid(level)
% scheme.order = na
% scheme.ang = angles (na-by-3)
% scheme.w = weight
% nAngles : number of angles
% angles is a nAngles-by-3 matrix of value of cosines to axies
% w is the weight matrix
nVpE = M;
nA = 6 + 12 * (nVpE - 2) + 4 * (nVpE - 2)*(nVpE - 3);
angs = zeros(nA,3);
added = zeros(nA,1);
w_p = zeros(nA, nA);
drawed = 0;
    function oi = index(i1, i2, quadrant)
        if (quadrant < 4)
            if (i1 == 0)
                oi = 0;
            else
                saved = 1 + 2 * i1 * i1 - 2 * i1;
                current = mod((quadrant*i1 + i2),(4 * i1));
                oi = saved + current;
            end;
            oi = oi + 1;
        else
            if (i1 == 0)
                oi = nA;
            elseif (i1 == nVpE - 1)
                oi = index(i1, i2, quadrant - 4);
            else
                saved = 1 + 2 * i1 * i1 - 2 * i1;
                current = mod(( 12 * i1 - quadrant * i1 - i2 - 1),(4 * i1));
                oi = nA - saved - current;
            end;
        end;
        
    end

    function DealWithTriangle(id1, id2, id3)
        s2 = norm(cross(angs(id2,:)-angs(id1,:),angs(id3,:)-angs(id1,:)));
        drawed = drawed + 1;
        w_p(id1, id1) = w_p(id1, id1) + s2 / 12;
        w_p(id2, id2) = w_p(id2, id2) + s2 / 12;
        w_p(id3, id3) = w_p(id3, id3) + s2 / 12;
        w_p(id1, id2) = w_p(id1, id2) + s2 / 24;
        w_p(id1, id3) = w_p(id1, id3) + s2 / 24;
        w_p(id2, id1) = w_p(id2, id1) + s2 / 24;
        w_p(id2, id3) = w_p(id2, id3) + s2 / 24;
        w_p(id3, id1) = w_p(id3, id1) + s2 / 24;
        w_p(id3, id2) = w_p(id3, id2) + s2 / 24;
    end

    function DealWithQuad(quadrant, polar, p0, p1)
        id = zeros(3,1);
        v = zeros(3,3);
        
        e1 = p0-polar;
        l = norm(e1);
        e1 = e1/l;
        h1 = l / (nVpE - 1);
        e2 = p1 - p0;
        l = norm(e2);
        h2 = l / (nVpE - 1);
        e2 = e2/l;
        
        for i = 0 : nVpE-2
            for j = 0:i
                v(1,:) = polar + h1*i * e1 + h2*j * e2;
                v(2,:) = v(1,:) + h1 * e1;
                v(3,:) = v(2,:) + h2 * e2;
                id(1) = index(i, j, quadrant);
                id(2) = index(i+1, j, quadrant);
                id(3) = index(i+1, j+1, quadrant);
                for k = 1 : 3
                    if (added(id(k)) == 0)
                        angs(id(k),:) = v(k,:)/norm(v(k,:));
                        added(id(k)) = 1;
                    end
                end
                DealWithTriangle(id(1), id(2), id(3));
            end
        end
        for  i = 1 : nVpE-2
            for j = 0 : i-1
                v(1,:) = polar + h1*i*e1 + h2*j+e2;
                v(2,:) = v(1,:) + h2 * e2;
                v(3,:) = v(2,:) + h1 * e1;
                id(1) = index(i, j, quadrant);
                id(2) = index(i, j+1, quadrant);
                id(3) = index(i + 1, j + 1, quadrant);
                for k = 1 : 3
                    if (added(id(k)) == 0)
                        angs(id(k),:) = v(k,:)/norm(v(k,:));
                        added(id(k)) = 1;
                    end
                end
                DealWithTriangle(id(1), id(2), id(3));
            end
        end
    end

N = [0 0 1];
S = [0 0 -1];
P = zeros(4,3);
P(1,:) = [1 0 0];
P(2,:) = [0 1 0];
P(3,:) = [-1 0 0];
P(4,:) = [0 -1 0];

for ii = 1 : 4
    DealWithQuad(ii-1, N, P(ii,:), P(mod(ii,4)+1,:));
	DealWithQuad(ii + 3, S, P(ii,:), P(mod(ii,4)+1,:));
end;

onel = ones(nA,1);
I = onel'*w_p*onel;
w_p = w_p*4*pi/I;
% w_p = w_p/4/pi;
scheme = struct;
scheme.order = nA;
scheme.ang = angs;
scheme.w = w_p;
end