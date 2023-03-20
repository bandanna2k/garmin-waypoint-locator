import Test.Utilities.Assertions;
import Toybox.Lang;
import Toybox.Test;

module DataStructures 
{
    (:test)
    function testQueue(logger as Logger) as Boolean
    {
        var queue = new Queue();

        Assertions.areEqual(null, queue.dequeue());

        queue.enqueue("First");
        queue.enqueue("Second");

        Assertions.areEqual("First", queue.dequeue());
        Assertions.areEqual("Second", queue.dequeue());
        Assertions.areEqual(null, queue.dequeue());

        return true;
    }
}