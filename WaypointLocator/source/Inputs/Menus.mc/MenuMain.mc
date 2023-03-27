import Toybox.WatchUi;
import Toybox.Lang;
import Waypoints;
import Inputs.Menus;

module Inputs { module Menus
{        
    class MenuMain extends Menu2
    {
        var _menuInput;
        var _eventRegistry;
        var _waypointCollection;

        function initialize(
            eventRegistry as EventRegistry,
            waypointCollection as Collection)
        {
            Menu2.initialize({:title=>"Main Menu"});

            _eventRegistry = eventRegistry;
            _waypointCollection = waypointCollection;

            addItem(new MenuItem(" Ripley Mode (on)", null, "_main1", {}));
            addItem(new MenuItem(" Import Waypoints", null, "_mainImportWaypoints", {}));
            addItem(new MenuItem(" Waypoint Collections", null, "_mainWaypointCollections", {}));
            _menuInput = new MenuInput(new Method(self, :onSelection));
        }

        function showMenu()
        {
            WatchUi.pushView(self, _menuInput, WatchUi.SLIDE_IMMEDIATE);
        }

        function onSelection(selection as String) as Void
        {
            if("_mainImportWaypoints".equals(selection))
            {
                WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

                var subMenu = new MenuWaypoints(_eventRegistry);
                subMenu.showMenu();
                return;
            }
            if("_mainWaypointCollections".equals(selection))
            {
                WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

                var subMenu = new MenuWaypointCollection(_eventRegistry, _waypointCollection);
                subMenu.showMenu();
                return;
            }
        }
    }
}}