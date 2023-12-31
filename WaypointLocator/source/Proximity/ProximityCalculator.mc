import Distance;
import Toybox.Lang;
import Proximity;

module Proximity
{
    class ProximityCalculator extends Events
    {
        var _eventRegistry;

        /*
        Getting close       1000 metres   1 km
        Fairly close        500 metres    0.5 km
        Close               100 metres    0.1 km
        Very Close          50 metres     0.05 km
        Extremely Close     25 metres     0.025 km
        */

        const PROXIMITY_GETTING_CLOSE = 1000;
        var   _proximityGettingClose;

        const PROXIMITY_FAIRLY_CLOSE = 500;
        var   _proximityFairlyClose;

        const PROXIMITY_CLOSE = 100;
        var   _proximityClose;

        const PROXIMITY_VERY_CLOSE = 50;
        var   _proximityVeryClose;

        const PROXIMITY_EXTREMELY_CLOSE = 25;
        var   _proximityExtremelyClose;

        var _proximity;

        function initialize(eventRegistry as EventRegistry)
        {
            Events.initialize();
            _eventRegistry = eventRegistry;
            _eventRegistry.register(self);

            resetCounters();
        }

        function resetCounters()
        {
            _proximity = Proximity.FAR_AWAY;

            _proximityGettingClose = 0;
            _proximityFairlyClose = 0;
            _proximityClose = 0;
            _proximityVeryClose = 0;
            _proximityExtremelyClose = 0;
        }

        function onDistance(value as DistanceValue or Null) as Void
        {
            if(value == null)
            {
                return;
            }
Logging.trace("ProximityCalculator.onDistance " + value);

            var metres = value.metres();
            if(metres <= PROXIMITY_EXTREMELY_CLOSE)
            {
                updateState(Proximity.EXTREMELY_CLOSE);
            }
            else if(metres <= PROXIMITY_VERY_CLOSE)
            {
                updateState(Proximity.VERY_CLOSE);
            }
            else if(metres <= PROXIMITY_CLOSE)
            {
                updateState(Proximity.CLOSE);
            }
            else if(metres <= PROXIMITY_FAIRLY_CLOSE)
            {
                updateState(Proximity.FAIRLY_CLOSE);
            }
            else if(metres <= PROXIMITY_GETTING_CLOSE)
            {
                updateState(Proximity.GETTING_CLOSE);
            }
            else
            {
                updateState(Proximity.FAR_AWAY);
            }
        }

        function onCurrentWaypoint(currentWaypoint)
        {
            resetCounters();
        }

        function updateState(proximity as Number) as Void
        {
            if(_proximity == proximity)
            {
                return;
            }
            _proximity = proximity;
            _eventRegistry.onWaypointProximity(_proximity);
        }
    }
}