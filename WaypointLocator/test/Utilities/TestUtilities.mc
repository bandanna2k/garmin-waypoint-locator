import Utilities.Test.Assertions;
import Toybox.Test;
import Toybox.Lang;
import Toybox.Position;
import Toybox.System;

module Utilities
{
    (:test)
    function testLatitude(logger as Logger) as Boolean
    {
        return Assertions.areEqual(
            Utilities.latitude(testPosition()), -36.901801);
    }

    (:test)
    function testLongitude(logger as Logger) as Boolean
    {
        return Assertions.areEqual(
            Utilities.longitude(testPosition()), 174.786346d);
    }

    function testPosition() as Toybox.Position.Location
    {
        return new Toybox.Position.Location({
                    :latitude => -36.901801, 
                    :longitude => 174.786346, 
                    :format => :degrees
                    });
    }

    (:test) function testMod1(logger as Logger) as Boolean { return Utilities.mod(1, 2).equals(1); }
    (:test) function testMod2(logger as Logger) as Boolean { return Utilities.mod(3, 2).equals(1); }
    (:test) function testMod3(logger as Logger) as Boolean { return Utilities.mod(-1, 2).equals(-1); }
}
