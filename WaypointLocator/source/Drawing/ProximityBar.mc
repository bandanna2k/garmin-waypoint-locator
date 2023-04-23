import Toybox.Graphics;
import Toybox.Lang;

module Drawing
{
    class ProximityBar extends Events
    {
        const maxBars = 5;
        const barHeight = 3;
        const barWidth = 15;
        const seperator = 2;
        const startY = ((maxBars / 2).toNumber()) * barHeight + seperator; 

        var _value = 0;
        
        function initialize()
        {
            Events.initialize();
        }

        function draw(dc as Dc) as Void
        {
            var halfY = dc.getHeight() / 2;
            var y = halfY + startY;
            for(var i = 0; i < _value && i < maxBars; i++)
            {
                dc.fillRectangle(10, y, barWidth, barHeight);
                y = y - seperator - barHeight;
            }
        }

        function onWaypointProximity(proximity as Number) as Void
        {
            if(proximity == Proximity.FAR_AWAY) { _value = 0; return; }
            if(proximity == Proximity.GETTING_CLOSE) { _value = 1; return; }
            if(proximity == Proximity.FAIRLY_CLOSE) { _value = 2; return; }
            if(proximity == Proximity.CLOSE) { _value = 3; return; }
            if(proximity == Proximity.VERY_CLOSE) {  _value = 4; return; }
            if(proximity == Proximity.EXTREMELY_CLOSE) { _value = 5; return; }
        }
    }
}