#!/bin/bash
#


YEAR="1985"
MO="10"
DA="2"
HR="6"

sed -i -r "s/current_date = .*/current_date = $YEAR,$MO,$DA,$HR,0,0,/" input.nml

LON="140W"
LAT="3N"
(../common/BuildExchange.csh -140.5 -139.5 2.5 3.5)
