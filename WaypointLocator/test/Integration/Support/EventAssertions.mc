import Toybox.Lang;
import Toybox.Position;
import Test.Utilities;

module Test { module Integration { module Support
{
    class EventAssertions extends Events
    {
        var _headings = new AssertionsList();
        var _bearings = new AssertionsList();

        function initialize(eventRegistry as EventRegistry)
        {
            Events.initialize();
            eventRegistry.register(self);
        }

        function onWaypointBearing(bearing as Numeric or Null) as Void
        {
            _bearings.add(bearing);
        }
        function assertNoWaypointBearing()
        {
            _bearings.assertNoMoreValues();
        }
        function assertWaypointBearing(bearing as Numeric or Null)
        {
            _bearings.assertValue(bearing);
        }
        function assertWaypointBearingWithTolerance(bearing as Numeric, tolerance as Numeric)
        {
            _bearings.assertValueWithTolerance(bearing, tolerance);
        }

        function onCompassHeading(heading as Numeric or Null) as Void
        {
            _headings.add(heading);
        }
        function assertNoCompassHeading()
        {
            _headings.assertNoMoreValues();
        }
        function assertCompassHeading(bearing as Numeric or Null)
        {
            _headings.assertValue(bearing);
        }
        function assertCompassHeadingWithTolerance(bearing as Numeric, tolerance as Numeric)
        {
            _headings.assertValueWithTolerance(bearing, tolerance);
        }
    }
}}}