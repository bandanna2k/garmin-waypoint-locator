import Toybox.WatchUi;
import Toybox.Lang;
import Inputs.Menus;
import Routes;

module Inputs { module Menus
{        
    class MenuModelRouteImportFrom extends MenuModel
    {
        function initialize(menu as MyMenu)
        {
            MenuModel.initialize(menu);
        }

        function updateMenu()
        {
            MenuModel.updateMenu();

            setTitle("Import From");

            var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            for(var i = 0; i < alphabet.length(); i++)
            {
                var item = alphabet.substring(i, i + 1);
                addItem(new MenuItem(" Source " + item, null, "menuRouteImportFrom" + item, {}));
            }
        }

        function onSelection(selection as String) as MenuModel or Null
        {
            if(null != selection.find("menuRouteImportFrom"))
            {
                var from = selection.substring(selection.length() - 1, selection.length());

                return new MenuModelRouteImportTo(_menu, from);
            }
            return null;
        }
    }
}}