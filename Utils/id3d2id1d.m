function id1d = id3d2id1d(ix, iy, iz, nx, ny, nz)
id1d = ix + nx * (iy - 1 + ny * ( iz - 1));
end

