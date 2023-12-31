import Toybox.Lang;
import Toybox.Math;
import Toybox.Position;
import Waypoints;

module Bearing
{
/*
Programatically
To apply this logic to a computer program, we begin with our points:

a = {'lat': <some value>, 'lon': <some value>}
b = {'lat': <some value>, 'lon': <some value>}
Next, we find ∆L by subtracting the longitudinal value from a from b

dL = b.lon-a.lon
Now we can calculate our X and Y values:

X = cos(b.lat)* sin(dL)
Y = cos(a.lat)*sin(b.lat) - sin(a.lat)*cos(b.lat)* cos(dL)
Finally, we can take the arctan and obtain our bearing:

bearing = arctan2(X,Y)
Note: this value is in radians!

*/
    class BearingCalculator extends Events
    {
        var _eventRegistry;
        var _currentWaypoint;
        var _currentPosition;

        function initialize(eventRegistry as EventRegistry)
        {
            Events.initialize();
            _eventRegistry = eventRegistry;
            _eventRegistry.register(self);
        }

        function onCurrentWaypoint(currentWaypoint as Waypoint or Null) as Void
        {
            _currentWaypoint = currentWaypoint;
            calculateBearing();
        }
        function onCurrentPosition(currentPosition as Location or Null) as Void
        {
            _currentPosition = currentPosition;
            calculateBearing();
        }
        function calculateBearing() as Void
        {
            if(_currentPosition == null || _currentWaypoint == null)
            {
                _eventRegistry.onWaypointBearing(null);
            }
            else
            {
                var bearing = calculate(_currentPosition, _currentWaypoint.position());
                _eventRegistry.onWaypointBearing(bearing);
            }
        }
        
        static function calculate(
            positionA as Location, 
            positionB as Location) as Numeric
        {
            var deltaLong = Math.toRadians(Utilities.longitude(positionB) - Utilities.longitude(positionA));
            var latA = Math.toRadians(Utilities.latitude(positionA));
            var latB = Math.toRadians(Utilities.latitude(positionB));
            var x = Math.cos(latB) * Math.sin(deltaLong);
            var y = 
                (Math.cos(latA) * Math.sin(latB)) -
                (Math.sin(latA) * Math.cos(latB) * Math.cos(deltaLong));

            return radiansToBearing(Math.atan2(x, y));
        }
    }

    function radiansToBearing(inputInRadians as Numeric) as Number 
    {
        var result = Math.toDegrees(inputInRadians);
        result = result + 360;
        return Utilities.mod(result, 360);
    }

    function radiansToNorthToBearingFrom0(inputInRadians as Numeric) as Number
    {
        var bearingInRadians = 0 - inputInRadians;
        var result = Math.toDegrees(bearingInRadians);
        result = result + 360;
        return Utilities.mod(result, 360);
    }
}

