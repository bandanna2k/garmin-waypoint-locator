import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Graphics;
import Logging;
import Configuration;

class WaypointLocatorView extends WatchUi.View  
{
    var _arrowHead = new Drawing.ArrowHead();
    var _bottomLabel = new Drawing.BottomLabel();
    var _distanceLabel = new Drawing.DistanceLabel();
    var _waypointLabel = new Drawing.WaypointLabel();
    var _compass = new Drawing.Compass();
    var _proximityBar = new Drawing.ProximityBar();
    var _messageLabel = new Drawing.MessageLabel();

    var _cyclicString = new Utilities.Text.CyclicString("Finding Newt (Waypoint Locator)", 18);
    var _cyclicLabel = new Drawing.CyclicLabel(_cyclicString);

    var _eventRegistry;

    function initialize(
        config as Config,
        eventRegistry as EventRegistry)
    {
        View.initialize();

        _eventRegistry = eventRegistry;
        _eventRegistry.register(_arrowHead);
        _eventRegistry.register(_distanceLabel);
        _eventRegistry.register(_waypointLabel);
        _eventRegistry.register(_cyclicLabel);
        _eventRegistry.register(_compass);
        _eventRegistry.register(new ConfigFilter(config, _proximityBar));
        _eventRegistry.register(_messageLabel);
        _eventRegistry.register(new Drawing.BottomLabelAdapter(method(:setBottomText)));
    }

    function setBottomText(text as Null or String) as Void
    {
        _bottomLabel.setText(text);
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void 
    {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void 
    {
    }

    // Update the view
/*
Instinct® 2 / Solar / Dual Power / dēzl Edition
176 x 176	semi-octagon	Transflective Liquid-Crystal (Single Color)	3.3.0

Instinct® 2S / Solar / Dual Power
163 x 156	semi-octagon	Transflective Liquid-Crystal (Single Color)	3.3.0
*/

    function onUpdate(dc as Dc) as Void 
    {
        if(_eventRegistry.hasStarted())
        {
            dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
            dc.clear();

            _compass.draw(dc);
            _bottomLabel.draw(dc);
            _arrowHead.draw(dc);
            _distanceLabel.draw(dc);
            _waypointLabel.draw(dc);
            _cyclicLabel.draw(dc);
            _proximityBar.draw(dc);
            _messageLabel.draw(dc);
        }
        else
        {
            View.onUpdate(dc);
            
            var w = dc.getWidth();
            var h = dc.getHeight();

            var x = (w / 2) + 2;
            var y = (h - 75) + 2;

            dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
            dc.drawText(x, y, Graphics.FONT_LARGE, 
                "Finding Newt", Graphics.TEXT_JUSTIFY_CENTER);
            dc.drawText(x, y + 30, Graphics.FONT_SMALL, 
                "Waypoint Locator", Graphics.TEXT_JUSTIFY_CENTER);

            x = x - 2;
            y = y - 2;
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(x, y, Graphics.FONT_LARGE, 
                "Finding Newt", Graphics.TEXT_JUSTIFY_CENTER);
            dc.drawText(x, y + 30, Graphics.FONT_SMALL, 
                "Waypoint Locator", Graphics.TEXT_JUSTIFY_CENTER);
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void
    {
    }
}