import Test.Utilities.Assertions;
import Proximity;
import Toybox.Lang;
import Toybox.Test;
import Toybox.System;
import Distance;

module Test { module Proximity
{
    var _eventRegistry = new EventRegistry();
    var _proximityCalculator = new ProximityCalculator(_eventRegistry);
    var _assertions = new ProximityAssertions();

    (:test) 
    function testProximity(logger as Logger) as Boolean 
    { 
        _eventRegistry.register(_assertions);

        // Not close
        _eventRegistry.onDistance(DistanceValue.fromMetres(1001));
        Assertions.areEqual(_assertions.proximity(), null);

        _eventRegistry.onDistance(DistanceValue.fromMetres(1001));
        Assertions.areEqual(_assertions.proximity(), null);

        // Getting close
        _eventRegistry.onDistance(DistanceValue.fromMetres(1000));
        Assertions.areEqual(_assertions.proximity(), Proximity.GETTING_CLOSE);

        // Fairly close
        _eventRegistry.onDistance(DistanceValue.fromMetres(500));
        Assertions.areEqual(_assertions.proximity(), Proximity.FAIRLY_CLOSE);

        // Close
        _eventRegistry.onDistance(DistanceValue.fromMetres(100));
        Assertions.areEqual(_assertions.proximity(), Proximity.CLOSE);

        // Very close
        _eventRegistry.onDistance(DistanceValue.fromMetres(50));
        Assertions.areEqual(_assertions.proximity(), Proximity.VERY_CLOSE);

        // Extremely close
        _eventRegistry.onDistance(DistanceValue.fromMetres(25));
        Assertions.areEqual(_assertions.proximity(), Proximity.EXTREMELY_CLOSE);

        // Very close
        _eventRegistry.onDistance(DistanceValue.fromMetres(50));
        Assertions.areEqual(_assertions.proximity(), Proximity.VERY_CLOSE);

        // Close
        _eventRegistry.onDistance(DistanceValue.fromMetres(100));
        Assertions.areEqual(_assertions.proximity(), Proximity.CLOSE);

        // Getting close
        _eventRegistry.onDistance(DistanceValue.fromMetres(1000));
        Assertions.areEqual(_assertions.proximity(), Proximity.GETTING_CLOSE);

        // Not close
        _eventRegistry.onDistance(DistanceValue.fromMetres(1001));
        Assertions.areEqual(_assertions.proximity(), Proximity.FAR_AWAY);

        return true;
    }

    class ProximityAssertions extends Events
    {
        var _proximity;

        function initialize()
        {
            Events.initialize();
        }

        function onWaypointProximity(proximity as Number)
        {
            _proximity = proximity;
        }

        function proximity() as Number
        {
            return _proximity;
        }
    }
}}