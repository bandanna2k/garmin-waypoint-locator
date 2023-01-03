import Toybox.Position;
import Toybox.Lang;
import Toybox.System;
import Toybox.Math;

module Utilities
{
    function latitude(position as Location) as Numeric
    {
        return position.toDegrees()[0];
    } 

    function longitude(position as Location) as Numeric
    {
        return position.toDegrees()[1];
    } 

    function mod(
        value as Numeric, 
        modulus as Numeric) as Numeric
    {
        // a - (b * int(a/b))
        var howMany = (value / modulus).toNumber();
        return value - (modulus * howMany);
    }
}



