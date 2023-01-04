import Distance;
import Toybox.Lang;

module Proximity
{
    class ProximityCalculator extends Events
    {
        var _eventRegistry;

        /*
        Getting close       1000 metres
        Fairly close        500 metres
        Close               100 metres
        Very Close          50 metres
        Extremely Close     10 metres
        */

        const PROXIMITY_GETTING_CLOSE = 1000;
        var   _proximityGettingClose;

        const PROXIMITY_FAIRLY_CLOSE = 500;
        var   _proximityFairlyClose;

        const PROXIMITY_CLOSE = 100;
        var   _proximityClose;

        const PROXIMITY_VERY_CLOSE = 50;
        var   _proximityVeryClose;

        const PROXIMITY_EXTREMELY_CLOSE = 10;
        var   _proximityExtremelyClose;

        var _state = 0;

        function initialize(eventRegistry as EventRegistry)
        {
            Events.initialize();
            _eventRegistry = eventRegistry;
            _eventRegistry.register(self);

            resetCounters();
        }

        function resetCounters()
        {
            _proximityGettingClose = 0;
            _proximityFairlyClose = 0;
            _proximityClose = 0;
            _proximityVeryClose = 0;
            _proximityExtremelyClose = 0;
        }

        function onDistance(value as DistanceValue or Null) as Void
        {
            var metres = value.metres();

            if(metres <= PROXIMITY_GETTING_CLOSE)
            {
                _proximityGettingClose++;
            }
            if(metres <= PROXIMITY_FAIRLY_CLOSE)
            {
                _proximityFairlyClose++;
            }
            if(metres <= PROXIMITY_CLOSE)
            {
                _proximityClose++;
            }
            if(metres <= PROXIMITY_VERY_CLOSE)
            {
                _proximityVeryClose++;
            }
            if(metres <= PROXIMITY_EXTREMELY_CLOSE)
            {
                _proximityExtremelyClose++;
            }

            if(_proximityExtremelyClose >= 2)
            {
                updateState(5);
            }
            else if(_proximityVeryClose >= 2)
            {
                updateState(4);
            }
            else if(_proximityClose >= 2)
            {
                updateState(3);
            }
            else if(_proximityFairlyClose >= 2)
            {
                updateState(2);
            }
            else if(_proximityGettingClose >= 2)
            {
                updateState(1);
            }
        }

        function updateState(state as Number) as Void
        {
            if(_state == state)
            {
                return;
            }
            _state = state;
            _eventRegistry.onWaypointProximity(_state);
        }
    }
}