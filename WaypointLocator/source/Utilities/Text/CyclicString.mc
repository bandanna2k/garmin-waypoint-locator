import Toybox.Lang;
import Toybox.System;

module Utilities { module Text
{
    class CyclicString
    {
        var _fullText;
        var _partText;
        var _numberOfChars;
        var _counter;
        var _direction; // 1 = forward, -1 = backward

        function initialize(
            text as String,
            numberOfChars as Number)
        {
            _numberOfChars = numberOfChars;

            setText(text);
        }

        function get() as String
        {
            return _partText;
        }

        function cycle()
        {
            _counter++;
        }

        function setText(text as String) as Void
        {
            _counter = 0;
            _direction = 1;
            _fullText = text;

            calculatePartText();
        }

        function calculatePartText() as Void
        {
            if(_numberOfChars >= _fullText.length())
            {
                return;
            }

            _partText = _fullText.substring(_counter, _numberOfChars);
        }
    }
}}

