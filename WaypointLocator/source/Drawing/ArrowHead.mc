import Toybox.Graphics;
import Toybox.Lang;

module Drawing
{
    class ArrowHead extends Events
    {
        var _bearing;
        var _heading;
        var _bearingToHeading;

        function initialize()
        {
            Events.initialize();
        }

        function draw(dc as Dc) as Void
        {
            if(_bearingToHeading == null)
            {
                dc.drawCircle(dc.getWidth() / 2, dc.getHeight() / 2, 1);
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

            Drawing.rotate(pts, [ originX, originY ], _bearingToHeading);

            return pts;
        }

        function onBearing(bearing as Numeric or Null) as Void
        {
            _bearing = bearing;
            calculateBearingToHeading();
        }

        function onHeading(heading as Numeric or Null) as Void
        {
            _heading = heading;
            calculateBearingToHeading();
        }        

        function calculateBearingToHeading() as Void
        {
            if(_bearing == null || _heading == null)
            {
                _bearingToHeading = null;
            }
            else
            {
                _bearingToHeading = Utilities.mod(_bearing - _heading + 360, 360);
            }
        }
    }
}