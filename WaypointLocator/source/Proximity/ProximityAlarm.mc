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
        const _finalTone = [ new Attention.ToneProfile(2000, 2000) ];

        var _delta = 1000000;
        var _counter = _delta;
        var _proximity = Proximity.FarAway;

        function initialize(eventRegistry as EventRegistry)
        {
            Events.initialize();
            _eventRegistry = eventRegistry;
            _eventRegistry.register(self);
        }

        function onWaypointProximity(proximity as Proximity) as Void
        {
            _proximity = proximity;

            if(proximity == Proximity.FarAway)             { _delta = 1000000; }
            else if(proximity == Proximity.GettingClose)   { _delta = 10; }
            else if(proximity == Proximity.FairlyClose)    { _delta = 5; }
            else if(proximity == Proximity.Close)          { _delta = 2; }
            else if(proximity == Proximity.VeryClose)      { _delta = 1; }
            else if(proximity == Proximity.ExtremelyClose) { _delta = 1; }

            _counter = Utilities.min(_delta, _counter);
        }

        function onPulse() as Void
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
            var tone;
            if(_proximity == Proximity.ExtremelyClose)
            {
                tone = _finalTone;
            }
            else
            {
                tone = _tone;
            }
            Attention.playTone({:toneProfile=>tone});
            Attention.vibrate(_vibe);
        }
    }
}