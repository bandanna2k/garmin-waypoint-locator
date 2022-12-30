import Toybox.Lang;

module Syntax { module DesignPatterns { module Events
{
    class Receiver extends MyEvents
    {
        var _object;
        var _object1;
        var _object2;

        function initialize()
        {
            MyEvents.initialize();
        }

        function onEvent1(object as MyObject)
        {
            _object = object; 
        }

        function onEvent2(object1 as MyObject, object2 as MyObject)
        {
            _object1 = object1;
            _object2 = object2;
        }
    }
}}}