/**
 * Created by IntelliJ IDEA.
 * User: user
 * Date: 10/27/11
 * Time: 10:42 AM
 * To change this template use File | Settings | File Templates.
 */
package
com.filimanjaro.fingers
{
import asunit.asserts.fail;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

use namespace fail;

public class OnStatementTestBase
{

    protected var caughtEvent:Event;
    protected var invocationsNum:int;
    protected var obj:IEventDispatcher;

    protected function restart():void
    {
        clear();
        obj = new EventDispatcher();
    }

    protected function clear():void
    {
        caughtEvent = null;
        invocationsNum = 0;
        if (obj)
        {
            on(obj).removeAllListeners();
        }
        obj = null;
    }

    protected function succeedingHandler(event:Event):void
    {
        caughtEvent = event;
        invocationsNum++;
    }

    protected function succeedingHandlerGenerator():Function
    {
        return function():void
        {
            invocationsNum++
        };
    }

    protected function shortSucceedingHandler():void
    {
        invocationsNum++;
    }

    protected function failingHandler(e:Event):void
    {
        fail("failing handler not removed");
    }

    protected function fail(s:String):void
    {
    }

    protected function shortFailingHandler():void
    {
        fail("short failing handler not removed");
    }


    [After]
    public function tearDown():void
    {
        clear();
    }


}
}
