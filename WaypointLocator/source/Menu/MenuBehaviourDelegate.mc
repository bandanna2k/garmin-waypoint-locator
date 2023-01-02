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

                var url = "https://davidnorthtennis.com/gpx/2.gpx";

                // Make the image request
                var options = {
                    :method => Communications.HTTP_REQUEST_METHOD_GET,
                    :headers => 
                    {                                           
                        "Content-Type" => Communications.REQUEST_CONTENT_TYPE_URL_ENCODED
                    },                                             
                    :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
                };
                Communications.makeWebRequest(url, {}, options, method(:responseCallback));
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
        }

        function responseCallback(
            responseCode as Number, 
            data as Dictionary or String or Null) as Void 
        {
            Toybox.System.println(responseCode);
            responseCode = responseCode;
            if (responseCode < 400) 
            {
                if(data instanceof Dictionary)
                {
                    Toybox.System.println("DICT");
                    Toybox.System.println(data);
                }   
                else if(data instanceof String)
                {
                    Toybox.System.println("STRING");
                    Toybox.System.println(data);
                }   
                else
                {
                    Toybox.System.println(data);
                    Toybox.System.println("Not a file I understand");
                }
            }
            else 
            {
                Toybox.System.println("Failed " + responseCode);
            }
        }


    }
}