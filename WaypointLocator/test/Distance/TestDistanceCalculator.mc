import Utilities.Test.Assertions;
import Toybox.Position;
import Toybox.Lang;
import Toybox.Test;

module TestDistanceCalculator
{
    (:test)
    function testDistances(logger as Logger) as Boolean
    {
        return 
            testDistance(0, 0,  0, 0,  0, 0.0001) &&

            testDistance(2, 2,  1, 1,  157.4, 1) &&
            testDistance(2, 2,  1, -1,  351.9, 1) &&
            testDistance(2, 2,  -1, 1,  352.01, 1) &&
            testDistance(2, 2,  -1, -1,  472.24, 1) &&

            // testDistance(-20, 20,  10, 10,  3460.07, 1) &&
            // testDistance(-20, 20,  10, -10,  4591.72, 1) &&
            // testDistance(-20, 20,  -10, 10,  1427.43, 1) &&
            // testDistance(-20, 20,  -10, -10,  3241.62, 1) &&

            // testDistance(44, -44,  11, 11, 6402.64, 1) &&
            // testDistance(44, -44,  11, -11, 4849.65, 1) &&
            // testDistance(44, -44,  -11, 11, 8258.48, 1) &&
            // testDistance(44, -44,  -11, -11, 6972.34, 1) &&

            // testDistance(-33, -33,  51, 51,  12421.41, 1) &&
            // testDistance(-33, -33,  51, -51, 9516.09, 1) &&
            // testDistance(-33, -33,  -51, 51, 6836.75, 1) &&
            // testDistance(-33, -33,  -51, -51, 2482.12, 1) &&

            true;
    }

    function testDistance(
        aX as Numeric, aY as Numeric, 
        bX as Numeric, bY as Numeric,
        expectedDistance as Numeric, 
        tolerance as Numeric) as Boolean
    {
        return Assertions.areApproximatelyEquals(
            DistanceCalculator.distance(
            new Toybox.Position.Location({
                        :latitude => aY, 
                        :longitude => aX, 
                        :format => :degrees
                        }),
            new Toybox.Position.Location({
                        :latitude => bY, 
                        :longitude => bX, 
                        :format => :degrees
                        })                
            )
            .kilometres(), expectedDistance, tolerance);
    }
}