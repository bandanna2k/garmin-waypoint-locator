import Toybox.Lang;
import Utilities.Test;

module Integration
{
    class AssertionsList
    {
        var _list = [] as Array<AssertionRecord>;
        var _position = 0;

        function add(value as Object) as Void
        {
            _list.add(new AssertionRecord(value));
        }
        function records() as Array<AssertionRecord>
        {
            return _list;
        }
        function assertValue(expectedValue as Object or Null) as Object
        {
            var records = records();
            for(var i = 0; i < records.size(); i++)
            {
                var record = records[i];
                if(record.isEqualAndNotMatched(expectedValue))
                {
                    record.setMatched();
                    return record.value();
                }
            }
            displayValues();
            throw new AssertionException("Value '" + expectedValue + "' not found.");
        }
        function assertNoMoreValues() as Void
        {
            for(var i = 0; i < _list.size(); i++)
            {
                var record = (_list as Array<AssertionRecord>)[i];
                if(!record.isMatched())
                {
                    displayValues();
                    throw new AssertionException("Extra values found.");
                }
            }
        }        
        function displayValues() as Void
        {
Toybox.System.println(_list.size() + " record(s).");
            for(var i = 0; i < _list.size(); i++)
            {
                var record = (_list as Array<AssertionRecord>)[i];
Toybox.System.println(record);
            }
        }

        class AssertionRecord
        {
            var _isMatched = false;
            var _value;

            function initialize(value as Object or Null)
            {
                _value = value;
            }
            function isMatched()
            {
                return _isMatched;
            }
            function value() as Object or Null
            {
                return _value;
            }
            function setMatched()
            {       
                _isMatched = true;
            }
            function toString() as String
            {
                if(_isMatched)
                {
                    return _value + " (Matched)";
                }
                return _value + " (Not matched)"; 
            }
            function isEqualAndNotMatched(value as Object or Null) as Boolean
            {
                if(_isMatched)
                {
                    return false;
                }
                if(value == null)
                {
                    return _value == null;
                }
                if(_value == null)
                {
                    return value == null;
                }
                return _value.equals(value);
            }
        }
    }
}