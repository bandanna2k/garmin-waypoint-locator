import Toybox.WatchUi;
import Toybox.Lang;
import Routes;

module Inputs { module Menus 
{
    class MenuAdapter
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

        function onRouteSelect(selection as Number)
        {
            _routeRepository.selectRoute(selection);
        }

        function routeTitle(index as Number) as String
        {
            return _routeRepository.routeTitle(index);
        }
    }
}}