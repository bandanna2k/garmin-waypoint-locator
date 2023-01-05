import Distance;
import Toybox.Lang;
import Proximity;

module Proximity
{
    const _vibe = [ new Toybox.Attention.VibeProfile(25, 250) ];

    class AutoNextWaypoint extends Events
    {
        function initialize(eventRegistry as EventRegistry)
        {
            Events.initialize();
            _eventRegistry = eventRegistry;
            _eventRegistry.register(self);
        }

        function onWaypointProximity(proximity as Proximity) as Void
        {
            if(proximity == Proximity.ExtremelyClose)
            {       
                Attention.playTone(Attention.TONE_KEY);
                Attention.vibrate(_vibe);
                _eventRegistry.onNextWaypoint();
            }
        }
    }
}