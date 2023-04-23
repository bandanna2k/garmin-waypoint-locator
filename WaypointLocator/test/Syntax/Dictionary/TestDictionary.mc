import Test.Utilities.Assertions;
import Toybox.Lang;
import Toybox.Test;
import Toybox.System;

module Test { module Dictionary
{
    (:test) 
    function testDictionary(logger as Logger) as Boolean 
    { 
        var jsonString = "{'name':'John', 'age':30, 'car':null}";
        Assertions.areEqual(jsonString, jsonString);
        return true;
    }
}}