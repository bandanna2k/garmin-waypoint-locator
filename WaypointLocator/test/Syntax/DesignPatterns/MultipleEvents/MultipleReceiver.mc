import Toybox.Lang;

module Syntax { module DesignPatterns { module MultipleEvents
{
    class MultipleReceiver
    {
        var _object1;
        var _object2;

        function initialize()
        {
            setReceivers();
        }

        function onEvent1(object as MyObject)
        {
            _object1 = object;
        }

        function onEvent2()
        {
            _object2 = new MyObject("Event 2");
        }




        var _myevent1;
        var _myevent2;

        function setReceivers()
        {
            _myevent1 = new Event1Receiver(self);
            _myevent2 = new Event2Receiver(self);
        }
        function Event1() { return _myevent1; }
        function Event2() { return _myevent2; }

        class Event1Receiver extends Event1
        {   
            var _receiver;
            function initialize(receiver as MultipleReceiver)
            {
                Event1.initialize();
                _receiver = receiver;
            }
            function onEvent1(object as MyObject) as Void { _receiver.onEvent1(object); }
        }
        class Event2Receiver extends Event2
        {
            var _receiver;
            function initialize(receiver as MultipleReceiver)
            {
                Event2.initialize();
                _receiver = receiver;
            }
            function onEvent2() { _receiver.onEvent2(); }
        }
    }
}}}