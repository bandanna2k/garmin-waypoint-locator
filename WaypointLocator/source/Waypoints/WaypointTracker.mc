import Toybox.Lang;
import Toybox.Position;
import Toybox.System;
import Toybox.WatchUi;

module Waypoints
{
    class WaypointTracker extends WatchUi.BehaviorDelegate
    {
        var _waypoints;
        var _currentWaypointIndex;
        var _currentWaypointCallback;
        var _waypointCounterCallback;

        function initialize(
            currentWaypointCallback as Method,
            waypointCounterCallback as Method)
        {
            BehaviorDelegate.initialize();

            _currentWaypointCallback = currentWaypointCallback;
            _waypointCounterCallback = waypointCounterCallback;

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

            _currentWaypointCallback.invoke(_waypoints[_currentWaypointIndex]);
            _waypointCounterCallback.invoke(_currentWaypointIndex + 1, _waypoints.size());
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
            System.println("Next waypoint");
            if(_currentWaypointIndex == null)
            {
                _currentWaypointCallback.invoke(_currentWaypointIndex);
                return false;
            }

            _currentWaypointIndex = Utilities.mod(_currentWaypointIndex + 1, _waypoints.size());
            _currentWaypointCallback.invoke(_waypoints[_currentWaypointIndex]);
            _waypointCounterCallback.invoke(_currentWaypointIndex + 1, _waypoints.size());
            return true;
        }

        function onPreviousWaypoint() as Boolean
        {
            System.println("Prev waypoint");
            if(_currentWaypointIndex == null)
            {
                _currentWaypointCallback.invoke(_currentWaypointIndex);
                return false;
            }

            _currentWaypointIndex = Utilities.mod(_currentWaypointIndex - 1 + _waypoints.size(), _waypoints.size());
            _currentWaypointCallback.invoke(_waypoints[_currentWaypointIndex]);
            _waypointCounterCallback.invoke(_currentWaypointIndex + 1, _waypoints.size());
            return true;
        }
    }
}