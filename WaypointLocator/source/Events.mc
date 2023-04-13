import Toybox.Position;
import Toybox.Lang;
import Waypoints;
import Distance;
import Routes;

class Events
{
   function onCurrentWaypoint(waypoint as Waypoint or Null) {}
   function onWaypointCounter(displayIndex as Number, displayCount as Number) {}
   function onWaypointBearing(bearing as Numeric or Null) {}
   function onDistance(value as DistanceValue or Null) {}
   function onCurrentPosition(currentPosition as Location or Null) {}
   function onStart() {}
   function onStop() {}
   function onPulse() {}
   function onCompassHeading(heading as Numeric or Null) {}
   function onNextWaypoint() {}
   function onPreviousWaypoint() {}
   function onWaypointProximity(proximity as Proximity) {}
   function onWaypointProximity2(proximity as Number) {}
   function onActivityInitiate() {}
   function onActivityStarted() {}
   function onActivityStopped() {}
   function onActivitySaved() {}
   function onMessage(message as String) {}
   function onRouteUpdate(route as Route) {}
}