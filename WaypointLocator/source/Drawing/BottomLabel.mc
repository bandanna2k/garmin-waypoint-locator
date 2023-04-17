import Toybox.Lang;
import Toybox.Graphics;
import Toybox.System;

module Drawing
{
    class BottomLabel
    {
        var _text;

        function draw(dc as Dc) as Void
        {
            if(_text != null)
            {
                var w = dc.getWidth();
                var h = dc.getHeight();
                dc.drawText(w / 2, h - 35, Graphics.FONT_LARGE, 
                    _text, Graphics.TEXT_JUSTIFY_CENTER);
            }
        }

        function setText(text as String or Null)
        {
            _text = text;
        }
    }
}