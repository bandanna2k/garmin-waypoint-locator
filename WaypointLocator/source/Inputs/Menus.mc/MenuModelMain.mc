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
            addItem(new MenuItem(" Routes", null, "menuRoutes", {}));
            addItem(new MenuItem(toStringRipleyMode(), null, "menuRipleyMode", {}));
            addItem(new MenuItem(" Activity Type", null, "menuActivityType", {}));
        }

        function toStringRipleyMode() as String
        {
            if(adapter().isRipleyModeEnabled())
            {
                return " Ripley Mode (on)";
            }
            else
            {
                return " Ripley Mode (off)";
            }
        }

        function onSelection(selection as String) as MenuModel or Null
        {
            if("menuRipleyMode".equals(selection))
            {
                adapter().toggleRipleyMode();
                return new MenuModelMain(_menu);
            }
            if("menuRoutes".equals(selection))
            {
                return new MenuModelRoutes(_menu);
            }
            if("menuActivityType".equals(selection))
            {
                return new MenuModelActivityType(_menu);
            }
            return null;
        }
    }
}}