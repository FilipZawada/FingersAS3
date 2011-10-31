package com.filimanjaro.fingers
{
import flash.display.MovieClip;

public class FingersExample
{
    public function FingersExample()
    {
        // This is a sample use of `Fingers`.
        // Fingers are micro AS3 extension for
        // handling events, inspired on C#.
        // --
        // Enjoy,
        // Filip Zawada (the author)

        // We will use MovieClip, however you
        // can use any IEventDispatcher you wish.
        var obj:MovieClip = new MovieClip();

        // go to next frame, when user click obj.
        // (listening for an event example)
        on(obj).click = obj.nextFrame;

        // Pure AS3 isn't so friendly:
        // obj.addEventListener(MouseEvent.CLICK, function ():void {
        //     obj.nextFrame();
        // });

        // add another listener
        // (without removing previous one)
        on(obj).click += function():void
        {
            obj.alpha = 0.5;
        }

        // dispatch an event!
        on(obj).click();

        // remove all obj click listeners (only those added with `on`)
        on(obj).click = null;

        // remove all obj listeners added (only those added with `on`)
        on(obj).removeAllListeners();


        // more docs soon...
        //
        // homepage: http://filimanjaro.com/fingers
        // download: https://github.com/FilipZawada/Fingers
    }
}
}
