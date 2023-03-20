import Toybox.Lang;
import Toybox.Graphics;
import Toybox.System;

module Drawing
{
    class BearingLabel extends Events
    {
        var _bearing;
        var _counter = 0;

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
            dc.drawText(w / 2, h - 35, Graphics.FONT_LARGE, bearing + " " + _counter, Graphics.TEXT_JUSTIFY_CENTER);
        }

        function onWaypointBearing(bearing as Numeric) as Void
        {
            _bearing = bearing;
        }
    }
}