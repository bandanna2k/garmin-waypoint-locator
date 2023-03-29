import Toybox.WatchUi;
import Toybox.Lang;
import Routes;

module Inputs { module Menus
{        
    class MenuRouteImportFrom extends Menu2
    {
        var _menuInput;
        var _routeRepository;

        function initialize(
            routeRepository as Repository)
        {
            Menu2.initialize({:title=>"Import From"});

            _routeRepository = routeRepository;

            var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            for(var i = 0; i < alphabet.length(); i++)
            {
                var item = alphabet.substring(i, i + 1);
                addItem(new MenuItem(" Source " + item, null, "_mainRouteImportTo" + item, {}));
            }
            _menuInput = new MenuInput(new Method(self, :onSelection));
        }

        function showMenu()
        {
            WatchUi.pushView(self, _menuInput, WatchUi.SLIDE_IMMEDIATE);
        }

        function onSelection(selection as String) as Void
        {
            var source = selection.substring(selection.length() - 1, selection.length());

            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);

            var subMenu = new MenuRouteImportTo(_routeRepository, source);
            subMenu.showMenu();
            return;
        }
    }
}}