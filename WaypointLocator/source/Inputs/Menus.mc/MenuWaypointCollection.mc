import Toybox.WatchUi;
import Toybox.Lang;
import Waypoints;

module Inputs { module Menus
{        
    class MenuWaypointCollection extends Menu2
    {
        var _menuInput;
        var _waypointCollection;

        function initialize(waypointCollection as Collection)
        {
            Menu2.initialize({:title=>"Waypoints"});

            _waypointCollection = waypointCollection;

            addItem(new MenuItem(" Import", repositoryString(), "_mainWaypointCollectionsImport", {}));
            addItem(new MenuItem(" Select", currentSelectionString(), "_mainWaypointCollectionsSelect", {}));
            _menuInput = new MenuInput(new Method(self, :onSelection));
        }

        function currentSelectionString() as String 
        {
            var currentSelection = _waypointCollection.currentSelection();
            return " Current: " + (currentSelection == null ? "None" : currentSelection.toString());
        }

        function repositoryString() as String
        {
            return " " + _waypointCollection.repository();
        }

        function showMenu()
        {
            WatchUi.pushView(self, _menuInput, WatchUi.SLIDE_IMMEDIATE);
        }

        function onSelection(selection as String) as Void
        {
            if("_mainWaypointCollectionsImport".equals(selection))
            {
                WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

                var subMenu = new MenuWaypointCollectionImportFrom(_waypointCollection);
                subMenu.showMenu();
                return;
            }
            if("_mainWaypointCollections".equals(selection))
            {
                WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
Logging.debug("_mainWaypointCollections");

                // var subMenu = new MenuWaypointCollections(_eventRegistry);
                // subMenu.showMenu();
                return;
            }
        }
    }
}}