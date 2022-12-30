import Toybox.Lang;

module Syntax { module DesignPatterns { module MultipleEvents
{
    class SenderOfEvent1
    {
        var _listener;

        function initialize(listener as Event1)
        {
            _listener = listener;
        }

        function fireEvent1()
        {
            _listener.onEvent1(new MyObject("Test Multiple Events"));
        }
    }
}}}