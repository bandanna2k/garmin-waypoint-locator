import Toybox.Lang;
import Toybox.Activity;
import Toybox.ActivityRecording;
import Logging;

module Activity
{
    class ActivityController extends Events
    {
        var _session;
        var _distance = 0;
        var _eventRegistry;

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
                if ((_session == null) || (_session.isRecording() == false)) 
                {
                    _session = ActivityRecording.createSession({          // set up recording session
                        :name=>"Generic",                              // set session name
                        :sport=>Activity.SPORT_CYCLING,                // set sport type
                        :subSport=>Activity.SUB_SPORT_GENERIC          // set sub sport type
                    });
                    _session.start();                                     // call start session
                    _eventRegistry.onActivityStarted();
                    _eventRegistry.onMessage("Recording");
Logging.debug("ActivityController.recordingActivity");
                }
                else if ((_session != null) && _session.isRecording()) 
                {
                    _session.stop();                                      // stop the session
                    if(_distance >= 0)
                    {
                        _eventRegistry.onMessage("Saving");
                        _session.save();                                      // save the session
                        _eventRegistry.onActivitySaved();
                        _eventRegistry.onMessage("Saved");
Logging.debug("ActivityController.savingActivity");
                    }
                    _session = null;
Logging.debug("ActivityController.stoppingRecordingActivity");
                    _eventRegistry.onActivityStopped();
                    _eventRegistry.onMessage("Finished");
                }
            }
        }
    }
}