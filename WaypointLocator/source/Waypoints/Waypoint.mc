import Toybox.Position;
import Toybox.Lang;
import Toybox.Application;
import Utilities;

module Waypoints
{
    class Waypoint
    {
        var _name;
        var _position;

        function initialize(
            name as String,
            position as Location)
        {
            _name = name;
            _position = position;
        }

        function position() as Location
        {
            return _position;
        }

        function name() as String
        {
            return _name;
        }

        function toString() as String
        {
            return _name + " " + Utilities.longitude(_position) + " " + Utilities.latitude(_position);
        } 
    }

    function instanceOf(data as Dictionary) as Waypoint
    {
        var title = data.get("name") as String;
        var latitude = data.get("latitude") as Numeric;
        var longitude = data.get("longitude") as Numeric;
        return new Waypoint(
            title, 
            new Location({
                :latitude => latitude, 
                :longitude => longitude, 
                :format => :degrees
            }));
    }
}