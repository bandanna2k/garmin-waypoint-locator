import Toybox.WatchUi;
import Toybox.Lang;

module Menu
{        
    class MenuBehaviourDelegate extends BehaviorDelegate 
    {
        var _menuInput;
        var menu;
        var _selection;

        function initialize() 
        {
            BehaviorDelegate.initialize();

            _selection = "";
            menu = new Menu2({:title=>selectionString()});
            menu.addItem(new MenuItem("0", null, "0", {}));
            menu.addItem(new MenuItem("1", null, "1", {}));
            menu.addItem(new MenuItem("Done", null, "itemDone", {}));
            _menuInput = new MenuInputDelegate(new Method(self, :onSelection));
        }

        function selectionString() 
        {
            return "[" + _selection + "]";
        }

        function onSelection(selection as String) as Void
        {
            if("itemDone".equals(selection))
            {
                menu.popView(WatchUi.SLIDE_IMMEDIATE);
                _selection = "";
                return;
            }

            _selection = _selection + selection;

            menu.setTitle(selectionString());
            menu.setFocus(0);
        }

        function onMenu()
        {
            WatchUi.pushView(menu, _menuInput, WatchUi.SLIDE_IMMEDIATE);
            return true;
        }}
}