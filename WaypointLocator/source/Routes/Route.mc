import Toybox.Position;
import Toybox.Lang;
import Toybox.Application;
import Waypoints;

module Routes
{
    class Route
    {
        var _title;
        var _waypoints;

        function initialize(
            title as String,
            waypoints as Array<Waypoint>)
        {
            _title = title;
            _waypoints = waypoints;
        }

        function toString() as String
        {
            return "Title:" + _title + ", Waypoint Count:" + _waypoints.size();
        } 
    }

    function instanceOf(data as Dictionary) as Route
    {
        var title = data.get("title") as String;

        var listOfWaypoints = [] as Array<Waypoint>;
        var waypoints = data.get("waypoints") as Array;
        for(var i = 0 ; i < waypoints.size(); i++)
        {
            listOfWaypoints.add(Waypoints.instanceOf(waypoints[i]));
        }

        return new Route(title, listOfWaypoints);
    }
}