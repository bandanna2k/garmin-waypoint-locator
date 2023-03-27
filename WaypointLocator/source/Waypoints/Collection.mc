import Toybox.Position;
import Toybox.Lang;
import Toybox.Application;
import Utilities;
import Logging;

module Waypoints
{
    class Collection
    {
        var _repository = "https://davidnorthtennis.com/waypoints/";

        function initialize()
        {
        }

        function currentSelection() as Waypoint or Null
        {
            return null;
        }

        function repository() as String
        {
            return _repository;
        }

        function importCollection(letter as String) as Void
        {
            var options = {
                :method => Communications.HTTP_REQUEST_METHOD_GET,
                :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
            };
            var url = _repository + letter + ".json";
            Communications.makeWebRequest(url, {}, options, method(:responseCallback));
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

                    var title = data.get("name") as String;
                    var waypoints = data.get("waypoints") as Array;
                    for(var i = 0 ; i < waypoints.size(); i++)
                    {
                        newWaypoints.add(Waypoints.toWaypointFromDictionary(waypoints[i]));
                    }

                    Logging.info("Title:" + title);
                    Logging.info("Waypoints:" + waypoints);
                }   
                else
                {
                    Logging.error("Not a file I understand. Response code:" + responseCode + ", Data:" + data);
                }
            }
            else 
            {
                var message = "Failed " + responseCode;
//                _eventRegistry.onMessage(message);
                Logging.error(message);
            }
        }
    }
}