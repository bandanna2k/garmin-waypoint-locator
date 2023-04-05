import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Application;
import Inputs.Menus;

module Inputs
{        
    class InitialScreenInputBehaviourWrapper extends BehaviorDelegate
    {
        var _behaviourDelegate;
        var _ready = false;
        var _eventRegistry as EventRegistry;

        function initialize(
            eventRegistry as EventRegistry,
            behaviorDelegate as BehaviorDelegate)
        {
            BehaviorDelegate.initialize();

            _behaviourDelegate = behaviorDelegate;
            _eventRegistry = eventRegistry;
        }

        function onMenu() as Boolean
        {
            if(_ready)
            {
                return _behaviourDelegate.onMenu();
            }
            else
            {
                _ready = true;
                _eventRegistry.onStart();
                return BehaviorDelegate.onMenu();
            }
        }

        function onNextPage() as Boolean
        {
            if(_ready)
            {
                return _behaviourDelegate.onNextPage();
            }
            else
            {
                _ready = true;
                _eventRegistry.onStart();
                return BehaviorDelegate.onNextPage();
            }
        }

        function onPreviousPage() as Boolean
        {
            if(_ready)
            {
                return _behaviourDelegate.onPreviousPage();
            }
            else
            {
                _ready = true;
                _eventRegistry.onStart();
                return BehaviorDelegate.onPreviousPage();
            }
        }

        function onSelect() as Boolean
        {
            if(_ready)
            {
                return _behaviourDelegate.onSelect();
            }
            else
            {
                _ready = true;
                _eventRegistry.onStart();
                return BehaviorDelegate.onSelect();
            }
        }
    }
}