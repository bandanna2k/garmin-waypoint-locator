import Toybox.Position;
import Toybox.Lang;
import Toybox.Application;
import Utilities;

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

    function toWaypointFromDictionary(dict as Dictionary) as Waypoint
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

    function toWaypointFromStorage(index as Number) as Waypoint
    {
        var title = Storage.getValue("waypoint." + index + ".title") as String;
        var latitude = Storage.getValue("waypoint." + index + ".latitude") as Numeric;
        var longitude = Storage.getValue("waypoint." + index + ".longitude") as Numeric;
        return new Waypoint(
            title, 
            new Location({
                :latitude => latitude, 
                :longitude => longitude, 
                :format => :degrees
            }));
    }

    function saveWaypoints(arrayOfWaypoints as Array<Waypoint>) as Void
    {
        // Clear waypoints
        var count = Storage.getValue("waypoint.count");
        if(count == null)
        {
            // Do nothing
        }
        else
        {
            for(var i = 0; i < count; i++)
            {
                Storage.deleteValue("waypoint." + i + ".title");
                Storage.deleteValue("waypoint." + i + ".latitude");
                Storage.deleteValue("waypoint." + i + ".longitude");
            }
        }

        // Save waypoints
        Storage.setValue("waypoint.count", arrayOfWaypoints.size());
        for(var i = 0; i < arrayOfWaypoints.size(); i++)
        {
            var waypoint = arrayOfWaypoints[i];
            Storage.setValue("waypoint." + i + ".title", waypoint.title());
            Storage.setValue("waypoint." + i + ".latitude", Utilities.latitude(waypoint.position()));
            Storage.setValue("waypoint." + i + ".longitude", Utilities.longitude(waypoint.position()));
        }
    }
}