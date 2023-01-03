import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Position;
import Toybox.Sensor;
import Toybox.Timer;
import Toybox.Application;
import Distance;
import Bearing;
import Waypoints;

class WaypointLocator extends Events
{
    var _waypointTracker;
    var _bearingCalculator;
    var _distanceCalculator;

    var _eventRegistry;

    function initialize(eventRegistry as EventRegistry)
    {
        Events.initialize();
        _eventRegistry = eventRegistry;
        _eventRegistry.register(self);        
        _bearingCalculator = new BearingCalculator(eventRegistry);        
        _distanceCalculator = new DistanceCalculator(eventRegistry);
        _waypointTracker = new WaypointTracker(eventRegistry);
    }

    function onStart() as Void
    {
        Waypoints.loadWaypoints(_eventRegistry);

        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
        Attention.playTone(Attention.TONE_KEY);
        
        Sensor.enableSensorEvents(method(:onSensor));

        var timer = new Timer.Timer();
        timer.start(method(:onTimer), 1000, true);
    }

    function onTimer() as Void
    {
        _eventRegistry.onPulse();
    }

    function onPosition(info as Position.Info) as Void
    {
        _eventRegistry.onCurrentPosition(info.position);
    }

    function onSensor(sensorInfo as Sensor.Info) as Void
    {
        if(sensorInfo.heading == null)
        {
            _eventRegistry.onHeading(null);
        }
        else
        {
            _eventRegistry.onHeading(Bearing.radiansToBearing(sensorInfo.heading));
        }
    }

    function waypointTracker() as WaypointTracker
    {
        return _waypointTracker;
    }
}