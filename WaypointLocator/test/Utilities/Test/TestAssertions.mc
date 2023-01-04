import Utilities.Test.Assertions;
import Toybox.Test;
import Toybox.Lang;
import Toybox.Position;
import Toybox.System;

module Utilities { module Test
{
    (:test) function testAreEqualNumber(logger as Logger) as Boolean { return Assertions.areEqual(1, 1); }
    (:test) function testAreEqualString(logger as Logger) as Boolean { return Assertions.areEqual("X", "X"); }
    (:test) function shouldThrowComparingNullAndX(logger as Logger) as Boolean 
    { 
        try
        {
            var result = Assertions.areEqual(null, "X");
            Assertions.fail("Should not get here");
            return result;
        }   
        catch(ex)
        {
            // Expected to get here
        }   
        return true;  
    }
    (:test) function shouldThrowComparingXAndNull(logger as Logger) as Boolean 
    { 
        try
        {
            var result = Assertions.areEqual("X", null);
            Assertions.fail("Should not get here");
            return result;
        }   
        catch(ex)
        {
            // Expected to get here
        }   
        return true;  
    }
}}
