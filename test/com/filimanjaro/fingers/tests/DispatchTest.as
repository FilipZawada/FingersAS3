/**
 * Created by IntelliJ IDEA.
 * User: user
 * Date: 10/28/11
 * Time: 5:25 PM
 * To change this template use File | Settings | File Templates.
 */
package
com.filimanjaro.fingers.tests
{
import com.filimanjaro.fingers.OnStatementTestBase;

import flash.display.Sprite;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;

import org.hamcrest.assertThat;
import org.hamcrest.core.isA;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.notNullValue;

public class DispatchTest extends OnStatementTestBase
{


    [Test]
    public function quick_dispatch():void
    {
        restart();

        on(obj).click = succeedingHandler;
        on(obj).click();

        assertThat(caughtEvent, notNullValue());
    }

    [Test]
    public function quick_dispatch_custom_event():void
    {
        restart();

        on(obj).click = succeedingHandler;
        on(obj).click(MouseEvent);

        assertThat(caughtEvent, isA(MouseEvent));
    }

    [Test]
    public function quick_dispatch_custom_event_with_args():void
    {
        restart();

        on(obj).keyDown = succeedingHandler;
        on(obj).keyDown(KeyboardEvent, true, false, Keyboard.ENTER);

        assertThat(caughtEvent, isA(KeyboardEvent));
        assertThat(KeyboardEvent(caughtEvent).charCode, equalTo(Keyboard.ENTER));
    }

    [Test]
    public function quick_dispatch_default_event_with_args():void
    {
        restart();

        on(obj).funnyEvent = succeedingHandler;
        on(obj).funnyEvent(true, true);

        assertThat(caughtEvent, notNullValue());
        assertThat(caughtEvent.bubbles, isTrue());
        assertThat(caughtEvent.cancelable, isTrue());
    }
    
    [Test]
    public function quick_dispatch_is_bubbling_test():void
    {
        clear();
        var parent:Sprite = new Sprite();
        var child:Sprite = new Sprite();
        parent.addChild(child);
        
        on(parent).click += succeedingHandler;
        on(child).click(MouseEvent); // MouseEvent bubbles by default
        
        assertThat(caughtEvent, notNullValue());
    }

}
}
