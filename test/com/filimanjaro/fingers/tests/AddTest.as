package
com.filimanjaro.fingers.tests
{
import com.filimanjaro.fingers.OnStatementTestBase;

import flash.events.MouseEvent;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;

public class AddTest extends OnStatementTestBase
{

    [Test]
    public function add_listener():void
    {
        restart();

        on(obj).click += succeedingHandler;

        assertThat(obj.hasEventListener(MouseEvent.CLICK), isTrue());
        obj.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
    }

    [Test]
    public function add_short_listener():void
    {
        restart();

        on(obj).click += shortSucceedingHandler;

        assertThat(obj.hasEventListener(MouseEvent.CLICK), isTrue());
        obj.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
        assertThat(invocationsNum, equalTo(1));
    }

    [Test]
    public function adding_combined_listeners():void
    {
        restart();

        on(obj).click += succeedingHandler + shortSucceedingHandler;

        on(obj).click();
        assertThat(obj.hasEventListener("click"), isTrue());
        assertThat(invocationsNum, equalTo(2));
        assertThat(on(obj).getAllListenersNum(), equalTo(2));
    }

    [Test]
    public function adding_combined_excluding_listeners():void
    {
        restart();

        on(obj).click = failingHandler + - (failingHandler + 0);

        on(obj).click();
        assertThat(obj.hasEventListener("click"), isFalse());
        assertThat(invocationsNum, equalTo(0));
        assertThat(on(obj).getAllListenersNum(), equalTo(0));
    }

    [Test]
    public function add_duplicated_listener():void
    {
        restart();

        on(obj).click += succeedingHandler;
        on(obj).click += succeedingHandler;

        on(obj).click();
        assertThat(invocationsNum, equalTo(1));
    }


}
}
