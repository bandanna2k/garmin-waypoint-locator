import Toybox.Lang;
import Toybox.WatchUi;

class WaypointLocatorDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new WaypointLocatorMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}