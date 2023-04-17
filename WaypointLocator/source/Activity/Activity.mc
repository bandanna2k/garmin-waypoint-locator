import Toybox.Lang;
import Toybox.Activity;
import Toybox.ActivityRecording;
import Logging;

module Activity
{
    const STATUS_RECORDING_NOTHING = 0;
    const STATUS_RECORDING_RECORDING = 1;
    const STATUS_RECORDING_PAUSED = 2;
    const STATUS_RECORDING_STOPPED = 3;

    function toStringRecordingStatus(recordingStatus as Number) as String
    {
        if(recordingStatus == STATUS_RECORDING_RECORDING)
        {
            return "⏵";
        }
        if(recordingStatus == STATUS_RECORDING_PAUSED)
        {
            return "⏸";
        }
        if(recordingStatus == STATUS_RECORDING_STOPPED)
        {
            return "⏹";
        }
        return "";
    }
}