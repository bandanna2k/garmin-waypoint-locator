import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Application;
import Waypoints;
import Logging;
import Inputs.Menus;
import Routes;

module Inputs
{        
    class InputBehaviour extends BehaviorDelegate 
    {
        var _eventRegistry;
        var _routeRepository;

        function initialize(
            eventRegistry as EventRegistry,
            routeRepository as Repository) 
        {
            BehaviorDelegate.initialize();

            _eventRegistry = eventRegistry;
            _routeRepository = routeRepository;
        }

        function onMenu() as Boolean
        {
            var menu = new MenuMain(_eventRegistry, _routeRepository);            
            menu.showMenu();
            return true;
        }

        function onNextPage() as Boolean
        {
Logging.trace("InputBehaviour.onNextPage");
            _eventRegistry.onNextWaypoint();
            return true;
        }

        function onPreviousPage() as Boolean
        {
Logging.trace("InputBehaviour.onPreviousPage");
            _eventRegistry.onPreviousWaypoint();
            return true;
        }

        function onSelect() as Boolean
        {
Logging.trace("InputBehaviour.onSelect");
            _eventRegistry.onActivityInitiate();
            return true;
        }
    }
}