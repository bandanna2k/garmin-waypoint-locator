import Toybox.Lang;
import Toybox.Position;
import Distance;
import Waypoints;
import Proximity;

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
        if(heading == null || heading != 0)
        {
            for(var i = 0; i < _listeners.size(); i++)
            {
                (_listeners as Array<Events>)[i].onHeading(heading);
            }
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

    function onStop() as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onStop();
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

    function onNextWaypoint() as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onNextWaypoint();
        }
        WatchUi.requestUpdate();
    }

    function onPreviousWaypoint() as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onPreviousWaypoint();
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

    function onWaypointCounter(
        displayIndex as Number, 
        displayCount as Number) as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onWaypointCounter(displayIndex, displayCount);
        }
    }
    function onWaypoints(arrayOfWaypoints as Array<Waypoint>) as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onWaypoints(arrayOfWaypoints);
        }
    }
    function onWaypointProximity(proximity as Proximity) as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onWaypointProximity(proximity);
        }
    }
}