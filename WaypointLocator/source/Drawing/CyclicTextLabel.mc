import Utilities.Text;
import Toybox.Lang;
import Toybox.System;
import Toybox.Graphics;

module Drawing
{
    class CyclicLabel
    {
        var _cyclicString;

        function initialize(cyclicString as CyclicString)
        {
            _cyclicString = cyclicString;
        }

        function draw(dc as Dc) as Void
        {
            var w = dc.getWidth();
            var h = dc.getHeight();
            dc.drawText(w / 2, h - 65, Graphics.FONT_MEDIUM, _cyclicString.get(), Graphics.TEXT_JUSTIFY_CENTER);
        }

        function cycle() as Void
        {
            _cyclicString.cycle();
        }
    }
}