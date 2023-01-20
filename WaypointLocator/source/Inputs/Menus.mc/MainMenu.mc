import Toybox.WatchUi;
import Toybox.Lang;
import Waypoints;

module Inputs { module Menus
{        
    class MainMenu extends Menu2
    {
        var _menuInput;
        var _eventRegistry;

        function initialize(eventRegistry as EventRegistry)
        {
            Menu2.initialize({:title=>"Main Menu"});

            _eventRegistry = eventRegistry;

            addItem(new MenuItem(" Ripley Mode (on)", null, "_main1", {}));
            addItem(new MenuItem(" Import Waypoints", null, "_mainImportWaypoints", {}));
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
        }
    }
}}