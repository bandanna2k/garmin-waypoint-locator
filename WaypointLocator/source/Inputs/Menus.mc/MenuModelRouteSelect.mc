import Toybox.WatchUi;
import Toybox.Lang;
import Inputs.Menus;
import Routes;

module Inputs { module Menus
{        
    class MenuModelRouteSelect extends MenuModel
    {
        var _routeRepository;

        function initialize(
            menu as Menu2,
            routeRepository as Repository)
        {
            MenuModel.initialize(menu);

            _routeRepository = routeRepository;
        }

        function updateMenu()
        {
            MenuModel.updateMenu();

            _menu.setTitle("Select Route");
            for(var i = 0; i < 10; i++)
            {
                var routeTitle = _routeRepository.routeTitle(i);
                _menu.addItem(new MenuItem(" " + i + ": " + routeTitle, null, "menuRouteSelect" + i, {}));
            }
        }

        function onSelection(selection as String) as MenuModel or Null
        {
            if(null != selection.find("menuRouteSelect"))
            {
                var selectionAsString = selection.substring(selection.length() - 1, selection.length());
                var selectionAsNumber = selectionAsString.toNumber();

                _routeRepository.selectRoute(selectionAsNumber);
            }
            return null;
        }
    }
}}