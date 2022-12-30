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

        public function position() as Position.Location
        {
            return _position;
        }

        public function title() as String
        {
            return _title;
        }
    }
}