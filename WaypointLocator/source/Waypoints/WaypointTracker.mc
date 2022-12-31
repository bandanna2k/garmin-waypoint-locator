import Toybox.Lang;
import Toybox.Position;
import Toybox.WatchUi;

module Waypoints
{
    class WaypointTracker extends BehaviorDelegate
    {
        var _waypoints;
        var _currentWaypointIndex;

        var _listener;

        function initialize(listener as Events)
        {
            BehaviorDelegate.initialize();

            _listener = listener;

            _waypoints = [];
            _currentWaypointIndex = null;
        }

        function addWaypoint(
            title as String,
            value as Position.Location) as Void
        {
            var waypoint = new Waypoint(title, value);

            _waypoints.add(waypoint);
            if(_currentWaypointIndex == null)
            {
                _currentWaypointIndex = 0;
            }

            _listener.onCurrentWaypoint((_waypoints as Array<Waypoint>)[_currentWaypointIndex]);
            _listener.onWaypointCounter(_currentWaypointIndex + 1, _waypoints.size());
        }

        function onNextPage() as Boolean
        {
            return onNextWaypoint();
        }

        function onPreviousPage() as Boolean
        {
            return onPreviousWaypoint();
        }

        function onNextWaypoint() as Boolean
        {
            if(_currentWaypointIndex == null)
            {
                _listener.onCurrentWaypoint(null);
                return false;
            }

            _currentWaypointIndex = Utilities.mod(_currentWaypointIndex + 1, _waypoints.size());
            _listener.onCurrentWaypoint((_waypoints as Array<Waypoint>)[_currentWaypointIndex]);
            _listener.onWaypointCounter(_currentWaypointIndex + 1, _waypoints.size());
            return true;
        }

        function onPreviousWaypoint() as Boolean
        {
            if(_currentWaypointIndex == null)
            {
                _listener.onCurrentWaypoint(null);
                return false;
            }

            _currentWaypointIndex = Utilities.mod(_currentWaypointIndex - 1 + _waypoints.size(), _waypoints.size());
            _listener.onCurrentWaypoint((_waypoints as Array<Waypoint>)[_currentWaypointIndex]);
            _listener.onWaypointCounter(_currentWaypointIndex + 1, _waypoints.size());
            return true;
        }
    }
}