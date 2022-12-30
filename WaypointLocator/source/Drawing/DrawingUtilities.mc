import Toybox.Math;
import Toybox.Lang;

module DrawingUtilities
{
    function rotate(
        points as Array<Array<Numeric>>, 
        origin as Array<Numeric>,
        bearing as Numeric) as Void
    {
        var angle;
        //angle = 0 - bearing;    // School drawing, X left, Y up
        angle = bearing;        // Computer drawing, X left, Y down

        var cos = Math.cos(Math.toRadians(angle));
        var sin = Math.sin(Math.toRadians(angle));

        var originX = origin[0];
        var originY = origin[1];

        for(var i = 0 ; i < points.size(); i++)
        {
            var x = points[i][0];
            var y = points[i][1];
            // System.println("A" + x);
            // System.println("A " + y);

            var newX = (((x - originX) * cos) - (y - originY) * sin) + originX;
            var newY = (((x - originX) * sin) + (y - originY) * cos) + originY; 
            
            points[i][0] = newX;
            points[i][1] = newY;

            // System.println("B" + points[i][0]);
            // System.println("B " + points[i][1]);
        }
    }
}