import Toybox.Lang;
import Toybox.Test;
import Toybox.System;

module Syntax { module DesignPatterns { module Events
{
    (:test) 
    function testEventsDesignPattern(logger as Logger) as Boolean 
    { 
        var listener = new Receiver();
        var sender = new Sender(listener);

        Test.assert(listener._object == null);
        Test.assert(listener._object1 == null);
        Test.assert(listener._object2 == null);
        sender.fireEvent1();
        Test.assert(listener._object != null);
        Test.assert(listener._object1 == null);
        Test.assert(listener._object2 == null);
        sender.fireEvent2();
        Test.assert(listener._object != null);
        Test.assert(listener._object1 != null);
        Test.assert(listener._object2 != null);
        return true;
    } 
}}} 