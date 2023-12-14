#!/bin/bash
#


YEAR="1985"
MO="10"
DA="2"
HR="6"

JRA_dataset="/lustre/f2/pdata/gfdl/gfdl_O/datasets/reanalysis/JRA55-do/v1.5.0/padded"

sed -i -r "s/current_date = .*/current_date = $YEAR,$MO,$DA,$HR,0,0,/" input.nml

cd INPUT
for FNAME in 'friver' 'licalvf'
do
    if [ -f JRA_${FNAME}.nc ]; then
	rm JRA_${FNAME}.nc
    fi
    ln -s ${JRA_dataset}/${FNAME}_input4MIPs_atmosphericState_OMIP_MRI-JRA55-do-1-5-0_gr_${YEAR}0101-${YEAR}1231.padded.nc JRA_${FNAME}.nc
done

for FNAME in 'huss' 'psl' 'tas' 'uas' 'vas'
do
    if [ -f JRA_${FNAME}.nc ]; then
	rm JRA_${FNAME}.nc
    fi
    ln -s ${JRA_dataset}/${FNAME}_input4MIPs_atmosphericState_OMIP_MRI-JRA55-do-1-5-0_gr_${YEAR}01010000-${YEAR}12312100.padded.nc JRA_${FNAME}.nc
done

for FNAME in 'prra' 'prsn' 'rlds' 'rsds'
do
    if [ -f JRA_${FNAME}.nc ]; then
	rm JRA_${FNAME}.nc
    fi
    ln -s ${JRA_dataset}/${FNAME}_input4MIPs_atmosphericState_OMIP_MRI-JRA55-do-1-5-0_gr_${YEAR}01010130-${YEAR}12312230.padded.nc JRA_${FNAME}.nc
done
cd ..

LON="140W"
LAT="3N"
(../common/BuildExchange.csh -140.5 -139.5 2.5 3.5)
