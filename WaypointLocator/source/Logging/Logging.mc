import Toybox.WatchUi;
import Toybox.Lang;
import Waypoints;
import Toybox.System;

module Logging
{        
    const LOGGING_LEVEL_TRACE = 0;
    const LOGGING_LEVEL_DEBUG = 1;
    const LOGGING_LEVEL_INFO = 2;

    var _loggingLevel = LOGGING_LEVEL_INFO;

    function setLoggingLevel(loggingLevel as Number) as Void
    {
        _loggingLevel = loggingLevel;
    }

    function trace(message as String) as Void
    {
        if(_loggingLevel <= LOGGING_LEVEL_TRACE)
        {
            System.println("TRACE: " + message);
        }
    }

    function debug(message as String) as Void
    {
        if(_loggingLevel <= LOGGING_LEVEL_DEBUG)
        {
            System.println("DEBUG: " + message);
        }
    }
}