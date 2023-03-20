import Toybox.Math;
import Toybox.Lang;

module Drawing
{
    const DRAWING_TYPE_COMPUTER = 0;
    const DRAWING_TYPE_SCHOOL = 1;
    
    class Rotator
    {
        var _drawingTypeMultiplier;

        function initialize(drawingType as Number)
        {
            if(drawingType == DRAWING_TYPE_COMPUTER)
            {
               _drawingTypeMultiplier = 1;
            }
            else
            {
               _drawingTypeMultiplier = -1;
            }
        }

        function rotate(
            points as Array<Array<Numeric>>, 
            origin as Array<Numeric>,
            bearing as Numeric) as Void
        {
            var angle;
            angle = bearing * _drawingTypeMultiplier;

            var cos = Math.cos(Math.toRadians(angle));
            var sin = Math.sin(Math.toRadians(angle));

            var originX = origin[0];
            var originY = origin[1];

            for(var i = 0 ; i < points.size(); i++)
            {
                var x = points[i][0];
                var y = points[i][1];

                var newX = (((x - originX) * cos) - (y - originY) * sin) + originX;
                var newY = (((x - originX) * sin) + (y - originY) * cos) + originY; 
                
                points[i][0] = newX;
                points[i][1] = newY;
            }
        }
    }
}