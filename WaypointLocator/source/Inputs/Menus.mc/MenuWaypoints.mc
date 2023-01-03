import Toybox.WatchUi;
import Toybox.Lang;
import Waypoints;

module Inputs { module Menus
{        
    class MenuWaypoints extends Menu2
    {
        var _menuInput;
        var _selection = "";
        var _eventRegistry;

        function initialize(eventRegistry as EventRegistry)
        {
            Menu2.initialize({:title=>selectionString()});

            _eventRegistry = eventRegistry;

            addItem(new MenuItem("  0", null, "0", {}));
            addItem(new MenuItem("  1", null, "1", {}));
            addItem(new MenuItem("  2", null, "2", {}));
            addItem(new MenuItem("  3", null, "3", {}));
            addItem(new MenuItem("  4", null, "4", {}));
            addItem(new MenuItem(" Done", null, "itemDone", {}));
            _menuInput = new MenuInput(new Method(self, :onSelection));
        }

        function showMenu()
        {
            WatchUi.pushView(self, _menuInput, WatchUi.SLIDE_IMMEDIATE);
        }

        function selectionString() 
        {
            return "[" + _selection + "]    ";
        }

        function onSelection(selection as String) as Void
        {
            if("itemDone".equals(selection))
            {
                popView(WatchUi.SLIDE_IMMEDIATE);

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

            setTitle(selectionString());
            setFocus(0);
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
                        newWaypoints.add(Waypoints.toWaypointFromDictionary(waypoints[i]));
                    }

                    Waypoints.saveWaypoints(newWaypoints);
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
    }
}}