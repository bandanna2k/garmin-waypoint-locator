import Toybox.WatchUi;
import Toybox.Lang;

module Menu
{
    class MenuInputDelegate extends Menu2InputDelegate 
    {
        var _callback;

        function initialize(callback as Method) 
        {
            Menu2InputDelegate.initialize();

            _callback = callback;
        }

        function onSelect(item) 
        {
            _callback.invoke(item.getId());
        }
    }
}