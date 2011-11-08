package
{
public function f$(funcOrInst:Object):*
{
    if(funcOrInst is Function)
    {
        return function(...args):Function
        {
            return function():void
            {
                funcOrInst.apply(null, args);
            }
        }
    } else
    {
        return new FreezerProxy(funcOrInst);
    }
}
}

import flash.utils.Proxy;
import flash.utils.flash_proxy;

use namespace flash_proxy;

internal class FreezerProxy extends Proxy
{
    internal var obj:Object;

    public function FreezerProxy(obj:Object)
    {
        this.obj = obj;
    }


    flash_proxy override function callProperty(name:*, ... rest):*
    {
        return function():void {
            obj[name] = rest[0];
        }
    }
}