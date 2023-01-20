import Toybox.Lang;
import Toybox.Position;
import Test.Utilities;

module Test { module Integration
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

        function onBearing(bearing as Numeric or Null) as Void
        {
            _bearings.add(bearing);
        }
        function assertNoBearing()
        {
            _bearings.assertNoMoreValues();
        }
        function assertBearing(bearing as Numeric or Null)
        {
            _bearings.assertValue(bearing);
        }

        function onHeading(heading as Numeric or Null) as Void
        {
            _headings.add(heading);
        }
    }
}}