import Toybox.WatchUi;
import Toybox.Lang;
import Inputs.Menus;
import Routes;

module Inputs { module Menus
{        
    class MenuModelRoutes extends MenuModel
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

            _menu.setTitle("Routes");
            _menu.addItem(new MenuItem(" Import", null, "menuRouteImport", {}));
            _menu.addItem(new MenuItem(" Select", null, "menuRouteSelect", {}));
        }

        function onSelection(selection as String) as MenuModel or Null
        {
            if("menuRouteSelect".equals(selection))
            {
                return new MenuModelRouteSelect(_menu, _routeRepository);
            }
            return null;
        }
    }
}}