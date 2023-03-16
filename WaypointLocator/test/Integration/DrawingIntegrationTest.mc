import Test.Utilities.Assertions;
import Test.Integration.Support;
import Bearing;
import Drawing;
import Toybox.Lang;
import Toybox.Test;
import Toybox.System;
import Toybox.Position;
import Waypoints;

module Test { module Integration
{
    (:test) 
    function testDrawingArrowhead(logger as Logger) as Boolean 
    {
        var eventRegistry = new EventRegistry();
        var eventAssertions = new EventAssertions(eventRegistry);
        var waypointLocator = new WaypointLocator(eventRegistry);
        var bearingCalculator = new BearingCalculator(eventRegistry);
        var arrowHead = new ArrowHead();
        eventRegistry.register(arrowHead); // TODO: Why are we not creating and registering at the same time?

        // Assert waypoint bearing
        eventAssertions.assertNoWaypointBearing();
        eventRegistry.onCurrentPosition(new Location({
                            :latitude => -38.3, 
                            :longitude => 175.7, 
                            :format => :degrees
                            }));
        eventAssertions.assertWaypointBearing(null);
        eventRegistry.onCurrentWaypoint(new Waypoint("Waypoint 1", new Location({
                            :latitude => -38.3, 
                            :longitude => 180.0, 
                            :format => :degrees
                            })));
        eventAssertions.assertWaypointBearingWithTolerance(91, 0.5);

        // Assert compass heading
        var sensorInfo = new Toybox.Sensor.Info();
        sensorInfo.heading = -1.0471975512f;
        waypointLocator.onSensor(sensorInfo);
        eventAssertions.assertCompassHeadingWithTolerance(60, 1);

        // Assert arrowhead heading
        Assertions.areApproximatelyEquals(arrowHead._bearingToHeading, 60 + (91 - 60), 1);
        return true;
    }

    (:test)
    function testDrawingNorth(logger as Logger) as Boolean 
    {
        var eventRegistry = new EventRegistry();
        var eventAssertions = new EventAssertions(eventRegistry);
        var waypointLocator = new WaypointLocator(eventRegistry);
        var compass = new Compass();
        eventRegistry.register(compass); // TODO: Auto register

        var sensorInfo = new Toybox.Sensor.Info();
        sensorInfo.heading = -1.0471975512f;
        waypointLocator.onSensor(sensorInfo);

        eventAssertions.assertCompassHeadingWithTolerance(60, 1);
        Assertions.areApproximatelyEquals(compass._north, 300, 1);
        return true;
    }
}}