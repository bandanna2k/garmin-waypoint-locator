import Toybox.WatchUi;
import Toybox.Lang;
import Waypoints;
import Inputs.Menus;
import Routes;

module Inputs { module Menus
{        
    class MenuMain extends Menu2
    {
        var _menuInput;
        var _eventRegistry;
        var _routeRepository;

        function initialize(
            eventRegistry as EventRegistry,
            routeRepository as Repository)
        {
            Menu2.initialize({:title=>"Main Menu"});

            _eventRegistry = eventRegistry;
            _routeRepository = routeRepository;

            addItem(new MenuItem(" Ripley Mode (on)", null, "_main1", {}));
            addItem(new MenuItem(" Routes", null, "_mainRoutes", {}));
            _menuInput = new MenuInput(new Method(self, :onSelection));
        }

        function showMenu()
        {
            WatchUi.pushView(self, _menuInput, WatchUi.SLIDE_IMMEDIATE);
        }

        function onSelection(selection as String) as Void
        {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

            if("_mainRoutes".equals(selection))
            {
                var subMenu = new MenuRoutes(_routeRepository);
                subMenu.showMenu();
                return;
            }
        }
    }
}}