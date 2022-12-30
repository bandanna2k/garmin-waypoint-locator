import Toybox.Lang;

module Syntax { module DesignPatterns { module MultipleEvents
{
    class SenderOfEvent2
    {
        var _listener;

        function initialize(listener as Event2)
        {
            _listener = listener;
        }

        function fireEvent2()
        {
            _listener.onEvent2();
        }
    }
}}}