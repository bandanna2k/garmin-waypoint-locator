import Toybox.Lang;

module Waypoints
{
    class WaypointString 
    {
        var _string = "";

        function set(value as String) as Void
        {
            _string = value;
        }

        function get() as String
        {
            return _string;
        }
    }
}