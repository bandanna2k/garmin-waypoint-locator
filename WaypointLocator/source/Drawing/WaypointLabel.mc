import Toybox.Lang;
import Toybox.Graphics;
import Toybox.System;

module Drawing
{
    class WaypointLabel
    {
        var _displayIndex = -1;
        var _waypointCount;

        function draw(dc as Dc) as Void
        {
            var text;
            if(_displayIndex == -1)
            {
                text = "-";
            }
            else
            {
                text = _displayIndex + " / " + _waypointCount;
            }

            var w = dc.getWidth();
            dc.drawText(w / 3, 15, Graphics.FONT_SMALL, text, Graphics.TEXT_JUSTIFY_CENTER);
        }

        function setValues(
            displayIndex as Number,
            waypointCount as Number)
        {
            _displayIndex = displayIndex;
            _waypointCount = waypointCount;    
        }
    }
}