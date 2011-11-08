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

import flash.display.Sprite;

import flash.ui.Mouse;
import flash.ui.MouseCursor;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

public class FreezeFunctionTest
{
    private var strings:String;
    private function concatenateStrings(arg:String, arg2:String):void
    {
        strings = arg+arg2;
    }

    [Test]
    public function prepare_function_with_args():void
    {
        var preparedFunc:Function = f$(concatenateStrings)("hello", "There");
        preparedFunc();

        assertThat(strings, equalTo("helloThere"));
    }

    public function set setter(value:String):void
    {
        strings = value;
    }

    [Test]
    public function prepare_custom_setter():void
    {
         // to avoid unused method warning
        setter = "test";

        var preparedFunc:Function = f$(this).setter("setterExample");
        preparedFunc();

        assertThat(strings, equalTo("setterExample"));
    }

    [Test]
    public function make_hand_cursor():void
    {
        var spr:Sprite = new Sprite();
        on(spr).enterFrame = f$(Mouse).cursor(MouseCursor.HAND);
        // I don't clear up, cursor is cool!
    }

}
}
