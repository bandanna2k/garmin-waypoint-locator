import Toybox.Lang;
import Toybox.Graphics;
import Toybox.System;
import Drawing;

module Drawing
{
    class Compass extends Events
    {
        var _north;
        var _rotator;

        function initialize()
        {
            Events.initialize();
            _rotator = new Rotator(DRAWING_TYPE_COMPUTER);
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
// Toybox.System.println("Compass.draw halfH " + halfH);
// Toybox.System.println("Compass.draw halfW " + halfW);

            var points = [[halfW, halfH - 100]];

// Toybox.System.println("Compass.draw 1 points " + points);
            _rotator.rotate(points, [halfW, halfH], _north);
// Toybox.System.println("Compass.draw 2 points " + points);

            dc.drawLine(halfW, halfH, (points as Array<Array<Numeric>>)[0][0], (points as Array<Array<Numeric>>)[0][1]);
        }

        function onCompassHeading(heading as Numeric or Null) as Void
        {
            _north = 360 - heading;
// Toybox.System.println("Compass.draw north " + _north + ", heading " + heading);
        }
    }
}