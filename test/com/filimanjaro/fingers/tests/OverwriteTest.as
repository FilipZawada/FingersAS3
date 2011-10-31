/**
 * Created by IntelliJ IDEA.
 * User: user
 * Date: 10/28/11
 * Time: 6:30 PM
 * To change this template use File | Settings | File Templates.
 */
package
com.filimanjaro.fingers.tests
{
import com.filimanjaro.fingers.OnStatementTestBase;

import flash.events.MouseEvent;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.notNullValue;

public class OverwriteTest extends OnStatementTestBase
{

    [Test]
    public function overwrite_listener():void
    {
        restart();

        on(obj).click = failingHandler;
        on(obj).click = succeedingHandler;

        assertThat(obj.hasEventListener(MouseEvent.CLICK), isTrue());
        on(obj).click();
        assertThat(caughtEvent, notNullValue())
    }

    [Test]
    public function overwrite_short_listener():void
    {
        restart();

        on(obj).click = shortFailingHandler;
        on(obj).click = shortSucceedingHandler;

        assertThat(obj.hasEventListener(MouseEvent.CLICK), isTrue());
        on(obj).click();
        assertThat(invocationsNum, equalTo(1));
    }


}
}
