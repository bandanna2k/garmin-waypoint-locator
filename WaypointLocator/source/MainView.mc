import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

class MainView extends WatchUi.View 
{
    const _originX = 0;
    const _originY = 0;
    const _maxX = 176;
    const _maxY = 176;

    var _arrowHead;
    var _bearingLabel;
    var _distanceLabel;
    var _waypointLabel;

    function initialize(
        arrowHead as Drawing.ArrowHead, 
        bearingLabel as Drawing.BearingLabel,
        distanceLabel as Drawing.DistanceLabel,
        waypointLabel as Drawing.WaypointLabel)
    {
        _arrowHead = arrowHead;
        _bearingLabel = bearingLabel;
        _distanceLabel = distanceLabel;
        _waypointLabel = waypointLabel;

        View.initialize();
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

        var w = dc.getWidth();
        var h = dc.getHeight();
//        dc.drawText(w / 3, 15, Graphics.FONT_SMALL, "-", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(w / 2, h - 65, Graphics.FONT_MEDIUM, "My name is Garmin", Graphics.TEXT_JUSTIFY_CENTER);

        _bearingLabel.draw(dc);
        _arrowHead.draw(dc);
        _distanceLabel.draw(dc);
        _waypointLabel.draw(dc);

        System.println("onUpdate (redraw)");
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void
    {
    }
}
