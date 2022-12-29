import Toybox.Lang;
import Toybox.System;
import Toybox.Graphics;

module Drawing
{
    class CyclicTextLabel
    {
        private var _numberOfChars;
        var _x;
        var _y;
        var _counter = 0;
        var _direction = 1; // 1 forward, -1 backward 
        var _fullText;
        var _partialText;

        function initialize(
            x as Number,
            y as Number,
            numberOfChars as Number)
        {
            _x = x;
            _y = y;
            numberOfChars = numberOfChars;
        }

        function draw(dc as Dc) as Void
        {
            
        }

        function cycle() as Void
        {

            setPartialText();
        }

        function setText(text as String) as Void
        {
            _counter = 0;
            _fullText = text;
            setPartialText();
        }

        function setPartialText()
        {
            if(_numberOfChars >= _fullText.length())
            {
                return;
            }
        }
    }
}