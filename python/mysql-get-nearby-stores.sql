set @orig_lat=25.047129; set @orig_lon=121.550634; set @dist=1 * 0.71746;
set @lon1 = @orig_lon - @dist/abs(cos(radians(@orig_lat))*111.32);
set @lon2 = @orig_lon + @dist/abs(cos(radians(@orig_lat))*111.32);
set @lat1 = @orig_lat - (@dist/110.57);
set @lat2 = @orig_lat + (@dist/110.57);
SELECT name, latitude, longitude, 6371 * 2 * ASIN(SQRT( POWER(SIN((@orig_lat - abs(stores.latitude)) * pi()/180 / 2),2) + COS(@orig_lat * pi()/180 ) * COS(abs(stores.latitude) *  pi()/180) * POWER(SIN((@orig_lon - stores.longitude) *  pi()/180 / 2), 2) )) as distance FROM stores WHERE stores.longitude between @lon1 and @lon2 and stores.latitude between @lat1 and @lat2 ORDER BY distance limit 10;

CREATE PROCEDURE get_nearby_stores (IN orig_lat float, IN orig_lon float, IN dist FLOAT, IN count INT)
BEGIN
DECLARE lon1 FLOAT;
DECLARE lon2 FLOAT;
DECLARE lat1 FLOAT;
DECLARE lat2 FLOAT;
declare correct_dist float;
set correct_dist = dist * 0.71746;
set lon1 = orig_lon - correct_dist/abs(cos(radians(orig_lat))*111.32);
set lon2 = orig_lon + correct_dist/abs(cos(radians(orig_lat))*111.32);
set lat1 = orig_lat - (correct_dist/110.57);
set lat2 = orig_lat + (correct_dist/110.57);

SELECT name, latitude, longitude, 6371 * 2 * ASIN(SQRT( POWER(SIN((orig_lat - abs(stores.latitude)) * pi()/180 / 2),2) + COS(orig_lat * pi()/180 ) * COS(abs(stores.latitude) *  pi()/180) * POWER(SIN((orig_lon - stores.longitude) *  pi()/180 / 2), 2) )) as distance FROM stores WHERE stores.longitude between lon1 and lon2 and stores.latitude between lat1 and lat2 ORDER BY distance limit count;

END