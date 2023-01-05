import Toybox.Lang;
import Toybox.Graphics;
import Distance;

module Drawing
{
    class DistanceLabel extends Events
    {
        var _dist;

        function initialize()
        {
            Events.initialize();
        }

        function draw(dc as Dc)
        {
            if(_dist == null)
            {
                return;
            }

            var w = dc.getWidth();
            var text;
            if(_dist.metres() < 1000)
            {
                text = _dist.metres().format("%3.0f");
            }
            else
            {
                text = _dist.kilometres().format("%0.2f");
            }
            dc.drawText(w - 32, 15, Graphics.FONT_MEDIUM, text, Graphics.TEXT_JUSTIFY_CENTER);
        }

        function onDistance(value as DistanceValue or Null) as Void
        {
            _dist = value;
        }    
    }
}