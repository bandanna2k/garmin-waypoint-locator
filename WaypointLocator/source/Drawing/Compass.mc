import Toybox.Lang;
import Toybox.Graphics;
import Toybox.System;
import Drawing;

module Drawing
{
    class Compass extends Events
    {
        var _north;

        function initialize()
        {
            Events.initialize();
        }

        function draw(dc as Dc) as Void
        {
            if(_north == null)
            {
                return;
            }

            var w = dc.getWidth();
            var h = dc.getHeight();
            var halfW = w / 2;
            var halfH = h / 2;

            var points = [[halfW, halfH - 100]];
            Drawing.rotate(points, [halfW, halfH], _north);

            dc.drawLine(halfW, halfH, (points as Array<Array<Numeric>>)[0][0], (points as Array<Array<Numeric>>)[0][1]);
        }

        function onCompassHeading(heading as Numeric or Null) as Void
        {
            _north = 360 - heading;
        }
    }
}