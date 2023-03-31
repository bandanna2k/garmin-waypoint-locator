import Toybox.WatchUi;
import Toybox.Lang;
import Logging;

module Inputs { module Menus 
{
    class MenuInput extends Menu2InputDelegate 
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
}}