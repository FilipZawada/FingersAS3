/**
 * Created by IntelliJ IDEA.
 * User: user
 * Date: 10/21/11
 * Time: 10:54 AM
 * To change this template use File | Settings | File Templates.
 */
package
com.filimanjaro.fingers.tests
{
import asunit.asserts.assertNotNull;

public class FreezeFunctionTest
{

    [Test]
    public function prepare_function_with_args():void
    {
        var preparedFunc:Function = f$(assertNotNull)("hello", "there");
        preparedFunc();
    }

}
}
