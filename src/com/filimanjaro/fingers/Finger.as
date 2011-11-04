package com.filimanjaro.fingers
{


import flash.errors.IllegalOperationError;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.utils.Dictionary;
import flash.utils.Proxy;
import flash.utils.flash_proxy;

use namespace flash_proxy;

public dynamic class Finger extends Proxy
{
    private var target:IEventDispatcher;
    private var events:Array;

    /**
     * @private
     *
     * Used by on().
     *
     * @param value
     */
    public function openWith(value:IEventDispatcher):void
    {
        Function.prototype.valueOf = extendedValueOf;
        operatedFunctions.length = 0;

        if (target == value)
            return;
        target = value;
        if (!(target in weakDispatchers))
        {
            weakDispatchers[target] = [];
        }
        events = weakDispatchers[target];
    }

    private static const weakDispatchers:Dictionary = new Dictionary(true);
    private static const defaultValueOf:Function = Function.prototype.valueOf;
    private static const extendedValueOf:Function = function():Number
    {
        if (operatedFunctions.length >= 16)
            throw new IllegalOperationError("Max 16 functions can be added at once using 'on' syntax");
        operatedFunctions.push(this);
        return 1 << ((operatedFunctions.length - 1) * 2);
    };

    private static const operatedFunctions:Array = [];

    flash_proxy override function getProperty(name:*):*
    {
        return 0;
    }


    private static const ADD_LISTENER:int = 0x2;

    private static const REMOVE_LISTENER:int = 0x0;

    private static const LISTENER_FLAGS_MASK:int = 0x3;

    flash_proxy override function setProperty(name:*, value:*):void
    {
        Function.prototype.valueOf = defaultValueOf;

        if (value == null)
        {
            removeListeners(name);
        } else if (value is Function)
        {
            removeListeners(name);
            addListener(name, value as Function);
        } else if (value is int)
        {
            value += 0x55555555;

            var functionsForRemove:Array = [];
            for (var i:int = 0; i < operatedFunctions.length; i++)
            {
                var flag:int = (value >> (i * 2)) & LISTENER_FLAGS_MASK;
                if (flag == ADD_LISTENER)
                    addListener(name, operatedFunctions[i]);
                else if (flag == REMOVE_LISTENER)
                    functionsForRemove.push(operatedFunctions[i]);
            }
            for each(var listener:Function in functionsForRemove)
            {
                removeListener(name, listener);
            }
        } else
        {
            throw new IllegalOperationError("Unexpected value");
        }
    }

    private function removeListener(name:String, listener:Function):void
    {
        if (name in events)
        {
            var wrapper:Function = events[name][listener] as Function;
            target.removeEventListener(name, wrapper != null ? wrapper : listener);
            delete events[name][listener];
        }
        else
        {
            target.removeEventListener(name, listener);
        }
    }

    private function removeListeners(name:String):void
    {

        if (name in events)
        {
            var listeners:Dictionary = events[name];
            for (var listener:Object in listeners)
            {
                removeListener(name, listener as Function);
            }
            delete events[name];
        }
    }


    public function removeAllListeners():void
    {
        Function.prototype.valueOf = defaultValueOf;

        for (var eventName:String in events)
        {
            removeListeners(eventName);
        }
    }

    public function getListenersNum(eventName:String):int
    {
        Function.prototype.valueOf = defaultValueOf;

        var listeners:Dictionary = events[eventName];
        var num:int = 0;
        for (var k:* in listeners)
        {
            num++;
        }
        return num;
    }

    public function getAllListenersNum():int
    {
        Function.prototype.valueOf = defaultValueOf;

        var num:int = 0;
        for (var eventName:String in events)
        {
            num += getListenersNum(eventName);
        }
        return num;
    }


    private function addListener(name:String, listener:Function):void
    {
        if (!(name in events))
        {
            events[name] = new Dictionary(true);
        }

        if (listener.length != 0)
        {
            target.addEventListener(name, listener);
            events[name][listener] = true;
        }
        else
        {
            // I think it might be a good idea to have one `root listener`
            // for all short listeners (those without arguments).
            // Then we could just store short listeners in an array,
            // and invoke them, when `root listener` is called.
            // For now, solution below it's much shorter and simpler -
            // - pack a short listener into an event wrapper.
            var wrapper:Function = function(e:Event):void
            {
                listener()
            };
            target.addEventListener(name, wrapper);
            events[name][listener] = wrapper;
        }
    }

    flash_proxy override function callProperty(name:*, ... rest):*
    {
        Function.prototype.valueOf = defaultValueOf;

        var EventClass:Class = Event;
        if (rest[0] is Class)
        {
            EventClass = rest.shift() as Class;
        }

        // optimization found here: http://gskinner.com/blog/archives/2008/12/making_dispatch.html
        if (target.hasEventListener(name))
            target.dispatchEvent(construct(EventClass, name, rest));
    }
}

}
/*
 * Thanks to Richard Lord and Troy Gardner,
 * (found here: http://troyworks.com/blog/2008/12/04/worksrounds-for-dynamic-invocation-of-class-constructors/
 * and here: http://code.google.com/p/bigroom/source/browse/trunk/src/uk/co/bigroom/utils/construct.as?spec=svn3&r=3 )
 * I modified the code a little bit
 *
 * Author: Richard Lord
 * Copyright (c) Big Room Ventures Ltd. 2007-2008
 * Version: 1.0.0
 *
 * Licence Agreement
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */


/**
 * This function is used to construct an object from the class and an array of parameters.
 *
 * @param type The class to construct.
 * @param params An array of up to ten parameters to pass to the constructor.
 */
internal function construct(type:Class, firstParam:String, params:Array):*
{
    switch (params.length)
    {
        case 0:
            return new type(firstParam);
        case 1:
            return new type(firstParam, params[0]);
        case 2:
            return new type(firstParam, params[0], params[1]);
        case 3:
            return new type(firstParam, params[0], params[1], params[2]);
        case 4:
            return new type(firstParam, params[0], params[1], params[2], params[3]);
        case 5:
            return new type(firstParam, params[0], params[1], params[2], params[3], params[4]);
        case 6:
            return new type(firstParam, params[0], params[1], params[2], params[3], params[4], params[5]);
        case 7:
            return new type(firstParam, params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
        case 8:
            return new type(firstParam, params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7]);
        case 9:
            return new type(firstParam, params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8]);
        case 10:
            return new type(firstParam, params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8], params[9]);
        default:
            throw new ArgumentError("To many arguments");
    }
}

