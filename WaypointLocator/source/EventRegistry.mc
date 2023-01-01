import Toybox.Lang;
import Toybox.Position;
import Distance;
import Waypoints;

class EventRegistry extends Events
{
    var _listeners = [] as Array<Events>;

    function initialize()
    {
        Events.initialize();
    }

    function register(listener as Events)
    {
        _listeners.add(listener);
    }

    function onBearing(bearing as Numeric or Null) as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {

            (_listeners as Array<Events>)[i].onBearing(bearing);
        }
    }

    function onHeading(heading as Numeric or Null) as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {

            (_listeners as Array<Events>)[i].onHeading(heading);
        }
    }

    function onDistance(value as DistanceValue or Null) as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onDistance(value);
        }
    }

    function onStart() as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onStart();
        }
    }

    function onPulse() as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onPulse();
        }
        WatchUi.requestUpdate();
    }

    function onCurrentPosition(currentPosition as Location or Null) as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onCurrentPosition(currentPosition);
        }
    }

    function onCurrentWaypoint(waypoint as Waypoint or Null) as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onCurrentWaypoint(waypoint);
        }
    }

    function onWaypointCounter(displayIndex as Number, displayCount as Number) as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onWaypointCounter(displayIndex, displayCount);
        }
        WatchUi.requestUpdate();
    }

}