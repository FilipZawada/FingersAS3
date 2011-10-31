package
{
import com.filimanjaro.fingers.Finger;

import flash.events.IEventDispatcher;

/**
 * Wrap your object with on(), then add your listeners
 * <pre>on(yourDispatcher).click = clickListener;</pre>
 * <pre>on(yourDispatcher).click += clickListener2;</pre>
 *
 * more docs soon. For now, you can see unit tests.
 *
 * @param obj any EventDispatcher
 * @return OnObject, a wrapper for your dispatcher;
 */
public function on(obj:IEventDispatcher):Finger
{
    _on.openWith(obj);
    return _on;
}

}

import com.filimanjaro.fingers.Finger;

internal var _on:Finger = new Finger();

