import Toybox.Position;
import Toybox.Lang;

module Waypoints
{
    class Waypoint
    {
        var _title;
        var _position;

        function initialize(
            title as String,
            position as Position.Location)
        {
            _title = title;
            _position = position;
        }

        function position() as Position.Location
        {
            return _position;
        }

        function title() as String
        {
            return _title;
        }

        function toString() as String
        {
            return _title + " " + Utilities.longitude(_position) + " " + Utilities.latitude(_position);
        } 
    }
}