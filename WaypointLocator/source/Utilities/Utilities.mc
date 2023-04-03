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

    function min(a as Number, b as Number) as Number
    {
        if(a < b) 
        {
            return a;
        }
        return b;
    }

    function max(a as Number, b as Number) as Number
    {
        if(a > b) 
        {
            return a;
        }
        return b;
    }

    function mod(
        value as Numeric, 
        modulus as Numeric) as Numeric
    {
        // a - (b * int(a/b))
        var howMany = (value / modulus).toNumber();
        return value - (modulus * howMany);
    }

    function isEnabled(value as String or Null) as Boolean
    {
        if(value == null)
        {
            return false;
        }
        return 
            "true".equals(value) ||
            "True".equals(value) ||
            "TRUE".equals(value);
    }
}



