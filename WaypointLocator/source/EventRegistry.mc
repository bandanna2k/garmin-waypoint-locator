import Toybox.Lang;
import Toybox.Position;
import Distance;
import Waypoints;
import Proximity;
import Routes;

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

    function onWaypointBearing(bearing as Numeric or Null) as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onWaypointBearing(bearing);
        }
    }

    function onCompassHeading(heading as Numeric or Null) as Void
    {
        if(heading != null)
        {
            for(var i = 0; i < _listeners.size(); i++)
            {
                (_listeners as Array<Events>)[i].onCompassHeading(heading);
            }
        }
        WatchUi.requestUpdate();
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
        _hasStarted = true;
    }
    var _hasStarted = false;
    function hasStarted() as Boolean
    {
        return _hasStarted;
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
        WatchUi.requestUpdate();    // Show text moving
    }

    function onNextWaypoint() as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onNextWaypoint();
        }
        WatchUi.requestUpdate();    // Update waypoint text 
    }

    function onPreviousWaypoint() as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onPreviousWaypoint();
        }
        WatchUi.requestUpdate();    // Update waypoint text 
    }

    function onCurrentPosition(currentPosition as Location or Null) as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onCurrentPosition(currentPosition);
        }
//        WatchUi.requestUpdate();
    }

    function onCurrentWaypoint(waypoint as Waypoint or Null) as Void
    {
Logging.trace("EventRegistry.onCurrentWaypoint:" + waypoint);
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
    function onWaypointProximity2(proximity as Number) as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onWaypointProximity2(proximity);
        }
    }
    function onActivityInitiate() as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onActivityInitiate();
        }
    }
    function onActivityStatus(status as Number) as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onActivityStatus(status);
        }
    }
    function onMessage(message as String) as Void
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onMessage(message);
        }
    }
    function onRouteUpdate(route as Route)
    {
        for(var i = 0; i < _listeners.size(); i++)
        {
            (_listeners as Array<Events>)[i].onRouteUpdate(route);
        }
    }
}