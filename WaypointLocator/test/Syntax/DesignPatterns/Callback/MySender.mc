import Toybox.Lang;

module Syntax { module DesignPatterns { module Callback
{
    class MySender
    {
        var _callback;

        function initialize(callback as Method)
        {
            _callback = callback;
        }

        function fireEvent()
        {
            _callback.invoke(new MyObject("Callback"));
        }
    }
}}}