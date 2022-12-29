import Utilities.Test.Assertions;
import Toybox.Position;
import Toybox.Lang;
import Toybox.Test;
import Toybox.System;

module TestRotate
{
    const CLOSE_TOLERANCE = 0.000001;

    (:test) function test0degrees(logger as Logger) as Boolean { return testRotate([[ 0, 1 ]], 0, [[ 0, 1 ]]); } 
    (:test) function test90degrees(logger as Logger) as Boolean { return testRotate([[ 0, 1 ]], 90, [[ -1, 0 ]]); } 
    (:test) function test180degrees(logger as Logger) as Boolean { return testRotate([[ 0, 1 ]], 180, [[ 0, -1 ]]); } 
    (:test) function test270degrees(logger as Logger) as Boolean { return testRotate([[ 0, 1 ]], 270, [[ 1, 0 ]]); } 

    (:test) function test45degrees(logger as Logger) as Boolean { return testRotate([[ 0, 1 ]], 45, [[ -0.707107, 0.707107 ]]); } 

    function testRotate(
        input as Array<Array<Numeric>>,
        bearing as Numeric,
        expected as Array<Array<Numeric>>) as Boolean
    {
        rotateAroundZeroZero(input, bearing);
        return arePointsEqual(input, expected);
    }

    function rotateAroundZeroZero(
        points as Array<Array<Numeric>>, 
        bearing as Numeric) as Void
    {
        DrawingUtilities.rotate(points, [0, 0], bearing);
    }

    function arePointsEqual(
        actual as Array<Array<Numeric>>, 
        expected as Array<Array<Numeric>>) as Boolean
    {
        var result = true;
        for(var i = 0; i < actual.size(); i++)
        {
            var actualX = actual[i][0];
            var actualY = actual[i][1];

            var expectedX = expected[i][0];
            var expectedY = expected[i][1];

            if(!Assertions.areApproximatelyEquals(actualX, expectedX, CLOSE_TOLERANCE))
            {
                System.println("Actual X " + actualX + " does not equal expected X " + expectedX + " at " + i);
                return false;
            }
            else if(!Assertions.areApproximatelyEquals(actualY, expectedY, CLOSE_TOLERANCE))
            {
                System.println("Actual Y " + actualY + " does not equal expected Y " + expectedY + " at " + i);
                return false;
            }
       }
       return true;
    }
}