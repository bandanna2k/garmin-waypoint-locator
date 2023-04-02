import Toybox.WatchUi;
import Toybox.Lang;
import Routes;

module Inputs { module Menus 
{
    class MyMenu
    {
        var _menu2;
        var _menuAdapter;

        function initialize(
            menu2 as Menu2,
            menuAdapter as MenuAdapter)
        {
            _menu2 = menu2;
            _menuAdapter = menuAdapter;
        }

        function menu2()
        {
            return _menu2;
        }

        function adapter()
        {
            return _menuAdapter;
        }
    }
}}