import Toybox.WatchUi;
import Toybox.Lang;
import Inputs.Menus;
import Routes;

module Inputs { module Menus
{        
    class MenuModelRouteImportFrom extends MenuModel
    {
        var _menuEvents;

        function initialize(
            menu as Menu2,
            menuEvents as MenuEvents)
        {
            MenuModel.initialize(menu);

            _menuEvents = menuEvents;
        }

        function updateMenu()
        {
            MenuModel.updateMenu();

            _menu.setTitle("Import From");

            var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            for(var i = 0; i < alphabet.length(); i++)
            {
                var item = alphabet.substring(i, i + 1);
                _menu.addItem(new MenuItem(" Source " + item, null, "menuRouteImportFrom" + item, {}));
            }
        }

        function onSelection(selection as String) as MenuModel or Null
        {
            if(null != selection.find("menuRouteImportFrom"))
            {
                var from = selection.substring(selection.length() - 1, selection.length());

                return new MenuModelRouteImportTo(_menu, _menuEvents, from);
            }
            return null;
        }
    }
}}