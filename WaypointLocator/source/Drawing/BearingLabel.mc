import Toybox.Lang;
import Toybox.Graphics;
import Toybox.System;

module Drawing
{
    class BearingLabel extends Events
    {
        var _bearing;

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
            var string = _bearing.format("%03d");
            dc.drawText(w / 2, h - 35, Graphics.FONT_LARGE, string, Graphics.TEXT_JUSTIFY_CENTER);
        }

        function onBearing(bearing as Numeric) as Void
        {
            _bearing = bearing;
        }
    }
}