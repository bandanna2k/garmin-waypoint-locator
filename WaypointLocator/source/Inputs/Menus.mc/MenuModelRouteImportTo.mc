import Toybox.WatchUi;
import Toybox.Lang;
import Inputs.Menus;
import Routes;

module Inputs { module Menus
{        
    class MenuModelRouteImportTo extends MenuModel
    {
        var _source;

        function initialize(
            menu as MyMenu, 
            source as String)
        {
            MenuModel.initialize(menu);
            _source = source;
        }

        function updateMenu()
        {
            MenuModel.updateMenu();

            setTitle("Save To");

            var numbers = "0123456789";
            for(var i = 0; i < numbers.length(); i++)
            {
                var item = numbers.substring(i, i + 1);
                addItem(new MenuItem(" Save to " + item, null, "menuRouteImportTo" + item, {}));
            }
        }

        function onSelection(selection as String) as MenuModel or Null
        {
            if(null != selection.find("menuRouteImportTo"))
            {
                var destinationAsString = selection.substring(selection.length() - 1, selection.length());
                var destinationAsNumber = destinationAsString.toNumber();

                adapter().onRouteImport(_source, destinationAsNumber);
            }
            return null;
        }
    }
}}