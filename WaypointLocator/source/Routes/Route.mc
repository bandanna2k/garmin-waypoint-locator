import Toybox.Position;
import Toybox.Lang;
import Toybox.Application;
import Waypoints;

module Routes
{
    const NULL_ROUTE = new Route("-", []); 

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

        function title() as String
        {
            return _title;
        }

        function waypoints() as Array<Waypoint>
        {
            return _waypoints;
        }

        function toString() as String
        {
            return "Title:" + _title + ", Waypoint Count:" + _waypoints.size();
        } 

        function invert()
        {
            _title = _title + " (R)";
            _waypoints = _waypoints.reverse();
        }
    }

    function isValid(route as Route) as Boolean
    {
        return route.waypoints().size() > 0;
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