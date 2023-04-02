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

        var _menu;
        var _menuModel;
        var _menuInput;
        
        function initialize(
            eventRegistry as EventRegistry,
            routeRepository as Repository) 
        {
            BehaviorDelegate.initialize();

            _eventRegistry = eventRegistry;
            _routeRepository = routeRepository;
            _menu = new MyMenu(
                new Menu2({:title=>"-"}), 
                new MenuAdapter(_routeRepository));

            _menuInput = new MenuInput(new Method(self, :onSelection));
        }

        function onMenu() as Boolean
        {
            WatchUi.pushView(_menu.menu2(), _menuInput, WatchUi.SLIDE_IMMEDIATE);

            _menuModel = new MenuModelMain(_menu);
            _menuModel.updateMenu();
            return true;
        }

        function onSelection(selection as String) as Void
        {
Logging.trace("InputBehaviour.onMenuSelection " + selection);

            var result = _menuModel.onSelection(selection);
            if(result instanceof MenuModel)
            {
                _menuModel = result;
                _menuModel.updateMenu();
                return;
            }

            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
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