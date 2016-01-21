#include "mex.h"
#include "utils.h"

MATARRAY4D phi, source;
MATARRAY3D phih, bx0, bx1, by0, by1, bz0, bz1;
MATARRAY2D ang;
double *phi_p, *phih_p, *ang_p, *source_p, *bx0_p, *bx1_p, *by0_p, *by1_p, *bz0_p, *bz1_p;
double sigmat;
int nx, ny, nz, na;
double hx, hy, hz;

void mexFunction(int nlhs, mxArray* plhs[], int nrhs, const mxArray *prhs[])
{
    nx = (int)mxGetScalar(mxGetField(prhs[0],0,"nx"));
    ny = (int)mxGetScalar(mxGetField(prhs[0],0,"ny"));
    nz = (int)mxGetScalar(mxGetField(prhs[0],0,"nz"));
    na = (int)mxGetScalar(mxGetField(prhs[0],0,"na"));
    hx = mxGetScalar(mxGetField(prhs[0],0,"hx"));
    hy = mxGetScalar(mxGetField(prhs[0],0,"hy"));
    hz = mxGetScalar(mxGetField(prhs[0],0,"hz"));
    sigmat = mxGetScalar(mxGetField(prhs[0],0,"sigmat"));
    
    
    phi_p = mxGetPr(prhs[1]);
    source_p = mxGetPr(prhs[2]);
    ang_p = mxGetPr(prhs[3]);
    bx0_p = mxGetPr(prhs[4]);
    bx1_p = mxGetPr(prhs[5]);
    by0_p = mxGetPr(prhs[6]);
    by1_p = mxGetPr(prhs[7]);
    bz0_p = mxGetPr(prhs[8]);
    bz1_p = mxGetPr(prhs[9]);
    
    phih_p = new double[(2*nx+1)*(2*ny+1)*(2*nz+1)];
    
    phi.Set(phi_p,na,nx,ny,nz);
    phih.Set(phih_p,2*nx+1,2*ny+1,2*nz+1);
    source.Set(source_p,na,nx,ny,nz);
    ang.Set(ang_p,3,na);
    
    bx0.Set(bx0_p,na,ny,nz);
    bx1.Set(bx1_p,na,ny,nz);
    by0.Set(by0_p,na,nz,nx);
    by1.Set(by1_p,na,nz,nx);
    bz0.Set(bz0_p,na,nx,ny);
    bz1.Set(bz1_p,na,nx,ny);
    
    for(int ia = 1; ia <= na; ++ia)
    {
        double para1, para2, para3;
        para1 = abs(ang(1,ia)*2/hx);
        para2 = abs(ang(2,ia)*2/hy);
        para3 = abs(ang(3,ia)*2/hz);
        int s[3], h[3], t[3];
        int n[3];
        n[0] = nx; n[1] = ny; n[2] = nz;
        for(int i = 0; i < 3; ++i){
            if (ang(i+1,ia) >= 0){
                s[i] = 1; h[i] = 1; t[i] = n[i];
            }else{
                s[i] = n[i]; h[i] = -1; t[i] = 1;
            }
        }
        for(int i = 0; i < (2*nx+1)*(2*ny+1)*(2*nz+1); ++i)
            phih_p[i] = 0.0;
        for(int ix = 1; ix <= nx; ix++)
            for(int iy = 1; iy <= ny; iy++)
            {                
                phih(2*ix,2*iy,1) = bz0(ia, ix, iy);
                phih(2*ix,2*iy,2*nz+1) = bz1(ia, ix, iy);                
            }
        for(int iz = 1; iz <= nz; iz++)
            for(int iy = 1; iy <= ny; iy++)
            {                
                phih(1,2*iy,2*iz) = bx0(ia,iy,iz);
                phih(2*nx+1,2*iy,2*iz) = bx1(ia,iy,iz);                
            }
        for(int ix = 1; ix <= nx; ix++)
            for(int iz = 1; iz <= nz; iz++)
            {
                phih(2*ix,1,2*iz) = by0(ia,iz,ix);
                phih(2*ix,2*ny+1,2*iz) = by1(ia,iz,ix);                
            }
        for(int ix = s[0]; ix != t[0]+h[0]; ix += h[0])
            for(int iy = s[1]; iy != t[1]+h[1]; iy += h[1])
                for(int iz = s[2]; iz != t[2]+h[2]; iz += h[2])
                {
                    int ixh = 2*ix;
                    int iyh = 2*iy;
                    int izh = 2*iz;
                    double phixpre = phih(ixh-h[0],iyh,izh);
                    double phiypre = phih(ixh,iyh-h[1],izh);
                    double phizpre = phih(ixh,iyh,izh-h[2]);
                    double phinow = (phixpre*para1+phiypre*para2+phizpre*para3+source(ia,ix,iy,iz))/(para1+para2+para3+sigmat);
                    phi(ia,ix,iy,iz) = phinow;
                    phih(ixh+h[0],iyh,izh) = 2 * phinow - phixpre;
                    phih(ixh,iyh+h[1],izh) = 2 * phinow - phiypre;
                    phih(ixh,iyh,izh+h[2]) = 2 * phinow - phizpre;
                }
    }
    
    delete[] phih_p;
}