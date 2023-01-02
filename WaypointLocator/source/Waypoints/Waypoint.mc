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
            position as Location)
        {
            _title = title;
            _position = position;
        }

        function position() as Location
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

    function toWaypoint(dict as Dictionary) as Waypoint
    {
        var title = dict.get("title") as String;
        var latitude = dict.get("latitude") as Numeric;
        var longitude = dict.get("longitude") as Numeric;
        return new Waypoint(
            title, 
            new Location({
                :latitude => latitude, 
                :longitude => longitude, 
                :format => :degrees
            }));
    }
}