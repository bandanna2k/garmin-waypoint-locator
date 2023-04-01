import Toybox.WatchUi;
import Toybox.Lang;
import Inputs.Menus;
import Routes;

module Inputs { module Menus
{        
    class MenuModelMain extends MenuModel
    {
        function initialize(menu as MyMenu)
        {
            MenuModel.initialize(menu);
        }

        function updateMenu()
        {
            MenuModel.updateMenu();

            setTitle("Main Menu");
            addItem(new MenuItem(" Ripley Mode (on)", null, "menuMainRipleyMode", {}));
            addItem(new MenuItem(" Routes", null, "menuMainRoutes", {}));
        }

        function onSelection(selection as String) as MenuModel or Null
        {
            if("menuMainRoutes".equals(selection))
            {
                return new MenuModelRoutes(_menu);
            }
            return null;
        }
    }
}}