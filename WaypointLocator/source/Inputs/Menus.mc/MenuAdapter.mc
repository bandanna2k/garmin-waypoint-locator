import Toybox.WatchUi;
import Toybox.Lang;
import Routes;
import Toybox.Application.Storage;

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
            return Utilities.isEnabled(Storage.getValue("ripleyMode.enabled"));
        }
        function toggleRipleyMode() 
        {
            if(Utilities.isEnabled(Storage.getValue("ripleyMode.enabled")))
            {
                Storage.setValue("ripleyMode.enabled", "false");
            }
            else
            {
                Storage.setValue("ripleyMode.enabled", "true");
            }
        }
    }
}}