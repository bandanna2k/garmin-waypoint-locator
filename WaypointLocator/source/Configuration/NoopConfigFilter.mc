import Toybox.Lang;
import Toybox.Application.Storage;
import Logging;

module Configuration
{
    class NoopConfigFilter extends Events
    {
        var _events;

        function initialize(events as Events)
        {
            Events.initialize();
            _events = events;
        }

        function onWaypointProximity(proximity as Number)
        {
            _events.onWaypointProximity(proximity);
        }

        function onPulse()
        {
            _events.onPulse();
        }
    }
}