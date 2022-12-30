import Toybox.Lang;
import Toybox.Graphics;

module Drawing
{
    class DistanceLabel
    {
        var _dist = 0;

        function draw(dc as Dc)
        {
            var w = dc.getWidth();
            var text = _dist.format("%0.2f");
            dc.drawText(w - 32, 15, Graphics.FONT_MEDIUM, text, Graphics.TEXT_JUSTIFY_CENTER);
        }

        function setDistance(value as Numeric)
        {
            _dist = value;
        }    
    }
}