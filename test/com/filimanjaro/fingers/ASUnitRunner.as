package com.filimanjaro.fingers
{
import asunit.core.TextCore;

import flash.display.Sprite;

public class ASUnitRunner extends Sprite
{
    private var core:TextCore;

    public function ASUnitRunner()
    {
        core = new TextCore();
        core.textPrinter.hideLocalPaths = true;
        core.start(AllTestsSuite, null, this);
    }
}
}
