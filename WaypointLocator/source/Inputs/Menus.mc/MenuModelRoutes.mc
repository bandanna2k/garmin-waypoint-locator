import Toybox.WatchUi;
import Toybox.Lang;
import Inputs.Menus;
import Routes;

module Inputs { module Menus
{        
    class MenuModelRoutes extends MenuModel
    {
        function initialize(menu as MyMenu)
        {
            MenuModel.initialize(menu);
        }

        function updateMenu()
        {
            MenuModel.updateMenu();

            setTitle("Routes");
            addItem(new MenuItem(" Import", null, "menuRouteImport", {}));
            addItem(new MenuItem(" Select", null, "menuRouteSelect", {}));
        }

        function onSelection(selection as String) as MenuModel or Null
        {
            if("menuRouteSelect".equals(selection))
            {
                return new MenuModelRouteSelect(_menu);
            }
            if("menuRouteImport".equals(selection))
            {
                return new MenuModelRouteImportFrom(_menu);
            }
            return null;
        }
    }
}}