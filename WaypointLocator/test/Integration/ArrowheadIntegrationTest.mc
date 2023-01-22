import Test.Utilities.Assertions;
import Toybox.Lang;
import Toybox.Test;
import Toybox.System;
import Toybox.Position;
import Waypoints;

module Test { module Integration
{
    (:test) 
    function testArrowhead(logger as Logger) as Boolean 
    {
        var eventRegistry = new EventRegistry();
        var eventAssertions = new EventAssertions(eventRegistry);
        var waypointLocator = new WaypointLocator(eventRegistry);

        eventAssertions.assertNoBearing();
        eventRegistry.onHeading(90);
        eventRegistry.onCurrentPosition(new Location({
                            :latitude => -38.3, 
                            :longitude => 175.7, 
                            :format => :degrees
                            }));
        eventAssertions.assertBearing(null);
        eventRegistry.onCurrentWaypoint(new Waypoint("Waypoint 1", new Location({
                            :latitude => -38.3, 
                            :longitude => 180.0, 
                            :format => :degrees
                            })));
        eventAssertions.assertBearingWithTolerance(91, 0.5);

        return true;
    }
}}