import Toybox.Lang;
import Toybox.Application.Storage;
import Logging;

module Configuration
{
    class ConfigFilter extends NoopConfigFilter
    {
        var _config;

        function initialize(
            config as Config,
            events as Events)
        {
            NoopConfigFilter.initialize(events);
            _config = config;
        }

        function onWaypointProximity(proximity as Number)
        {
            if(_config.isRipleyModeEnabled())
            {
                _events.onWaypointProximity(proximity);
            }
            else
            {
                _events.onWaypointProximity(Proximity.FAR_AWAY);
            }
        }
    }
}