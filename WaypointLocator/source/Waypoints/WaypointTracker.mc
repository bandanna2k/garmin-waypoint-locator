import Toybox.Lang;
import Toybox.Position;
import Toybox.WatchUi;

module Waypoints
{
    class WaypointTracker extends Events
    {
        var _waypoints;
        var _currentWaypointIndex;

        var _eventRegistry;

        function initialize(eventRegistry as EventRegistry)
        {
            Events.initialize();

            _eventRegistry = eventRegistry;
            _eventRegistry.register(self);

            _waypoints = [];
            _currentWaypointIndex = null;
        }

        function onNextWaypoint() as Void
        {
            if(_currentWaypointIndex == null)
            {
                _eventRegistry.onCurrentWaypoint(null);
                return;
            }

            _currentWaypointIndex = Utilities.mod(_currentWaypointIndex + 1, _waypoints.size());
            _eventRegistry.onCurrentWaypoint((_waypoints as Array<Waypoint>)[_currentWaypointIndex]);
            _eventRegistry.onWaypointCounter(_currentWaypointIndex + 1, _waypoints.size());
        }

        function onPreviousWaypoint() as Void
        {
            if(_currentWaypointIndex == null)
            {
                _eventRegistry.onCurrentWaypoint(null);
                return;
            }

            _currentWaypointIndex = Utilities.mod(_currentWaypointIndex - 1 + _waypoints.size(), _waypoints.size());
            _eventRegistry.onCurrentWaypoint((_waypoints as Array<Waypoint>)[_currentWaypointIndex]);
            _eventRegistry.onWaypointCounter(_currentWaypointIndex + 1, _waypoints.size());
        }

        function onWaypoints(array as Array<Waypoint>) as Void
        {
            _waypoints = array;
            if(array.size() == 0)
            {
                _currentWaypointIndex = null;
            }
            else
            {
                _currentWaypointIndex = 0;
            }

            _eventRegistry.onCurrentWaypoint((_waypoints as Array<Waypoint>)[_currentWaypointIndex]);
            _eventRegistry.onWaypointCounter(_currentWaypointIndex + 1, _waypoints.size());
        }
    }
}