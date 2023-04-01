import Toybox.WatchUi;
import Toybox.Lang;
import Inputs.Menus;

module Inputs { module Menus
{        
    class MenuModel
    {
        var _menu;

        function initialize(menu as MyMenu)
        {
            _menu = menu;
        }

        function updateMenu() 
        {
            _menu.menu2().setFocus(0);
            while(_menu.menu2().deleteItem(0))
            {
            }
        }

        function setTitle(title as String)
        {
            _menu.menu2().setTitle(title);
        }

        function addItem(menuItem as MenuItem)
        {
            _menu.menu2().addItem(menuItem);
        }

        function events()
        {
            return _menu.events();
        }

        function onSelection(selection as String) as MenuModel or Null 
        { 
            return null;
        }
    }
}}