/**
 * Created by IntelliJ IDEA.
 * User: user
 * Date: 10/28/11
 * Time: 6:28 PM
 * To change this template use File | Settings | File Templates.
 */
package
com.filimanjaro.fingers.tests
{
import com.filimanjaro.fingers.OnStatementTestBase;

public class IllegalAssignmentsTest extends OnStatementTestBase
{

    [Test(expects="flash.errors.IllegalOperationError")]
    public function setting_NaN_listener_should_fail():void
    {
        restart();

        on(obj).click = NaN;
    }

    [Test(expects="flash.errors.IllegalOperationError")]
    public function setting_object_listener_should_fail():void
    {
        restart();

        on(obj).click = {};
    }

    [Test(expects="flash.errors.IllegalOperationError")]
    public function adding_object_listener_should_fail():void
    {
        restart();

        on(obj).click += {};
    }

    [Test(expects="flash.errors.IllegalOperationError")]
    public function adding_NaN_listener_should_fail():void
    {
        restart();

        on(obj).click += NaN;
    }
}
}
