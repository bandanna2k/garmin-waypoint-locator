import Toybox.Lang;

module DataStructures
{
    class Queue
    {
        var _array;

        function initialize()
        {
            Events.initialize();
            _array = [];
        }

        function enqueue(value as Object) as Void
        {
            _array = _array.add(value);
        }

        function isEmpty() as Boolean
        {
            return _array.size() == 0;
        }

        function dequeue() as Object or Null
        {
            if(isEmpty())
            {
                return null;
            }
            var result = (_array as Array<Object>)[0];
            _array = _array.slice(1,_array.size());
            return result;
        }
    }
}