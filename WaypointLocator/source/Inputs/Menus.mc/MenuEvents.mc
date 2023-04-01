import Toybox.WatchUi;
import Toybox.Lang;
import Routes;

module Inputs { module Menus 
{
    class MenuEvents
    {
        var _routeRepository;

        function initialize(routeRepository as Repository)
        {
            _routeRepository = routeRepository;
        }

        function onRouteImport(source as String, destination as Number)
        {
            _routeRepository.importRouteFromWeb(source, destination);
        } 
    }
}}