import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;
import Toybox.Attention;
import Waypoints;
import Inputs;
import Logging;
import Routes;

class Main extends Application.AppBase 
{
    var _eventRegistry = new EventRegistry();

    var _waypointLocator = new WaypointLocator(_eventRegistry);
    var _view = new WaypointLocatorView(_eventRegistry);
    var _routeRepository = Routes.createAndRegisterRepository(_eventRegistry);

    function initialize() 
    {
        AppBase.initialize();
     }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void 
    {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void 
    {
        _eventRegistry.onStop();
    }

    // Return the initial view of your application here
    // Views first
    // Input delegates after
    function getInitialView() as Array<Views or InputDelegates>? 
    {
        return [ 
            _view,
            new InitialScreenInputBehaviourWrapper(
                _eventRegistry,
                new InputBehaviour(_eventRegistry, _routeRepository))
        ] as Array<Views or InputDelegates>;
    }

    function getApp() as Main 
    {
        return Application.getApp() as Main;
    }
}