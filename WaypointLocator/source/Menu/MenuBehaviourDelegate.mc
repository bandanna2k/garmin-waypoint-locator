import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Application;
import Waypoints;

module Menu
{        
    class MenuBehaviourDelegate extends BehaviorDelegate 
    {
        var _eventRegistry;

        var _menu;
        var _menuInput;

        var _selection;

        function initialize(eventRegistry as EventRegistry) 
        {
            BehaviorDelegate.initialize();

            _eventRegistry = eventRegistry;
            _selection = "";
            _menu = new Menu2({:title=>selectionString()});
            _menu.addItem(new MenuItem("  0", null, "0", {}));
            _menu.addItem(new MenuItem("  1", null, "1", {}));
            _menu.addItem(new MenuItem("  2", null, "2", {}));
            _menu.addItem(new MenuItem("  3", null, "3", {}));
            _menu.addItem(new MenuItem("  4", null, "4", {}));
            _menu.addItem(new MenuItem(" Done", null, "itemDone", {}));
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
                _menu.popView(WatchUi.SLIDE_IMMEDIATE);

                var url = "https://davidnorthtennis.com/gpx/" + _selection + ".json";
                _selection = "";

                // Make the image request
                var options = {
                    :method => Communications.HTTP_REQUEST_METHOD_GET,
                    :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
                };
                Communications.makeWebRequest(url, {}, options, method(:responseCallback));
            }
            else
            {
                _selection = _selection + selection;
            }

            _menu.setTitle(selectionString());
            _menu.setFocus(0);
        }

        function onMenu()
        {
            WatchUi.pushView(_menu, _menuInput, WatchUi.SLIDE_IMMEDIATE);
            return true;
        }

        function responseCallback(
            responseCode as Number, 
            data as Dictionary or String or Null) as Void 
        {
            responseCode = responseCode;
            if (responseCode < 400) 
            {
                if(data instanceof Dictionary)
                {
                    var newWaypoints = [] as Array<Waypoint>;

                    var waypoints = data.get("waypoints") as Array;
                    for(var i = 0 ; i < waypoints.size(); i++)
                    {
                        newWaypoints.add(Waypoints.toWaypoint(waypoints[i]));
                    }
                    _eventRegistry.onWaypoints(newWaypoints);
                }   
                else
                {
                    Toybox.System.println(responseCode);
                    Toybox.System.println(data);
                    Toybox.System.println("Not a file I understand");
                }
            }
            else 
            {
                Toybox.System.println("Failed " + responseCode);
            }
        }

        function onNextPage() as Boolean
        {
            _eventRegistry.onNextWaypoint();
            return true;
        }

        function onPreviousPage() as Boolean
        {
            _eventRegistry.onPreviousWaypoint();
            return true;
        }
    }
}