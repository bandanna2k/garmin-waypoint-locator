import Toybox.WatchUi;
import Toybox.Lang;
import Waypoints;
import Routes;

module Inputs { module Menus
{        
    class MenuRouteSelect extends Menu2
    {
        var _menu;
        var _routeRepository;

        function initialize(routeRepository as Repository)
        {
            Menu2.initialize({:title=>"Select Route"});

            _routeRepository = routeRepository;

            for(var i = 0; i < 10; i++)
            {
                var routeTitle = _routeRepository.routeTitle(i);
                addItem(new MenuItem(" " + i + ": " + routeTitle, null, "_mainRouteSelect" + i, {}));
            }
            _menu = new MenuInput(new Method(self, :onSelection));
        }

        function currentSelectionString() as String 
        {
            var currentSelection = _routeRepository.currentSelection();
            return " Current: " + (currentSelection == null ? "None" : currentSelection.toString());
        }

        function repositoryString() as String
        {
            return " " + _routeRepository.repositoryUrl();
        }

        function showMenu()
        {
            WatchUi.pushView(self, _menu, WatchUi.SLIDE_IMMEDIATE);
        }

        function onSelection(selection as String)
        {
Logging.debug("_mainRouteSelect " + selection);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

            var selectionAsString = selection.substring(selection.length() - 1, selection.length());
            var selectionAsNumber = selectionAsString.toNumber();

            _routeRepository.selectRoute(selectionAsNumber);
        }
    }
}}