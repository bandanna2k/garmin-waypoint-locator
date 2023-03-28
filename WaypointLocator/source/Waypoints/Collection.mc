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
        
        var _requesting = false;
        var _source;
        var _destination;

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

        function importCollection(source as String, destination as String) as Void
        {
            if(_requesting)
            {
                Logging.warning("Already requesting."); 
                return;
            }

            _requesting = true;
            _source = source;
            _destination = destination;

            Logging.info("Source:" + source + ", Destination:" + destination); 

            var options = {
                :method => Communications.HTTP_REQUEST_METHOD_GET,
                :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
            };
            var url = _repository + source + ".json";
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
                    var route = Routes.instanceOf(data);
                    Logging.info(route.toString());

                    //saveRoute(_destination, data);
                }   
                else
                {
                    Logging.error("Not a file I understand. Response code:" + responseCode + ", Data:" + data);
//                _eventRegistry.onMessage(message);
                }
            }
            else 
            {
                var message = "Failed " + responseCode;
//                _eventRegistry.onMessage(message);
                Logging.error(message);
            }

            _source = null;
            _destination = null;
            _requesting = false;
        }

        function saveRoute(destination as String, data as Dictionary)
        {
            var prefix = "route." + destination;
            
            // Clear route
            var count = Storage.getValue(prefix + ".count");
            Logging.debug("Clearing route. Count:" + count);
            if(null != count)
            {
                for(var i = 0; i < count; i++)
                {
                    Storage.deleteValue(prefix + "." + i + ".name");
                    Storage.deleteValue(prefix + "." + i + ".latitude");
                    Storage.deleteValue(prefix + "." + i + ".longitude");
                }
            }

            var listOfWaypoints = [] as Array<Waypoint>;
            var waypoints = data.get("waypoints") as Array;
            for(var i = 0 ; i < waypoints.size(); i++)
            {
                listOfWaypoints.add(Waypoints.toWaypointFromDictionary(waypoints[i]));
            }

            // Save route
            var countOfWaypoints = listOfWaypoints.size();
            Storage.setValue(prefix + ".count", countOfWaypoints);
            Logging.debug("Saving route. Count:" + countOfWaypoints);
            for(var i = 0; i < countOfWaypoints; i++)
            {
                var waypoint = listOfWaypoints[i];
                Storage.setValue(prefix + "." + i + ".title", waypoint.title());
                Storage.setValue(prefix + "." + i + ".latitude", Utilities.latitude(waypoint.position()));
                Storage.setValue(prefix + "." + i + ".longitude", Utilities.longitude(waypoint.position()));
            }
            Logging.debug("Route saved.");
        }
    }
}