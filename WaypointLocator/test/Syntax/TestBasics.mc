import Test.Utilities.Assertions;
import Toybox.Lang;
import Toybox.Test;

module Test { module Basics
{
    (:test) 
    function testConvertStringNumericToNumeric(logger as Logger) as Boolean 
    { 
        var twoAsString = "2";
        var twoAsNumeric = twoAsString.toLong();
        Assertions.areEqual(twoAsNumeric * twoAsNumeric, 4);
        return true;
    }
}}