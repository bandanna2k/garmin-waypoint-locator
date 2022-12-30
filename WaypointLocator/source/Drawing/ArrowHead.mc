import Toybox.Graphics;
import Toybox.Lang;

module Drawing
{
    class ArrowHead extends Events
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

            dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);

            var pts = points(dc.getWidth(), dc.getHeight());
            dc.fillPolygon(pts);
        }

        function points(width as Number, height as Number) as Array
        {
            var originX = (width / 2);
            var originY = (height / 2);

            var tipX = originX;
            var tipY = originY - 40;

            var backLeftX = originX - 20;
            var backLeftY = originY + 10;

            var backRightX = originX + 20;
            var backRightY = originY + 10;

            var pts = [
                [ originX, originY ],
                [ backRightX, backRightY ],
                [ tipX, tipY ],
                [ backLeftX, backLeftY ]
            ];

            DrawingUtilities.rotate(pts, [ originX, originY ], _bearing);

            return pts;
        }

        function onBearing(bearing as Numeric or Null) as Void
        {
            _bearing = bearing;
        }
    }
}