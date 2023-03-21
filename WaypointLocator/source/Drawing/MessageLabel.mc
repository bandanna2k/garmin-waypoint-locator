import Toybox.Graphics;
import Toybox.Lang;
import DataStructures;

module Drawing
{
    class MessageLabel extends Events
    {
        var _queueOfMessages = new Queue();
        var _message;
        var _counter = 0;

        function initialize()
        {
            Events.initialize();
        }

        function draw(dc as Dc) as Void
        {
            if(_message == null)
            {
                return;
            }

            var w = dc.getWidth();
            var h = dc.getHeight();

            var font = Graphics.FONT_LARGE;
            var dimensions = dc.getTextDimensions(_message, font);
            var textW = dimensions[0];
            var textH = dimensions[1];

            // Background box
            var boxX = (w / 2) - (textW / 2) - 10;
            var boxY = (h / 2);
            dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
            dc.fillRectangle(0, boxY, w, textH + 4);
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
            dc.fillRectangle(0, boxY + 1, w, textH + 2);
            
            // Draw text
            dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
            dc.drawText(w / 2, h / 2, font, _message, Graphics.TEXT_JUSTIFY_CENTER);
        }

        function onMessage(message as String) as Void
        {
            _queueOfMessages.enqueue(message);
        }

        function onPulse() as Void 
        {
            if(_message == null)
            {
                _message = _queueOfMessages.dequeue();
                _counter = 5;
            }
            else
            {
                _counter--;
                if(_counter == 0)
                {
                    _message = _queueOfMessages.dequeue();
                    _counter = 5;
                }
            }
        }
    }
}