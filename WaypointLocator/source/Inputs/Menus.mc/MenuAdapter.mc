import Toybox.WatchUi;
import Toybox.Lang;
import Routes;
import Toybox.Application.Storage;
import Configuration;

module Inputs { module Menus 
{
    class MenuAdapter
    {
        var _routeRepository;
        var _config;

        function initialize(
            routeRepository as Repository,
            config as Config)
        {
            _routeRepository = routeRepository;
            _config = config;
        }

        function onRouteImport(source as String, destination as Number)
        {
            _routeRepository.importRouteFromWeb(source, destination);
        } 

        function onRouteSelect(selection as Number, inReverse as Boolean)
        {
            _routeRepository.selectRoute(selection, inReverse);
        }

        function routeTitle(index as Number) as String
        {
            return _routeRepository.routeTitle(index);
        }

        function isRipleyModeEnabled() as Boolean
        {
            return _config.isRipleyModeEnabled();
        }
        function toggleRipleyMode() 
        {
            _config.toggleRipleyMode();
        }
        function setActivityType(type as Number) 
        {
            _config.setActivityType(type);
        }
    }
}}