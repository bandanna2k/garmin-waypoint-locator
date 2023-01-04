import Utilities.Test;
import Proximity;
import Toybox.Lang;
import Toybox.Test;
import Toybox.System;
import Distance;

module Proximity
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

        _eventRegistry.onDistance(DistanceValue.fromMetres(1001));
        Assertions.areEqual(_assertions.proximity(), null);

        // Getting close, but not yet
        _eventRegistry.onDistance(DistanceValue.fromMetres(1000));
        Assertions.areEqual(_assertions.proximity(), null);

        // Getting close
        _eventRegistry.onDistance(DistanceValue.fromMetres(1000));
        Assertions.areEqual(_assertions.proximity(), 1);

        // Fairly close, but not yet
        _eventRegistry.onDistance(DistanceValue.fromMetres(500));
        Assertions.areEqual(_assertions.proximity(), 1);

        // Fairly close
        _eventRegistry.onDistance(DistanceValue.fromMetres(500));
        Assertions.areEqual(_assertions.proximity(), 2);

        // Close, but not yet
        _eventRegistry.onDistance(DistanceValue.fromMetres(100));
        Assertions.areEqual(_assertions.proximity(), 2);

        // Close
        _eventRegistry.onDistance(DistanceValue.fromMetres(100));
        Assertions.areEqual(_assertions.proximity(), 3);

        // Very close, but not yet
        _eventRegistry.onDistance(DistanceValue.fromMetres(20));
        Assertions.areEqual(_assertions.proximity(), 3);

        // Very close
        _eventRegistry.onDistance(DistanceValue.fromMetres(20));
        Assertions.areEqual(_assertions.proximity(), 4);

        // Extremely close, but not yet
        _eventRegistry.onDistance(DistanceValue.fromMetres(10));
        Assertions.areEqual(_assertions.proximity(), 4);

        // Extremely close
        _eventRegistry.onDistance(DistanceValue.fromMetres(10));
        Assertions.areEqual(_assertions.proximity(), 5);

        return true;
    }

    class ProximityAssertions extends Events
    {
        var _proximity;

        function initialize()
        {
            Events.initialize();
        }

        function onWaypointProximity(proximity as Number) as Void
        {
            _proximity = proximity;
        }

        function proximity() as Number
        {
            return _proximity;
        }
    }
}