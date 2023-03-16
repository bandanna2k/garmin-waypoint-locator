import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Position;
import Toybox.Sensor;
import Toybox.Timer;
import Toybox.Application;
import Distance;
import Bearing;
import Waypoints;
import Proximity;

class WaypointLocator extends Events
{
    var _timer;
    var _eventRegistry;

    function initialize(eventRegistry as EventRegistry)
    {
        Events.initialize();
        _eventRegistry = eventRegistry;
        _eventRegistry.register(self);        
        new WaypointTracker(eventRegistry);
        new BearingCalculator(eventRegistry);        
        new DistanceCalculator(eventRegistry);
        new ProximityCalculator(eventRegistry);
        new AutoNextWaypoint(eventRegistry);
        new ProximityAlarm(eventRegistry);
    }

    function onStart() as Void
    {
Toybox.System.println("WaypointLocator.onStart");
        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
        
        Sensor.enableSensorEvents(method(:onSensor));

        Attention.playTone(Attention.TONE_KEY);

        _timer = new Timer.Timer();
        _timer.start(method(:onTimer), 1000, true);
    }

    function onStop() as Void
    {
Toybox.System.println("WaypointLocator.onStop");
        _timer.stop();
        _timer = null;
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
            _eventRegistry.onCompassHeading(null);
        }
        else
        {
            _eventRegistry.onCompassHeading(Bearing.radiansToNorthToBearingFrom0(sensorInfo.heading));
        }
    }
}