/**
 * Created by IntelliJ IDEA.
 * User: user
 * Date: 10/28/11
 * Time: 6:31 PM
 * To change this template use File | Settings | File Templates.
 */
package
com.filimanjaro.fingers.tests
{
import com.filimanjaro.fingers.OnStatementTestBase;

import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.nullValue;

public class RemoveTest extends OnStatementTestBase
{


    [Test]
    public function remove_listener():void
    {
        restart();

        on(obj).click += failingHandler;
        on(obj).click -= failingHandler + 0;

        assertThat(obj.hasEventListener(MouseEvent.CLICK), isFalse());
        assertThat(on(obj).getAllListenersNum(), equalTo(0));
        obj.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
    }


    [Test]
    public function remove_short_listener():void
    {
        restart();

        on(obj).click += shortFailingHandler;
        on(obj).click -= shortFailingHandler + 0;

        assertThat(obj.hasEventListener(MouseEvent.CLICK), isFalse());
        assertThat(on(obj).getAllListenersNum(), equalTo(0));
        obj.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
    }

    [Test]
    public function removing_combined_listeners():void
    {
        restart();
        on(obj).click = failingHandler;
        on(obj).click += shortFailingHandler;

        on(obj).click -= failingHandler + shortFailingHandler;

        on(obj).click();
        assertThat(obj.hasEventListener("click"), isFalse());
        assertThat(invocationsNum, equalTo(0));
        assertThat(on(obj).getAllListenersNum(), equalTo(0));
    }


    [Test]
    public function remove_all_listeners_of_one_event():void
    {
        restart();

        on(obj).click = failingHandler;
        on(obj).click += shortFailingHandler;
        on(obj).click = null;

        assertThat(obj.hasEventListener(MouseEvent.CLICK), isFalse());
        assertThat(on(obj).getListenersNum("click"), equalTo(0));
        on(obj).click(MouseEvent);
    }


    [Test]
    public function remove_duplicated_listener():void
    {
        restart();

        on(obj).click += succeedingHandler;
        on(obj).click += succeedingHandler;
        on(obj).click -= succeedingHandler + 0;

        assertThat(obj.hasEventListener("click"), isFalse());
        assertThat(on(obj).getAllListenersNum(), equalTo(0));
        on(obj).click();
        assertThat(caughtEvent, nullValue());
    }

    [Test]
    public function remove_all_listeners_from_empty_dispatcher():void
    {
        restart();

        on(obj).removeAllListeners();
    }

    [Test]
    public function remove_all_listeners_from_dispatcher():void
    {
        restart();

        on(obj).click = failingHandler;
        on(obj).click += shortFailingHandler;
        on(obj).keyUp = failingHandler;
        on(obj).keyUp += failingHandler;
        on(obj).keyUp += shortFailingHandler;
        on(obj).customEvent += failingHandler;
        on(obj).removeAllListeners();

        assertThat(obj.hasEventListener(MouseEvent.CLICK), isFalse());
        assertThat(obj.hasEventListener(KeyboardEvent.KEY_UP), isFalse());
        assertThat(obj.hasEventListener("customEvent"), isFalse());
        assertThat(on(obj).getAllListenersNum(), equalTo(0));
        on(obj).click();
        on(obj).keyUp();
        on(obj).customEvent();
    }


    [Test]
    public function remove_non_existing_listener():void
    {
        restart();

        on(obj).click -= failingHandler + 0;

        assertThat(obj.hasEventListener(MouseEvent.CLICK), isFalse());
        assertThat(on(obj).getAllListenersNum(), equalTo(0));
        obj.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
    }


    [Test]
    public function add_remove_listener_together():void
    {
        restart();

        on(obj).click += failingHandler + - (failingHandler + 0);

        assertThat(obj.hasEventListener(MouseEvent.CLICK), isFalse());
        on(obj).click();
    }
}
}
