import Toybox.Lang;
import Toybox.Graphics;
import Toybox.System;
import Recording;

module Drawing
{
    class BottomLabelAdapter extends Events
    {
        var _waypointBearing;
        var _recordingStatus;
        var _consumer;

        function initialize(consumer as Method(text as Null or String) as Void) 
        {
            Events.initialize();
            _consumer = consumer;
        }

        function onWaypointBearing(bearing as Numeric or Null)
        {
            _waypointBearing = bearing;
            _consumer.invoke(text());
        }

        function onActivityStatus(status as Number)
        {
            _recordingStatus = status;
        }

        function text() as String or Null
        {
            var result = " ";
            if(_waypointBearing != null)
            {
                result += _waypointBearing.format("%03d") + "° ";
            }
            if(_recordingStatus != null)
            {
                result += Recording.toStringRecordingStatus(_recordingStatus) + " ";
            }

            if(result.length() == 1)
            {
                return null;
            }
            else
            {
                return result.substring(1, result.length());
            }
        }
    }
}