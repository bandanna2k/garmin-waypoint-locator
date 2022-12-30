import Utilities.Test.Assertions;
import Toybox.Test;
import Toybox.Lang;
import Toybox.Position;
import Toybox.System;

module Utilities { module Test
{
    (:test) function testAreEqualNumber(logger as Logger) as Boolean { return Assertions.areEqual(1, 1); }
    (:test) function testAreEqualString(logger as Logger) as Boolean { return Assertions.areEqual("X", "X"); }
    // (:test) function testNullNotAreEqual(logger as Logger) as Boolean 
    // { 
    //     return Assertions.doesThrow(new Method(self, :assertNullAndXXX));
    // }
    // function assertNullAndXXX() as Void
    // {
    //     Assertions.areEqual(null, "XXX");
    // }
}}
