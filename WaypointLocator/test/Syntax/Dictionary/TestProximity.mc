import Test.Utilities.Assertions;
import Proximity;
import Toybox.Lang;
import Toybox.Test;
import Toybox.System;
import Distance;

module Test { module Dictionary
{
    (:test) 
    function testDictionary(logger as Logger) as Boolean 
    { 
        var jsonString = "{'name':'John', 'age':30, 'car':null}";
        var dictionary;
        Logging.info(dictionary);
        return true;
    }
}}