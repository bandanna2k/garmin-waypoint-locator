import Toybox.WatchUi;
import Toybox.Lang;
import Inputs.Menus;
import Routes;

module Inputs { module Menus
{        
    class MenuModelRouteImport extends MenuModel
    {
        var _destination;

        function initialize(
            menu as MyMenu, 
            destination as Number)
        {
            MenuModel.initialize(menu);
            _destination = destination;
        }

        function updateMenu()
        {
            MenuModel.updateMenu();

            setTitle("Import");

            var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            for(var i = 0; i < alphabet.length(); i++)
            {
                var item = alphabet.substring(i, i + 1);
                addItem(new MenuItem(" Source " + item, null, "menuRouteImport" + item, {}));
            }
        }

        function onSelection(selection as String) as MenuModel or Null
        {
            if(null != selection.find("menuRouteImport"))
            {
                var source = selection.substring(selection.length() - 1, selection.length());
                adapter().onRouteImport(source, _destination);
            }
            return null;
        }
    }
}}