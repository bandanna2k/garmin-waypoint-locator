import Toybox.Lang;
import Toybox.Activity;
import Toybox.ActivityRecording;
import Logging;

module Recording
{
    class ActivityController extends Events
    {
        var _session;
        var _distance = 0;
        var _eventRegistry;

        var _durationUpInSeconds = 0;
        var _startTime = 0;
        var _stopTime = 0;

        function initialize(eventRegistry as EventRegistry)
        {
            Events.initialize();
            _eventRegistry = eventRegistry;
            _eventRegistry.register(self);
        }

        function onActivityInitiate() as Void
        {
            if (Toybox has :ActivityRecording) // check device for activity recording 
            {                         
                if(_session == null) 
                {
                    _session = ActivityRecording.createSession({          // set up recording session
                        :name=>"Generic",                              // set session name
                        :sport=>Activity.SPORT_CYCLING,                // set sport type
                        :subSport=>Activity.SUB_SPORT_GENERIC          // set sub sport type
                    });

                    _startTime = _durationUpInSeconds;
                    _session.start();                                     // call start session
                    _eventRegistry.onActivityStatus(Recording.STATUS_RECORDING_RECORDING);

                    Attention.playTone(Attention.TONE_START);
                    _eventRegistry.onMessage("Recording");

Logging.debug("ActivityController.recordingActivity");
                }
                else
                {
                    if(_session.isRecording())
                    {
Logging.debug("ActivityController.pausing");
                        _stopTime = _durationUpInSeconds;
                        _session.stop();                                      // stop the session
                        _eventRegistry.onActivityStatus(Recording.STATUS_RECORDING_PAUSED);
                        Attention.playTone(Attention.TONE_STOP);
                    }
                    else
                    {
                        if(_durationUpInSeconds - _stopTime < 10)
                        {
Logging.debug("ActivityController.saving");
                            _session.save();                                      // save the session
                            _eventRegistry.onActivityStatus(Recording.STATUS_RECORDING_STOPPED);

                            _startTime = 0;
                            _stopTime = 0;
                            _session = null;
                            Attention.playTone(Attention.TONE_SUCCESS);
                            _eventRegistry.onMessage("Saving");
                        }
                        else
                        {
Logging.debug("ActivityController.resuming");
                            _session.start();                            
                            _eventRegistry.onActivityStatus(Recording.STATUS_RECORDING_RECORDING);

                            Attention.playTone(Attention.TONE_START);
                            _eventRegistry.onMessage("Resuming");
                        }
                    }
                }
            }
        }

        function onPulse()
        {
            _durationUpInSeconds++;
        }
    }
}