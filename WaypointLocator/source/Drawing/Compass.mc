import Toybox.Lang;
import Toybox.Graphics;
import Toybox.System;
import Drawing;

module Drawing
{
    class Compass extends Events
    {
        var _compassHeading;
        var _rotator;

        function initialize()
        {
            Events.initialize();
            _rotator = new Rotator(DRAWING_TYPE_COMPUTER);
        }

        function draw(dc as Dc) as Void
        {
            if(_compassHeading == null)
            {
                return;
            }

            var w = dc.getWidth();
            var h = dc.getHeight();
            var halfW = w / 2;
            var halfH = h / 2;

            var points = [[halfW, halfH - 100]];

            _rotator.rotate(points, [halfW, halfH], _compassHeading);

            dc.drawLine(halfW, halfH, (points as Array<Array<Numeric>>)[0][0], (points as Array<Array<Numeric>>)[0][1]);
        }

        function onCompassHeading(heading as Numeric or Null) as Void
        {
            _compassHeading = heading;
        }
    }
}