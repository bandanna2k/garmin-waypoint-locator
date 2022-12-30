import Toybox.Lang;
import Toybox.Test;
import Toybox.System;

module Syntax { module DesignPatterns { module MultipleEvents
{
    (:test) 
    function testMultipleEventsDesignPattern(logger as Logger) as Boolean 
    { 
        var listener = new MultipleReceiver();
        var sender1 = new SenderOfEvent1(listener.Event1());
        var sender2 = new SenderOfEvent2(listener.Event2());

        Test.assert(listener._object1 == null);
        Test.assert(listener._object2 == null);
        sender1.fireEvent1();
        Test.assert(listener._object1 != null);
        Test.assert(listener._object2 == null);
        sender2.fireEvent2();
        Test.assert(listener._object1 != null);
        Test.assert(listener._object2 != null);
        return true;
    }
}}} 