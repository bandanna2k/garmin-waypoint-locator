import Toybox.WatchUi;
import Toybox.Lang;
import Inputs.Menus;

module Inputs { module Menus
{        
    class MenuModel
    {
        var _menu;

        function initialize(menu as Menu2)
        {
            _menu = menu;
        }

        function updateMenu() 
        {
            _menu.setFocus(0);
            while(_menu.deleteItem(0))
            {
            }
        }
        function onSelection(selection as String) as MenuModel or Null 
        { 
            return null;
        }
    }
}}