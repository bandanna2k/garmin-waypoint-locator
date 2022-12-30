import Utilities.Test.Assertions;
import Toybox.Position;
import Toybox.Lang;
import Toybox.Test;
import Toybox.System;

module Utilities { module Text
{
    (:test) 
    function testStringThatIsLonger(logger as Logger) as Boolean 
    { 
        var cyclicString = new CyclicString("0123456789", 9);
        Assertions.areEqual(cyclicString.get(), "012345678");
        cyclicString.cycle();
        Assertions.areEqual(cyclicString.get(), "123456789");
        cyclicString.cycle();
        Assertions.areEqual(cyclicString.get(), "012345678");
        cyclicString.cycle();
        Assertions.areEqual(cyclicString.get(), "123456789");
        return true;
    } 

    (:test) 
    function testStringThatIsShorter(logger as Logger) as Boolean 
    { 
        var cyclicString = new CyclicString("0123456789", 11);
        Assertions.areEqual(cyclicString.get(), "0123456789");
        cyclicString.cycle();
        Assertions.areEqual(cyclicString.get(), "0123456789");
        cyclicString.cycle();
        Assertions.areEqual(cyclicString.get(), "0123456789");
        return true;
    } 
}}