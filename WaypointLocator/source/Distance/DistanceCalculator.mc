import Toybox.Lang;
import Toybox.Math;

module DistanceCalculator
{
    const _radians90 = Math.toRadians(90);

    function distance(
        positionA as Toybox.Position.Location, 
        positionB as Toybox.Position.Location) as Distance
    {
        var ninetyMinusLatA = _radians90 - Math.toRadians(Utilities.latitude(positionA));
        var ninetyMinusLatB = _radians90 - Math.toRadians(Utilities.latitude(positionB));
        var longAMinusLongB = Math.toRadians(Utilities.longitude(positionA) - Utilities.longitude(positionB));

        // System.println("A " + Math.cos(ninetyMinusLatA));
        // System.println("B " + Math.cos(ninetyMinusLatB));
        // System.println("C " + Math.sin(ninetyMinusLatA));
        // System.println("D " + Math.sin(ninetyMinusLatB));
        // System.println("E " + Math.cos(longAMinusLongB));

        var inner = 
          Math.cos(ninetyMinusLatA)
        * Math.cos(ninetyMinusLatB)
        + Math.sin(ninetyMinusLatA)
        * Math.sin(ninetyMinusLatB)
        * Math.cos(longAMinusLongB);

        var result = Math.acos(inner) * 6371000d;
        return Distance.fromMetres(result);
    }
}
