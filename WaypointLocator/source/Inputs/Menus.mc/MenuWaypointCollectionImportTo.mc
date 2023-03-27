import Toybox.WatchUi;
import Toybox.Lang;
import Waypoints;

module Inputs { module Menus
{        
    class MenuWaypointCollectionImportTo extends Menu2
    {
        var _menuInput;
        var _waypointCollection;
        var _source;

        function initialize(
            waypointCollection as Collection,
            source as String)
        {
            Menu2.initialize({:title=>"Save To"});

            _waypointCollection = waypointCollection;
            _source = source;

            var numbers = "0123456789";
            for(var i = 0; i < numbers.length(); i++)
            {
                var item = numbers.substring(i, i + 1);
                addItem(new MenuItem(" Destination " + item, null, "_mainWaypointCollectionsImportTo" + item, {}));
            }
            _menuInput = new MenuInput(new Method(self, :onSelection));
        }

        function showMenu()
        {
            WatchUi.pushView(self, _menuInput, WatchUi.SLIDE_IMMEDIATE);
        }

        function onSelection(selection as String) as Void
        {
            var destination = selection.substring(selection.length() - 1, selection.length());

            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

            _waypointCollection.importCollection(_source, destination);
            return;
        }
    }
}}