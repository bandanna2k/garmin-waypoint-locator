import Distance;
import Toybox.Lang;
import Proximity;

module Proximity
{
    class AutoNextWaypoint extends Events
    {
        const _vibe = [ new Toybox.Attention.VibeProfile(25, 250) ];
        
        var _counter = 0;

        function initialize(eventRegistry as EventRegistry)
        {
            Events.initialize();
            _eventRegistry = eventRegistry;
            _eventRegistry.register(self);
        }

        function onWaypointProximity(proximity as Proximity) as Void
        {
            if(proximity == Proximity.ExtremelyClose && _counter == 0)
            {      
                _counter = 10;
            }
        }

        function gotoNextWaypoint()
        {
            Attention.playTone(Attention.TONE_CANARY);
            _eventRegistry.onNextWaypoint();
        }

        function onPulse()
        {
            if(_counter == 0)
            {
                // Do nothing
                return;
            }
            if(_counter == 1)
            {
                gotoNextWaypoint();
                _counter = 0;
                return;
            }
            _counter--;
        }
    }
}