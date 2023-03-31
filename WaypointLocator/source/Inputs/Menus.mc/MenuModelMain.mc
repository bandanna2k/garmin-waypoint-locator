import Toybox.WatchUi;
import Toybox.Lang;
import Inputs.Menus;
import Routes;

module Inputs { module Menus
{        
    class MenuModelMain extends MenuModel
    {
        var _routeRepository;

        function initialize(
            menu as Menu2,
            routeRepository as Repository)
        {
            MenuModel.initialize(menu);

            _routeRepository = routeRepository;
        }

        function updateMenu()
        {
            MenuModel.updateMenu();

            _menu.setTitle("Main Menu");
            _menu.addItem(new MenuItem(" Ripley Mode (on)", null, "menuMainRipleyMode", {}));
            _menu.addItem(new MenuItem(" Routes", null, "menuMainRoutes", {}));
        }

        function onSelection(selection as String) as MenuModel or Null
        {
            if("menuMainRoutes".equals(selection))
            {
                return new MenuModelRoutes(_menu, _routeRepository);
            }
            return null;
        }
    }
}}