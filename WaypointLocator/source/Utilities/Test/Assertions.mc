import Toybox.Lang;
import Utilities.Test.Assertions;

module Utilities { module Test { module Assertions
{
    function areEqual(actual as Object, expected as Object) as Boolean
    {
        var result = actual.toString().equals(expected.toString());
        if(result)
        {
            // Do nothing
        }
        else
        {
            throw new AssertionException("Actual: " + actual + ", Expected: " + expected);
        }
        return result;
    }

    function areApproximatelyEquals(actual as Numeric, expected as Numeric, tolerance as Numeric) as Boolean
    {
        var lower = expected - tolerance;
        if(actual < lower)
        {
            throw new AssertionException(
                "Actual (" + actual + ") is less than lower limit. " +
                "Expected (" + expected + " ± " + tolerance + ")");
        }

        var upper = expected + tolerance;
        if(actual > upper)
        {
            throw new AssertionException(
                "Actual (" + actual + ") is greater than upper limit. " +
                "Expected (" + expected + " ± " + tolerance + ")");
        }
        return true;
    }
}}}

