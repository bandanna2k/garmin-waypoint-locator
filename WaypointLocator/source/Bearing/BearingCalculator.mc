import Toybox.Lang;
import Toybox.System;
import Toybox.Math;

module Bearing
{
/*
Programatically
To apply this logic to a computer program, we begin with our points:

a = {'lat': <some value>, 'lon': <some value>}
b = {'lat': <some value>, 'lon': <some value>}
Next, we find ∆L by subtracting the longitudinal value from a from b

dL = b.lon-a.lon
Now we can calculate our X and Y values:

X = cos(b.lat)* sin(dL)
Y = cos(a.lat)*sin(b.lat) - sin(a.lat)*cos(b.lat)* cos(dL)
Finally, we can take the arctan and obtain our bearing:

bearing = arctan2(X,Y)
Note: this value is in radians!

*/

    function bearing(
        positionA as Toybox.Position.Location, 
        positionB as Toybox.Position.Location) as Numeric
    {
        var deltaLong = Math.toRadians(Utilities.longitude(positionB) - Utilities.longitude(positionA));
        var latA = Math.toRadians(Utilities.latitude(positionA));
        var latB = Math.toRadians(Utilities.latitude(positionB));
        var x = Math.cos(latB) * Math.sin(deltaLong);
        var y = 
            (Math.cos(latA) * Math.sin(latB)) -
            (Math.sin(latA) * Math.cos(latB) * Math.cos(deltaLong));

        var bearing;
        bearing = Math.toDegrees(Math.atan2(x, y));
        bearing = bearing + 360;
        bearing = Utilities.mod(bearing, 360);
        // System.println("delta Long = " + deltaLong);
        // System.println("x = " + x);
        // System.println("y = " + y);
        // System.println("bearing = " + bearing);
        return bearing;
    }
}
