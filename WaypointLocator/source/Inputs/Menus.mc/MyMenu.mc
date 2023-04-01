import Toybox.WatchUi;
import Toybox.Lang;
import Routes;

module Inputs { module Menus 
{
    class MyMenu
    {
        var _menu2;
        var _menuEvents;

        function initialize(
            menu2 as Menu2,
            menuEvents as MenuEvents)
        {
            _menu2 = menu2;
            _menuEvents = menuEvents;
        }

        function menu2()
        {
            return _menu2;
        }

        function events()
        {
            return _menuEvents;
        }
    }
}}