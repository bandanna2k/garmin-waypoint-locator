import Test.Utilities.Assertions;
import Bearing;
import Toybox.Position;
import Toybox.Lang;
import Toybox.Test;
import Toybox.Math;

module Test { module TestBearing
{
    (:test) function testRadiansToBearingMinus1_292497(logger as Logger) as Boolean { return testRadiansToBearing(-1.292497d, 74); }
    (:test) function testRadiansToBearingMinus2_835078(logger as Logger) as Boolean { return testRadiansToBearing(-2.835078d, 162); }
    (:test) function testRadiansToBearing2_998253(logger as Logger) as Boolean { return testRadiansToBearing(2.998253, 188); }

    (:test) function testRadiansToBearing0(logger as Logger) as Boolean { return testRadiansToBearing(0d, 0d); }
    (:test) function testRadiansToBearing45(logger as Logger) as Boolean { return testRadiansToBearing(-(Math.PI / 4), 45d); }
    (:test) function testRadiansToBearing90(logger as Logger) as Boolean { return testRadiansToBearing(-(Math.PI / 2), 90d); }
    (:test) function testRadiansToBearing180(logger as Logger) as Boolean { return testRadiansToBearing(Math.PI, 180d); }
    (:test) function testRadiansToBearing270(logger as Logger) as Boolean { return testRadiansToBearing((Math.PI / 2), 270d); }
    function testRadiansToBearing(inputInRadians as Numeric, expectedBearing as Numeric) as Boolean
    {
        return Assertions.areApproximatelyEquals(Bearing.radiansToNorthToBearingFrom0(inputInRadians), expectedBearing, 1);
    }

    (:test) function testNorth(logger as Logger) as Boolean { return testBearing(0, 1,  0, 2,  0, 1); }
    (:test) function testNorthWest(logger as Logger) as Boolean { return testBearing(0, 1,  -1, 2, 315, 1); }
    (:test) function testNorthEast(logger as Logger) as Boolean { return testBearing(0, 1,  1, 2,  45, 1); }
    (:test) function testSouth(logger as Logger) as Boolean { return testBearing(0, 2,  0, 1,  180, 1); }
    (:test) function testSouthWest(logger as Logger) as Boolean { return testBearing(0, 0,  -1, -1,  225, 1); }
    (:test) function testSouthWest2(logger as Logger) as Boolean { return testBearing(2, 2,  1, 1,  225, 1); }
    (:test) function testWest(logger as Logger) as Boolean { return testBearing(0, 0,  -1, 0,  270, 1); }
    (:test) function testKansasToStLouis(logger as Logger) as Boolean
    {
        return testBearing(
            -94.581213, 39.099912,  // Kansas City: 
            -90.200203, 38.627089,  // St Louis: 
            96.51, 1);
    }

    function testBearing(
        aX as Numeric, aY as Numeric, 
        bX as Numeric, bY as Numeric,
        expectedBearing as Numeric, 
        tolerance as Numeric) as Boolean
    {
        return Assertions.areApproximatelyEquals(
            BearingCalculator.calculate(
                new Position.Location({
                            :latitude => aY, 
                            :longitude => aX, 
                            :format => :degrees
                            }),
                new Position.Location({
                            :latitude => bY, 
                            :longitude => bX, 
                            :format => :degrees
                            })                
            ), 
            expectedBearing, tolerance);
    }
}}