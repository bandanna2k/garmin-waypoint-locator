import Utilities;
import Toybox.Test;
import Toybox.Lang;
import Toybox.Position;
import Toybox.System;

module Test { module Utilities
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

    (:test) function testMin1(logger as Logger) as Boolean { return Utilities.min(1, 2).equals(1); }
    (:test) function testMin2(logger as Logger) as Boolean { return Utilities.min(2, 1).equals(1); }
    (:test) function testMin3(logger as Logger) as Boolean { return Utilities.min(-1, -2).equals(-2); }
    (:test) function testMin4(logger as Logger) as Boolean { return Utilities.min(-2, -1).equals(-2); }
    (:test) function testMin5(logger as Logger) as Boolean { return Utilities.min(0, 0).equals(0); }

    (:test) function testMax1(logger as Logger) as Boolean { return Utilities.max(1, 2).equals(2); }
    (:test) function testMax2(logger as Logger) as Boolean { return Utilities.max(2, 1).equals(2); }
    (:test) function testMax3(logger as Logger) as Boolean { return Utilities.max(-1, -2).equals(-1); }
    (:test) function testMax4(logger as Logger) as Boolean { return Utilities.max(-2, -1).equals(-1); }
    (:test) function testMax5(logger as Logger) as Boolean { return Utilities.max(0, 0).equals(0); }

    (:test) function testMod1(logger as Logger) as Boolean { return Utilities.mod(1, 2).equals(1); }
    (:test) function testMod2(logger as Logger) as Boolean { return Utilities.mod(3, 2).equals(1); }
    (:test) function testMod3(logger as Logger) as Boolean { return Utilities.mod(-1, 2).equals(-1); }
}}
