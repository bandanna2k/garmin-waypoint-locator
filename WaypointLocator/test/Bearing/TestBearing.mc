import Utilities.Test.Assertions;
import Toybox.Position;
import Toybox.Lang;
import Toybox.Test;

module TestBearing
{
    (:test) function testNorth(logger as Logger) as Boolean { return testBearing(0, 1,  0, 2,  0, 1); }
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
        expected as Numeric, 
        tolerance as Numeric) as Boolean
    {
        return Assertions.areApproximatelyEquals(
            Bearing.calculate(
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
            expected, tolerance);
    }
}