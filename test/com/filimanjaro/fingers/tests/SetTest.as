/**
 * Created by IntelliJ IDEA.
 * User: user
 * Date: 10/28/11
 * Time: 6:38 PM
 * To change this template use File | Settings | File Templates.
 */
package
com.filimanjaro.fingers.tests
{
import com.filimanjaro.fingers.OnStatementTestBase;

import flash.events.MouseEvent;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;

public class SetTest extends OnStatementTestBase
{
    [Test]
    public function set_listener():void
    {
        restart();

        on(obj).click = succeedingHandler;

        assertThat(obj.hasEventListener(MouseEvent.CLICK), isTrue());
        obj.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
    }

    [Test]
    public function set_short_listener():void
    {
        restart();

        on(obj).click = shortSucceedingHandler;

        assertThat(obj.hasEventListener(MouseEvent.CLICK), isTrue());
        obj.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
        assertThat(invocationsNum, equalTo(1));
    }


    [Test]
    public function setting_combined_listeners():void
    {
        restart();

        on(obj).click = succeedingHandler + shortSucceedingHandler;

        on(obj).click();
        assertThat(obj.hasEventListener("click"), isTrue());
        assertThat(invocationsNum, equalTo(2));
        assertThat(on(obj).getAllListenersNum(), equalTo(2));
    }

    [Test]
    public function setting_combined_excluding_listeners():void
    {
        restart();

        on(obj).click = failingHandler + - (failingHandler + 0);

        on(obj).click();
        assertThat(obj.hasEventListener("click"), isFalse());
        assertThat(invocationsNum, equalTo(0));
        assertThat(on(obj).getAllListenersNum(), equalTo(0));
    }


}
}
