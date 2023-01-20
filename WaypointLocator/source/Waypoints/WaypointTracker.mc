import Toybox.Lang;
import Toybox.Position;
import Toybox.Application;
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

            Storage.setValue("waypoint.currentIndex", _currentWaypointIndex);
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

            Storage.setValue("waypoint.currentIndex", _currentWaypointIndex);
        }

        /*
        called from import and onStart when loading
        */
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
        }

        function onStart() as Void
        {
            loadWaypoints();
            loadCurrentWaypoint();
        }

        function loadWaypoints() as Void
        {
            var count; 
            try
            {
                count = Storage.getValue("waypoint.count");
                var arrayOfWaypoints = [] as Array<Waypoint>;
                if(count == null)
                {
                    return;
                }
                else
                {
                    for(var i = 0; i < count; i++)
                    {
                        var waypoint = Waypoints.toWaypointFromStorage(i);
                        arrayOfWaypoints.add(waypoint);
                    }
                    _eventRegistry.onWaypoints(arrayOfWaypoints);
                }        
            }
            catch(ex)
            {
Toybox.System.println("Error loading waypoints. " + ex.getErrorMessage());
                Storage.clearValues();
                return;
            }
        }

        function loadCurrentWaypoint() 
        {
            var currentIndex = Storage.getValue("waypoint.currentIndex");
            if(currentIndex != null)
            {
                _currentWaypointIndex = currentIndex.toNumber();
                _eventRegistry.onCurrentWaypoint((_waypoints as Array<Waypoint>)[_currentWaypointIndex]);
                _eventRegistry.onWaypointCounter(_currentWaypointIndex + 1, _waypoints.size());
            }
            else
            {
                _currentWaypointIndex = 0;
            }
        }
    }
}