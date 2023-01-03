import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Application;
import Waypoints;
import Inputs.Menus;

module Inputs
{        
    class InputBehaviour extends BehaviorDelegate 
    {
        var _eventRegistry;
        var _menu;

        function initialize(eventRegistry as EventRegistry) 
        {
            BehaviorDelegate.initialize();

            _eventRegistry = eventRegistry;
            _menu = new MainMenu(_eventRegistry);            
        }

        function onMenu()
        {
            _menu.showMenu();
            return true;
        }

        function onNextPage() as Boolean
        {
            _eventRegistry.onNextWaypoint();
            return true;
        }

        function onPreviousPage() as Boolean
        {
            _eventRegistry.onPreviousWaypoint();
            return true;
        }
    }
}