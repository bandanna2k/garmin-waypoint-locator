import Toybox.WatchUi;
import Toybox.Lang;
import Inputs.Menus;
import Routes;

module Inputs { module Menus
{        
    class MenuModelRouteOptions extends MenuModel
    {
        var _selectedRoute;

        function initialize(
            menu as MyMenu,
            selectedRoute as Number)
        {
            MenuModel.initialize(menu);
            _selectedRoute = selectedRoute;
        }

        function updateMenu()
        {
            MenuModel.updateMenu();

            setTitle("Route Options");
            addItem(new MenuItem(" Select Route", null, "menuRouteSelect", {}));
            addItem(new MenuItem(" Import from Web", null, "menuRouteImport", {}));
            addItem(new MenuItem(" Select Reverse Route", null, "menuRouteSelectReverse", {}));
        }

        function onSelection(selection as String) as MenuModel or Null
        {
            if("menuRouteSelect".equals(selection))
            {
                adapter().onRouteSelect(_selectedRoute, false);
            }
            if("menuRouteSelectReverse".equals(selection))
            {
                adapter().onRouteSelect(_selectedRoute, true);
            }
            if("menuRouteImport".equals(selection))
            {
                return new MenuModelRouteImport(_menu, _selectedRoute);
            }
            return null;
        }
    }
}}