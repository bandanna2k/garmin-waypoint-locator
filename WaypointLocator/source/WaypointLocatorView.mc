import Toybox.WatchUi;
import Toybox.Graphics;

class WaypointLocatorView extends WatchUi.View  
{
    var _arrowHead = new Drawing.ArrowHead();
    var _bearingLabel = new Drawing.BearingLabel();
    var _distanceLabel = new Drawing.DistanceLabel();
    var _waypointLabel = new Drawing.WaypointLabel();

    var _cyclicString = new Utilities.Text.CyclicString("Waypoint Locator by David North", 18);
    var _cyclicLabel = new Drawing.CyclicLabel(_cyclicString);

    function initialize(_eventRegistry as EventRegistry)
    {
        View.initialize();

        _eventRegistry.register(_arrowHead);
        _eventRegistry.register(_bearingLabel);
        _eventRegistry.register(_distanceLabel);
        _eventRegistry.register(_waypointLabel);
        _eventRegistry.register(_cyclicLabel);
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
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();

        _bearingLabel.draw(dc);
        _arrowHead.draw(dc);
        _distanceLabel.draw(dc);
        _waypointLabel.draw(dc);
        _cyclicLabel.draw(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void
    {
    }
}