import Toybox.Lang;
import Toybox.Math;
import Toybox.Position;
import Waypoints;

module Distance
{
    const _radians90 = Math.toRadians(90);

    class DistanceCalculator extends Events
    {
        var _eventRegistry;
        var _currentWaypoint;
        var _currentPosition;

        function initialize(eventRegistry)
        {
            Events.initialize();
            _eventRegistry = eventRegistry;
            _eventRegistry.register(self);
        }

        function onCurrentWaypoint(currentWaypoint as Waypoint or Null) as Void
        {
            _currentWaypoint = currentWaypoint;
            calculateDistance();
        }
        function onCurrentPosition(currentPosition as Location or Null) as Void
        {
            _currentPosition = currentPosition;
            calculateDistance();
        }
        function calculateDistance() as Void
        {
            if(_currentPosition == null || _currentWaypoint == null)
            {
                _eventRegistry.onDistance(null);
            }
            else
            {
                var distance = calculate(_currentPosition, _currentWaypoint.position());
                _eventRegistry.onDistance(distance);
            }
        }

        static function calculate(
            positionA as Toybox.Position.Location, 
            positionB as Toybox.Position.Location) as DistanceValue
        {
            var ninetyMinusLatA = _radians90 - Math.toRadians(Utilities.latitude(positionA));
            var ninetyMinusLatB = _radians90 - Math.toRadians(Utilities.latitude(positionB));
            var longAMinusLongB = Math.toRadians(Utilities.longitude(positionA) - Utilities.longitude(positionB));

            // System.println("A " + Math.cos(ninetyMinusLatA));
            // System.println("B " + Math.cos(ninetyMinusLatB));
            // System.println("C " + Math.sin(ninetyMinusLatA));
            // System.println("D " + Math.sin(ninetyMinusLatB));
            // System.println("E " + Math.cos(longAMinusLongB));

            var inner = 
            Math.cos(ninetyMinusLatA)
            * Math.cos(ninetyMinusLatB)
            + Math.sin(ninetyMinusLatA)
            * Math.sin(ninetyMinusLatB)
            * Math.cos(longAMinusLongB);

            var result = Math.acos(inner) * 6371000d;
            return DistanceValue.fromMetres(result);
        }
    }
}
