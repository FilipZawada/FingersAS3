/**
 * Created by IntelliJ IDEA.
 * User: user
 * Date: 10/28/11
 * Time: 5:37 PM
 * To change this template use File | Settings | File Templates.
 */
package
com.filimanjaro.fingers.tests
{
import com.filimanjaro.fingers.OnStatementTestBase;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

public class ListenersNumTest extends OnStatementTestBase
{

    [Test]
    public function get_event_listeners_num():void
    {

        restart();

        on(obj).testEvent += succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() // 4
                + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() // 4
                + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() // 4
                + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator();// 4
        var listenersNum:int = on(obj).getListenersNum("testEvent");

        assertThat(listenersNum, equalTo(16));
    }

    [Test]
    public function get_all_listeners_num():void
    {

        restart();

        on(obj).testEvent += succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() // 4
                + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator(); // 4
        on(obj).testEvent2 += succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() // 4
                + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator();// 4
        var listenersNum:int = on(obj).getAllListenersNum();

        assertThat(listenersNum, equalTo(16));
    }
}
}
