#!/bin/csh
# Sample OceanOnlyComp.csh . intel18 repro

set version="REPRO"
set fms_version="FMS1"
set platform="ncrc5.intel22"
set rootdir = `dirname $0`
source ${rootdir}/envs.${platform}

mkdir -p build/${platform}/ice_ocean_SIS2/${version}/
(cd build/${platform}/ice_ocean_SIS2/${version}/; rm -f path_names; \
../../../../src/mkmf/bin/list_paths -l ./ ../../../../src/MOM6/config_src/{infra/${fms_version},memory/dynamic_symmetric,drivers/FMS_cap,external} ../../../../src/SIS2/config_src/dynamic_symmetric ../../../../src/MOM6/src/{*,*/*}/ ../../../../src/{atmos_null,coupler,land_null,ice_param,icebergs,SIS2,FMS/coupler,FMS/include}/)
(cd build/${platform}/ice_ocean_SIS2/${version}/; \
../../../../src/mkmf/bin/mkmf -t ../../../../src/mkmf/templates/ncrc-intel.mk -o "-I../../fms/${version}" -p MOM6 -l "-L../../fms/${version} -lfms" -c '-DUSE_FMS2_IO -Duse_AM3_physics -D_USE_LEGACY_LAND_' path_names )
(cd build/${platform}/ice_ocean_SIS2/${version}/; make NETCDF=3 $version=1 MOM6 -j)
