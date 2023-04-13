import Toybox.WatchUi;
import Toybox.Lang;
import Waypoints;
import Toybox.System;
import Toybox.Time;
import Toybox.Time.Gregorian;

module Logging
{        
    const LOGGING_LEVEL_TRACE = 0;
    const LOGGING_LEVEL_DEBUG = 1;
    const LOGGING_LEVEL_INFO = 2;
    const LOGGING_LEVEL_WARN = 3;
    const LOGGING_LEVEL_ERROR = 4;

    var _loggingLevel = LOGGING_LEVEL_DEBUG;
    var _startMillis = System.getTimer();

    function setLoggingLevel(loggingLevel as Number) as Void
    {
        _loggingLevel = loggingLevel;
    }

    function trace(message as String) as Void
    {
        if(_loggingLevel <= LOGGING_LEVEL_TRACE)
        {
            println("TRACE: " + message);
        }
    }

    function debug(message as String) as Void
    {
        if(_loggingLevel <= LOGGING_LEVEL_DEBUG)
        {
            println("DEBUG: " + message);
        }
    }

    function info(message as String) as Void
    {
        if(_loggingLevel <= LOGGING_LEVEL_INFO)
        {
            println("INFO: " + message);
        }
    }

    function warning(message as String) as Void
    {
        if(_loggingLevel <= LOGGING_LEVEL_WARN)
        {
            println("WARN: " + message);
        }
    }

    function error(message as String) as Void
    {
        if(_loggingLevel <= LOGGING_LEVEL_ERROR)
        {
            println("ERROR: " + message);
        }
    }

    function println(message as String)
    {
        var millis = Utilities.mod(System.getTimer() - _startMillis, 1000); 
        var millisAsString = millis.format("%03d");

        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var dateTime = Lang.format("$1$:$2$:$3$.$4$ $5$-$6$-$7$",
            [
                today.hour,
                today.min,
                today.sec,
                millisAsString,
                today.day,
                today.month,
                today.year
            ]
        );
        System.println(dateTime + ": " + message);
    }
}