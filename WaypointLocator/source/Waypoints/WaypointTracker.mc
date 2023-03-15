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

Toybox.System.println("WaypointTracker.onNextWaypoint");
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

Toybox.System.println("WaypointTracker.onPreviousWaypoint");
            Storage.setValue("waypoint.currentIndex", _currentWaypointIndex);
        }

        /*
        called from import and onStart when loading
        */
        function onWaypoints(array as Array<Waypoint>) as Void
        {
Toybox.System.println("WaypointTracker.onWaypoints. array.size:" + array.size());
            if(array.size() == 0)
            {
                return;
            }

            _waypoints = array;
            _currentWaypointIndex = 0;
            _eventRegistry.onCurrentWaypoint((_waypoints as Array<Waypoint>)[_currentWaypointIndex]);
            _eventRegistry.onWaypointCounter(_currentWaypointIndex + 1, _waypoints.size());
        }

        function onStart() as Void
        {
            try
            {
                loadWaypoints();
                loadCurrentWaypoint();
            }
            catch(ex)
            {
Toybox.System.println("Failed to start. Clearing all waypoints. " + ex.getErrorMessage());
                reset();
            }
        }

        function loadWaypoints() as Void
        {
            var count = Storage.getValue("waypoint.count");
Toybox.System.println("WaypointTracker.loadWaypoints. count:" + count);
            var arrayOfWaypoints = [] as Array<Waypoint>;
            if(count == null || count == 0)
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
                _currentWaypointIndex = 0;

                _eventRegistry.onWaypoints(arrayOfWaypoints);
                _eventRegistry.onCurrentWaypoint((_waypoints as Array<Waypoint>)[_currentWaypointIndex]);
                _eventRegistry.onWaypointCounter(_currentWaypointIndex + 1, _waypoints.size());
            }        
        }

        function loadCurrentWaypoint() 
        {
            var currentIndex = Storage.getValue("waypoint.currentIndex");
Toybox.System.println("WaypointTracker.loadCurrentWaypoint. currentIndex:" + currentIndex);
            if(currentIndex == null)
            {
                if(_waypoints.size() > 0)
                {
                    _currentWaypointIndex = 0;
                }
                else
                {
                    _currentWaypointIndex = null;
                }
            }
            else
            {
                _currentWaypointIndex = currentIndex.toNumber();
                _eventRegistry.onCurrentWaypoint((_waypoints as Array<Waypoint>)[_currentWaypointIndex]);
                _eventRegistry.onWaypointCounter(_currentWaypointIndex + 1, _waypoints.size());
            }
        }

        function reset() 
        {
 Toybox.System.println("WaypointTracker.reset");
           _waypoints = [];
            _currentWaypointIndex = null;

            Storage.clearValues();
            _eventRegistry.onCurrentWaypoint(null);
        }
    }
}