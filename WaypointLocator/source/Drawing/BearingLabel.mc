import Toybox.Lang;
import Toybox.Graphics;
import Toybox.System;

module Drawing
{
    class BearingLabel extends Events
    {
        var _compassHeading;
        var _waypointBearing;
        var _counter = 0;

        function initialize()
        {
            Events.initialize();
        }

        function draw(dc as Dc) as Void
        {
            if(areValuesSet())
            {
                var w = dc.getWidth();
                var h = dc.getHeight();
                var waypointBearing = _waypointBearing.format("%03d");
                dc.drawText(w / 2, h - 35, Graphics.FONT_LARGE, 
                    waypointBearing + " " + _counter, Graphics.TEXT_JUSTIFY_CENTER);
            }
        }

        function onWaypointBearing(bearing as Numeric) as Void
        {
            _waypointBearing = bearing;
            _counter = Utilities.mod(_counter + 1, 100); 
        }

        function onCompassHeading(heading as Numeric) as Void
        {
            _compassHeading = heading;
            _counter = Utilities.mod(_counter + 1, 100); 
        }

        function areValuesSet() as Boolean
        {
            return _waypointBearing != null && _compassHeading != null;
        }
    }
}