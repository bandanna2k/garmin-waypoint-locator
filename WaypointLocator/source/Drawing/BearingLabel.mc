import Toybox.Lang;
import Toybox.Graphics;
import Toybox.System;

module Drawing
{
    class BearingLabel extends Events
    {
        var _bearing;
        var _heading;

        function initialize()
        {
            Events.initialize();
        }

        function draw(dc as Dc) as Void
        {
            if(_bearing == null)
            {
                return;
            }

            var w = dc.getWidth();
            var h = dc.getHeight();
            var bearing = _bearing.format("%03d");
            var heading;
            if(_heading == null)
            {
                heading = "";
            } 
            else
            {
                heading = _heading.format("%03d");
            }
            dc.drawText(w / 2, h - 35, Graphics.FONT_LARGE, bearing + " " + heading, Graphics.TEXT_JUSTIFY_CENTER);
        }

        function onBearing(bearing as Numeric) as Void
        {
            _bearing = bearing;
        }

        function onHeading(heading as Numeric or Null) as Void
        {
            _heading = heading;
        }
    }
}