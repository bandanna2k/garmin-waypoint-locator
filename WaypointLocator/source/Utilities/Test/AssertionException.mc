import Toybox.Lang;
import Toybox.System;

module Utilities { module Test 
{
    class AssertionException extends Exception 
    {
        var _message as String;

        function initialize(message as String) 
        {
            Exception.initialize();

            _message = message;
        }

        function getErrorMessage() as String or Null
        {
            return _message;
        }
    }
}}
