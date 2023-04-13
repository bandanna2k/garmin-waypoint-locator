import Toybox.Graphics;
import Toybox.Lang;

module Drawing
{
    class ArrowHead extends Events
    {
        var _compassHeading;
        var _waypointBearing;
        var _waypointBearingComparedToNorth;

        var _rotator;

        function initialize()
        {
            Events.initialize();
            _rotator = new Rotator(DRAWING_TYPE_COMPUTER);
        }

        function draw(dc as Dc) as Void
        {
            if(_waypointBearingComparedToNorth == null)
            {
                return;
            }

            //dc.drawCircle(dc.getWidth() / 2, dc.getHeight() / 2, 1);
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

            _rotator.rotate(pts, [ originX, originY ], _waypointBearingComparedToNorth);
            return pts;
        }

        function onWaypointBearing(bearing as Numeric or Null) as Void
        {
            _waypointBearing = bearing;
            calculate();
        }

        function onCompassHeading(heading as Numeric or Null)
        {
            _compassHeading = heading;
            calculate();
        }

        function calculate() as Void
        {
            if(_waypointBearing == null || _compassHeading == null)
            {
                _waypointBearingComparedToNorth = null;
                return;
            }

            _waypointBearingComparedToNorth = Utilities.mod(_compassHeading + _waypointBearing, 360);
        }
    }
}