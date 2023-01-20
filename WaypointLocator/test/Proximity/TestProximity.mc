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
        Assertions.areEqual(_assertions.proximity(), 1);

        // Fairly close
        _eventRegistry.onDistance(DistanceValue.fromMetres(500));
        Assertions.areEqual(_assertions.proximity(), 2);

        // Close
        _eventRegistry.onDistance(DistanceValue.fromMetres(100));
        Assertions.areEqual(_assertions.proximity(), 3);

        // Very close
        _eventRegistry.onDistance(DistanceValue.fromMetres(50));
        Assertions.areEqual(_assertions.proximity(), 4);

        // Extremely close
        _eventRegistry.onDistance(DistanceValue.fromMetres(25));
        Assertions.areEqual(_assertions.proximity(), 5);

        // Very close
        _eventRegistry.onDistance(DistanceValue.fromMetres(50));
        Assertions.areEqual(_assertions.proximity(), 4);

        // Close
        _eventRegistry.onDistance(DistanceValue.fromMetres(100));
        Assertions.areEqual(_assertions.proximity(), 3);

        // Getting close
        _eventRegistry.onDistance(DistanceValue.fromMetres(1000));
        Assertions.areEqual(_assertions.proximity(), 1);

        // Not close
        _eventRegistry.onDistance(DistanceValue.fromMetres(1001));
        Assertions.areEqual(_assertions.proximity(), 0);

        return true;
    }

    class ProximityAssertions extends Events
    {
        var _proximity;

        function initialize()
        {
            Events.initialize();
        }

        function onWaypointProximity(proximity as Proximity) as Void
        {
            _proximity = proximity;
        }

        function proximity() as Number
        {
            return _proximity;
        }
    }
}}