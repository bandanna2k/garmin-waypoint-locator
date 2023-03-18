import Toybox.Activity;

module Activity
{
    class ActivityController extends Events
    {
        var _session;
        var _distance = 0;

        function initialize(eventRegistry as EventRegistry)
        {
            Events.initialize();
            var _eventRegistry = eventRegistry;
            _eventRegistry.register(self);
        }

        function onActivityNext() as Void
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
Toybox.System.println("ActivityController.recordingActivity");
                }
                else if ((_session != null) && _session.isRecording()) 
                {
                    if(_distance > 1)
                    {
                        _session.stop();                                      // stop the session
                        _session.save();                                      // save the session
Toybox.System.println("ActivityController.savingActivity");
                    }
                    _session = null;                                      // set session control variable to null
Toybox.System.println("ActivityController.stoppingRecordingActivity");
                }
            }
        }
    }
}