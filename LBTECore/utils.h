class MATARRAY4D
{
	int _na, _nx, _ny, _nz;
	double* _data;
public:
	void Set(double* sor, int na, int nx, int ny, int nz)
	{
        _na = na;
		_nx = nx;
		_ny = ny;
		_nz = nz;
		_data = sor;
	}
	double& operator()(int ia, int ix, int iy, int iz)
	{
        bool outbound = false;
        if(ia < 1 || ia > _na)
            outbound = true;
        if(ix < 1 || ix > _nx)
            outbound = true;
        if(iy < 1 || iy > _ny)
            outbound = true;
        if(iz < 1 || iz > _nz)
            outbound = true;
        if(outbound)
            mexPrintf("OutBound!\n");
		return _data[ia-1 + _na*(ix-1 + _nx * (iy-1 + _ny * (iz-1)))];
	}
};

class MATARRAY3D
{
	int _nx, _ny, _nz;
	double* _data;
public:
    void Set(double* sor, int nx, int ny, int nz)
	{
		_nx = nx;
		_ny = ny;
		_nz = nz;
		_data = sor;
	}
	double& operator()(int ix, int iy, int iz)
	{
        bool outbound = false;       
        if(ix < 1 || ix > _nx)
            outbound = true;
        if(iy < 1 || iy > _ny)
            outbound = true;
        if(iz < 1 || iz > _nz)
            outbound = true;
        if(outbound)
            mexPrintf("OutBound!\n");
		return _data[ix-1 + _nx * (iy-1 + _ny * (iz-1))];
	}
};

class MATARRAY2D
{
	int _nx, _ny;
	double* _data;
public:
	void Set(double* sor, int nx, int ny)
	{
		_nx = nx;
		_ny = ny;		
		_data = sor;
	}
	double& operator()(int ix, int iy)
	{
        bool outbound = false;
        if(ix < 1 || ix > _nx)
            outbound = true;
        if(iy < 1 || iy > _ny)
            outbound = true;
        if(outbound)
            mexPrintf("OutBound!\n");
		return _data[ix-1 + _nx * (iy-1)];
	}
};

class MATARRAY1D
{
	int _nx;
	double* _data;
public:
	void Set(double* sor, int nx)
	{
		_nx = nx;
		_data = sor;
	}
	double& operator()(int ix)
	{
        bool outbound = false;
        if(ix < 1 || ix > _nx)
            outbound = true;
        if(outbound)
            mexPrintf("OutBound!\n");
		return _data[ix-1];
	}
};

double abs(double a)
{
    return a >= 0 ? a : -a;
}