#!/bin/tcsh
#

module unload netcdf-c
module load fre/bronx-20

setenv var1 $1
setenv var2 $2
setenv var3 $3
setenv var4 $4

cd INPUT

make_hgrid --grid_type simple_cartesian_grid --xbnd $var1,$var2 --ybnd $var3,$var4 --nlon 6 --nlat 6 --simple_dx 25000 --simple_dy 25000 --grid_name ocean_hgrid

make_solo_mosaic --num_tiles 1 --dir ./ --mosaic_name ocean_mosaic --tile_file ocean_hgrid.nc
make_solo_mosaic --num_tiles 1 --dir ./ --mosaic_name atmos_mosaic --tile_file ocean_hgrid.nc
make_solo_mosaic --num_tiles 1 --dir ./ --mosaic_name land_mosaic --tile_file ocean_hgrid.nc
make_solo_mosaic --num_tiles 1 --dir ./ --mosaic_name wave_mosaic --tile_file ocean_hgrid.nc

make_topog --mosaic ocean_mosaic.nc --topog_type  rectangular_basin --bottom_depth 3000

make_coupler_mosaic --atmos_mosaic atmos_mosaic.nc --land_mosaic land_mosaic.nc --ocean_mosaic ocean_mosaic.nc --ocean_topog topog.nc --mosaic_name grid_spec --check --verbose
