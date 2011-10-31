/**
 * Created by IntelliJ IDEA.
 * User: user
 * Date: 10/28/11
 * Time: 6:27 PM
 * To change this template use File | Settings | File Templates.
 */
package
com.filimanjaro.fingers.tests
{
import com.filimanjaro.fingers.OnStatementTestBase;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

public class ExceptionalCasesTest extends OnStatementTestBase
{

    [Test]
    public function nestedFunctionCastedToIntShouldNotInvoke():void
    {
        restart();

        function success():Function
        {
            int(failingHandler);
            return succeedingHandler;
        }

        on(obj).click = success() + shortSucceedingHandler;

        on(obj).click();

    }


    [Test]
    public function adding_16_handlers_twice():void
    {
        restart();

        on(obj).testEvent += succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() // 4
                + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() // 4
                + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() // 4
                + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator();// 4
        on(obj).testEvent += succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() // 4
                + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() // 4
                + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() // 4
                + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator();// 4

        on(obj).testEvent();
        assertThat(on(obj).getAllListenersNum(), equalTo(32));
        assertThat(invocationsNum, equalTo(32));
    }


    [Test(expects="flash.errors.IllegalOperationError")]
    public function adding_17_handlers_should_fails():void
    {
        restart();

        on(obj).testEvent += succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() // 4
                + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() // 4
                + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() // 4
                + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator() + succeedingHandlerGenerator()// 4
                + succeedingHandlerGenerator(); // 1
    }
}
}
