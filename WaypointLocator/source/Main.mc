import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;
import Toybox.Attention;
import Waypoints;
import Menu;

class Main extends Application.AppBase 
{
    const _vibe = [ new Toybox.Attention.VibeProfile(25, 250) ];

    var _eventRegistry = new EventRegistry();
    var _waypointLocator = new WaypointLocator(_eventRegistry);
    var _view = new WaypointLocatorView(_eventRegistry);

    var _counter = 0;

    function initialize() 
    {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void 
    {
        _eventRegistry.onStart();
    }

    function onTimer() as Void
    {
        _counter = _counter + 1;
        if(_counter == 10)
        {
            onAttention();
            _counter = 0;
        }

        _eventRegistry.onPulse();
    }

    function onAttention() as Void
    {
        Attention.vibrate(_vibe);
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void 
    {
    }

    // Return the initial view of your application here
    // Views first
    // Input delegates after
    function getInitialView() as Array<Views or InputDelegates>? 
    {
        return [ 
            _view,
            new MenuBehaviourDelegate(_eventRegistry),
            _waypointLocator.waypointTracker()
        ] as Array<Views or InputDelegates>;
    }

    function getApp() as Main 
    {
        return Application.getApp() as Main;
    }
}