import Toybox.WatchUi;
import Toybox.Lang;
import Waypoints;
import Routes;

module Inputs { module Menus
{        
    class MenuRouteImportTo extends Menu2
    {
        var _menuInput;
        var _routeRepository;
        var _source;

        function initialize(
            routeRepository as Repository,
            source as String)
        {
            Menu2.initialize({:title=>"Save To"});

            _routeRepository = routeRepository;
            _source = source;

            var numbers = "0123456789";
            for(var i = 0; i < numbers.length(); i++)
            {
                var item = numbers.substring(i, i + 1);
                addItem(new MenuItem(" Destination " + item, null, "_mainRouteImportTo" + item, {}));
            }
            _menuInput = new MenuInput(new Method(self, :onSelection));
        }

        function showMenu()
        {
            WatchUi.pushView(self, _menuInput, WatchUi.SLIDE_IMMEDIATE);
        }

        function onSelection(selection as String) as Void
        {
            var destinationAsString = selection.substring(selection.length() - 1, selection.length());
            var destinationAsNumber = destinationAsString.toNumber();

            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

            _routeRepository.importRouteFromWeb(_source, destinationAsNumber);
            return;
        }
    }
}}