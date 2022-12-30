import Toybox.Lang;
import Utilities.Test;

module Utilities { module Test { module Assertions
{
    // function doesThrow(inputMethod as Method) as Boolean
    // {
    //     var pass = false;
    //     try
    //     {
    //         inputMethod.invoke();
    //     }
    //     catch(ex instanceof Exception)
    //     {
    //         pass = true;
    //     }
    //     if(pass)
    //     {
    //         return pass;
    //     }
    //     throw new AssertionException("Method does not throw expected exception.");
    // }
    function areEqual(
        actual as Object or Null, 
        expected as Object or Null) as Boolean
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

    function areApproximatelyEquals(
        actual as Numeric, 
        expected as Numeric, 
        tolerance as Numeric) as Boolean
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

