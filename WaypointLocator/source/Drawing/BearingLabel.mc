import Toybox.Lang;
import Toybox.Graphics;
import Toybox.System;

module Drawing
{
    class BearingLabel extends Events
    {
        var _waypointBearing;

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
                var waypointBearing = _waypointBearing.format("%03d") + "°";
                dc.drawText(w / 2, h - 35, Graphics.FONT_LARGE, 
                    waypointBearing, Graphics.TEXT_JUSTIFY_CENTER);
            }
        }

        function onWaypointBearing(bearing as Numeric or Null)
        {
            _waypointBearing = bearing;
        }

        function areValuesSet() as Boolean
        {
            return _waypointBearing != null;
        }
    }
}