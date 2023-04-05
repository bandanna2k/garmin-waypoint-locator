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

            setTitle("Select Route");
            for(var i = 0; i < 10; i++)
            {
                var routeTitle = adapter().routeTitle(i);
                addItem(new MenuItem(" " + i + ": " + routeTitle, null, "menuRouteOptions" + i, {}));
            }
        }

        function onSelection(selection as String) as MenuModel or Null
        {
            if(null != selection.find("menuRouteOptions"))
            {
                var selectionAsString = selection.substring(selection.length() - 1, selection.length());
                var selectionAsNumber = selectionAsString.toNumber();

                return new MenuModelRouteOptions(_menu, selectionAsNumber);
            }
            return null;
        }
    }
}}