import Toybox.Position;
import Toybox.Lang;
import Waypoints;
import Distance;

class Events
{
    function onCurrentWaypoint(waypoint as Waypoint or Null) as Void {}
    function onWaypointCounter(displayIndex as Number, displayCount as Number) as Void {}
    function onWaypointBearing(bearing as Numeric or Null) as Void {}
    function onDistance(value as DistanceValue or Null) as Void {}
    function onCurrentPosition(currentPosition as Location or Null) as Void {}
    function onStart() as Void {}
    function onStop() as Void {}
    function onPulse() as Void {}
    function onCompassHeading(heading as Numeric) as Void {}
    function onWaypoints(arrayOfWaypoints as Array<Waypoint>) as Void {}
    function onNextWaypoint() as Void {}
    function onPreviousWaypoint() as Void {}
    function onWaypointProximity(proximity as Proximity) as Void {}
    function onActivityNext() as Void {}
}