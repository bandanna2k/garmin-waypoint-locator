import Toybox.WatchUi;
import Toybox.Lang;
import Waypoints;

module Inputs { module Menus
{        
    class MenuWaypointCollectionImport extends Menu2
    {
        var _menuInput;
        var _eventRegistry;
        var _waypointCollection;

        function initialize(
            eventRegistry as EventRegistry,
            waypointCollection as Collection)
        {
            Menu2.initialize({:title=>"Import Collection"});

            _eventRegistry = eventRegistry;
            _waypointCollection = waypointCollection;

            var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            for(var i = 0; i < alphabet.length(); i++)
            {
                var item = alphabet.substring(i, i + 1);
                addItem(new MenuItem(" " + item, null, "_mainWaypointCollectionsImport" + item, {}));
            }
            _menuInput = new MenuInput(new Method(self, :onSelection));
        }

        function showMenu()
        {
            WatchUi.pushView(self, _menuInput, WatchUi.SLIDE_IMMEDIATE);
        }

        function onSelection(selection as String) as Void
        {
            var letter = selection.substring(selection.length() - 1, selection.length());

            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

            _waypointCollection.importCollection(letter);
            return;
        }
    }
}}