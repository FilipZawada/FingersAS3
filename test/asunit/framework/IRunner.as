package asunit.framework
{

import flash.display.DisplayObjectContainer;
import flash.events.IEventDispatcher;

public interface IRunner extends IEventDispatcher
{

    function run(testOrSuite:Class, testMethodName:String = null, visualContext:DisplayObjectContainer = null):void;

}
}

