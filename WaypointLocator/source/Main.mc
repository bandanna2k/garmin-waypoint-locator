import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;
import Toybox.Attention;
import Waypoints;

class Main extends Application.AppBase 
{
    const _vibe = [ new Toybox.Attention.VibeProfile(25, 250) ];

    var _counter = 0;
    var _bearing = 0;

    var _arrowHead = new Drawing.ArrowHead();
    var _bearingLabel = new Drawing.BearingLabel();
    var _distanceLabel = new Drawing.DistanceLabel();
    var _waypointLabel = new Drawing.WaypointLabel();

    var _waypointTracker = new Waypoints.WaypointTracker(
        new Method(self, :onCurrentWaypoint),
        new Method(self, :onWaypointValues));

    var _view = new MainView(_arrowHead, _bearingLabel, _distanceLabel, _waypointLabel);

    var _currentPosition;
    var _currentWaypoint;
    var _data;

    function initialize() 
    {
        AppBase.initialize();

        // _currentPosition = new Position.Location({
        //         :latitude => -36.9, 
        //         :longitude => 174.7, 
        //         :format => :degrees
        //     });

        _waypointTracker.addWaypoint(
            "Waypoint 1",
            new Position.Location({
                :latitude => -36.89442018242911, 
                :longitude => 174.78806550227148, 
                :format => :degrees
            }));
        _waypointTracker.addWaypoint(
            "Waypoint 2",
            new Position.Location({
                :latitude => -36.89750395214885, 
                :longitude => 174.78971581679005, 
                :format => :degrees
            }));
        _waypointTracker.addWaypoint(
            "Britomart",
            new Position.Location({
                :latitude => -36.83994648776584, 
                :longitude => 174.76830573854085, 
                :format => :degrees
            }));
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void 
    {
        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
        Attention.playTone(Attention.TONE_KEY);
        
        var timer = new Toybox.Timer.Timer();
        timer.start(method(:onTimer), 1000, true);

        // System.println("Output goes here");
    }

    function onTimer() as Void
    {
        _counter = _counter + 1;
        if(_counter == 10)
        {
            onAttention();
            _counter = 0;
        }
    }

    function onAttention() as Void
    {
        Attention.vibrate(_vibe);
    }

    function fireBearing(bearing as Numeric) as Void
    {
        _arrowHead.bearing(bearing);
        _bearingLabel.bearing(bearing);
    }

    function fireDistance(distance as Numeric) as Void
    {
        _distanceLabel.setDistance(distance);
    }

    function onCurrentWaypoint(waypoint as Waypoint) as Void
    {
        _currentWaypoint = waypoint;

        // System.println("onCurrentWaypoint " + 
        //     " X " + Utilities.longitude(_currentWaypoint.position()) + 
        //     ", Y " + Utilities.latitude(_currentWaypoint.position()));

        updateWaypointOrPosition();
    }

    function onWaypointValues(
        displayIndex as Number,
        waypointCount as Number) as Void
    {
        _waypointLabel.setValues(displayIndex, waypointCount);
        WatchUi.requestUpdate();        
    }

    function onPosition(info as Toybox.Position.Info) as Void
    {
        _currentPosition = info.position;

//        System.println("onPosition: X " + Utilities.longitude(_currentPosition) + ", Y " + Utilities.latitude(_currentPosition));

        updateWaypointOrPosition();
    }

    function updateWaypointOrPosition() as Void
    {
        if(_currentWaypoint == null)
        {
            fireBearing(0);
            return;
        }
        if(_currentPosition == null)
        {
            fireBearing(0);
            return;
        }

        var bearing = Bearing.bearing(_currentPosition, _currentWaypoint.position());
        fireBearing(bearing);

        var distance = DistanceCalculator.distance(_currentPosition, _currentWaypoint.position());
        fireDistance(distance.kilometres());

        WatchUi.requestUpdate();
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void 
    {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ 
            _view,
            _waypointTracker
        ] as Array<Views or InputDelegates>;
    }

    function getApp() as Main {
        return Application.getApp() as Main;
    }
}