import Toybox.Lang;
import Toybox.System;

module TestUtilities
{
    function areEquals(actual as Object, expected as Object) as Boolean
    {
        var result = actual.toString().equals(expected.toString());
        if(result)
        {
            // Do nothing
        }
        else
        {
            System.println("Actual: " + actual);
            System.println("Expected: " + expected);
        }
        return result;
    }

    function areApproximatelyEquals(actual as Numeric, expected as Numeric, tolerance as Numeric) as Boolean
    {
        var lower = expected - tolerance;
        if(actual < lower)
        {
            System.println(
                "Actual (" + actual + ") is less than lower limit. " +
                "Expected (" + expected + " ± " + tolerance + ")");
            return false;
        }

        var upper = expected + tolerance;
        if(actual > upper)
        {
            System.println(
                "Actual (" + actual + ") is greater than upper limit. " +
                "Expected (" + expected + " ± " + tolerance + ")");
            return false;
        }
        return true;
    }
}

