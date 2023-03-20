import Toybox.Graphics;
import Toybox.Lang;

module Drawing
{
    class ArrowHead extends Events
    {
        var _bearing;
        var _compassHeading;
        var _bearingToCompassHeading;
        var _rotator;

        function initialize()
        {
            Events.initialize();
            _rotator = new Rotator(DRAWING_TYPE_COMPUTER);
        }

        function draw(dc as Dc) as Void
        {
            if(_bearingToCompassHeading == null)
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

            _rotator.rotate(pts, [ originX, originY ], _bearingToCompassHeading);

            return pts;
        }

        function onWaypointBearing(bearing as Numeric or Null) as Void
        {
            _bearing = bearing;
            calculateBearingToCompassHeading();
        }

        function onCompassHeading(heading as Numeric or Null) as Void
        {
            _compassHeading = heading;
            calculateBearingToCompassHeading();
        }        

        function calculateBearingToCompassHeading() as Void
        {
            if(_bearing == null || _compassHeading == null)
            {
                _bearingToCompassHeading = null;
            }
            else
            {
                _bearingToCompassHeading = Utilities.mod(360 - _compassHeading + _bearing, 360) ;
            }
        }
    }
}