import Toybox.Lang;

module Syntax { module DesignPatterns { module Events
{
    class Sender
    {
        var _listener;

        function initialize(listener as MyEvents)
        {
            _listener = listener;
        }

        function fireEvent1()
        {
            _listener.onEvent1(new MyObject("Test Events"));
        }

        function fireEvent2()
        {
            _listener.onEvent2(new MyObject("Test Events 1"), new MyObject("Test Events 2"));
        }
    }
}}}