import Toybox.WatchUi;
import Toybox.Lang;
import Inputs.Menus;
import Routes;
import Configuration;

module Inputs { module Menus
{        
    class MenuModelActivityType extends MenuModel
    {
        function initialize(menu as MyMenu)
        {
            MenuModel.initialize(menu);
        }

        function updateMenu()
        {
            MenuModel.updateMenu();

            setTitle("Activity Type");
            addItem(new MenuItem(" Cycle", null, "menuCycle", {}));
            addItem(new MenuItem(" Run", null, "menuRun", {}));
            addItem(new MenuItem(" Hike", null, "menuHike", {}));
        }

        function onSelection(selection as String) as MenuModel or Null
        {
            if("menuCycle".equals(selection))
            {
                adapter().setActivityType(Configuration.ACTIVITY_TYPE_CYCLE);
            }
            if("menuRun".equals(selection))
            {
                adapter().setActivityType(Configuration.ACTIVITY_TYPE_RUN);
            }
            if("menuHike".equals(selection))
            {
                adapter().setActivityType(Configuration.ACTIVITY_TYPE_HIKE);
            }
            return null;
        }
    }
}}