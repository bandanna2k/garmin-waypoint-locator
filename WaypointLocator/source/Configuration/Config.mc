import Toybox.Lang;
import Toybox.Application.Storage;
import Logging;

module Configuration
{
    const ACTIVITY_TYPE_CYCLE = 0;
    const ACTIVITY_TYPE_RUN = 1;
    const ACTIVITY_TYPE_HIKE = 2;

    class Config
    {
        var _activityType;
        var _isRipleyMode;

        function load()
        {
            _activityType = Storage.getValue("activityType");
Logging.debug("Loaded activity type: " + _activityType);
            if(_activityType == null)
            {
                setActivityType(Configuration.ACTIVITY_TYPE_CYCLE);
            }

            _isRipleyMode = Storage.getValue("ripleyMode.enabled");
Logging.debug("Loaded ripley mode: " + _isRipleyMode);
            if(_isRipleyMode == null)
            {
                _isRipleyMode = true;
                save();
            }
        }

        function save()
        {
            Storage.setValue("activityType", _activityType);
Logging.debug("Saved activity type: " + _activityType);

            Storage.setValue("ripleyMode.enabled", _isRipleyMode);
Logging.debug("Saved ripley mode: " + _isRipleyMode);
        }

        function setActivityType(type as Number) 
        {
            _activityType = type;
            save();
        }

        function toggleRipleyMode()
        {
            _isRipleyMode = !_isRipleyMode;
            save();
        }

        function isRipleyModeEnabled() as Boolean
        {
            return _isRipleyMode;
        }
    }
}