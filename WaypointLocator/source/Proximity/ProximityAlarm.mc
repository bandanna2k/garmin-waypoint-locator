import Distance;
import Toybox.Lang;
import Toybox.Math;
import Toybox.Attention;
import Proximity;

module Proximity
{
    class ProximityAlarm extends Events
    {
        const _vibe = [ new Attention.VibeProfile(25, 150) ];
        const _tone = [ new Attention.ToneProfile(2000, 150) ];

        var _delta = 1000000;
        var _counter = _delta;

        function initialize(eventRegistry as EventRegistry)
        {
            Events.initialize();
            _eventRegistry = eventRegistry;
            _eventRegistry.register(self);
        }

        function onWaypointProximity(proximity as Proximity) as Void
        {
            if(proximity == Proximity.FarAway)             { _delta = 1000000 * 4; }
            else if(proximity == Proximity.GettingClose)   { _delta = 20 * 4; }
            else if(proximity == Proximity.FairlyClose)    { _delta = 10 * 4; }
            else if(proximity == Proximity.Close)          { _delta = 3 * 4; }
            else if(proximity == Proximity.VeryClose)      { _delta = 1 * 4; }
            else if(proximity == Proximity.ExtremelyClose) { _delta = 1 * 1; }

            _counter = Utilities.min(_delta, _counter);
        }

        function onFastPulse() as Void
        {
            _counter--;
            if(_counter <= 0)
            {
                alert();
                _counter = _delta;
            }
        }

        function alert() as Void
        {
            Attention.playTone({:toneProfile=>_tone});
            Attention.vibrate(_vibe);
        }
    }
}