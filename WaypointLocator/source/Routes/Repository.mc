import Toybox.Position;
import Toybox.Lang;
import Toybox.Application;
import Utilities;
import Logging;
import Waypoints;

module Routes
{
    class Repository
    {
        var _repositoryUrl = "https://davidnorthtennis.com/waypoints/";
        
        var _isLocked = false;
        var _source;
        var _destination;

        var _eventRegistry;
        var _routes;

        function initialize(eventRegistry as EventRegistry)
        {
            _eventRegistry = eventRegistry;
            _routes = [];
            for(var i = 0; i < 10; i++)
            {
                var object = Routes.NULL_ROUTE;
                _routes.add(object);
            }
        }

        function importRoutesFromStorage()
        {
            Logging.debug("Importing routes from storage");
            for(var i = 0; i < 10; i++)
            {
                var route = importRouteFromStorage(i);
                _routes[i] = route;
            }
        }

        function importRouteFromStorage(index as Number) as Route
        {
            var prefix = "route." + index;
            var title = Storage.getValue(prefix + ".title");
            Logging.debug("Importing route from storage. Index:" + index + ", Title:" + title);
            if(title == null)
            {
                return Routes.NULL_ROUTE;
            }

            var countOfWaypoints = Storage.getValue(prefix + ".count");
            Logging.debug("Loading route. Count:" + countOfWaypoints);

            var listOfWaypoints = [];
            for(var i = 0; i < countOfWaypoints; i++)
            {
                var name = Storage.getValue(prefix + "." + i + ".name");
                var latitude = Storage.getValue(prefix + "." + i + ".latitude");
                var longitude = Storage.getValue(prefix + "." + i + ".longitude");
                var waypoint = new Waypoint(
                    title, 
                    new Location({
                        :latitude => latitude, 
                        :longitude => longitude, 
                        :format => :degrees
                    }));
                listOfWaypoints.add(waypoint);
            }

            var route = new Route(title, listOfWaypoints);
            Logging.debug("Route loaded. " + route);
            return route;
        }

        function selectRoute(index as Number)
        {
            var route = _routes[index];
            _eventRegistry.onRouteUpdate(route);
        }

        function route(index as Number) as Route
        {
            return _routes[index];
        }

        function currentSelection() as Route
        {
            return NULL_ROUTE;
        }

        function repositoryUrl() as String
        {
            return _repositoryUrl;
        }

        function importRouteFromWeb(source as String, destination as Number) as Void
        {
            if(_isLocked)
            {
                Logging.warning("Already requesting."); 
                return;
            }

            _isLocked = true;
            _source = source;
            _destination = destination;

            Logging.info("Source:" + source + ", Destination:" + destination); 

            var options = {
                :method => Communications.HTTP_REQUEST_METHOD_GET,
                :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
            };
            var url = _repositoryUrl + source + ".json";
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
                    _routes[_destination] = route;
                    Logging.info("Route imported: Destination:" + _destination + ", Route:" + route.toString());
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
            _isLocked = false;
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