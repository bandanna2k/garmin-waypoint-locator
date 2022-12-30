import Toybox.Lang;
import Toybox.Test;
import Toybox.System;

module Syntax { module DesignPatterns { module Callback
{
    var _object = null;

    (:test) 
    function testCallbackDesignPattern(logger as Logger) as Boolean 
    { 
        // var listener = new MyListener();
        var sender = new MySender(new Method(self, :onEvent));

        Test.assert(_object == null);
        sender.fireEvent();
        Test.assert(_object != null);
        return true;
    } 

    function onEvent(object as MyObject) as Void
    {
        _object = object;
    }
}}} 