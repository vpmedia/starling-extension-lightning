/*
 The MIT License (MIT)

 Copyright (c) 2008 Pierluigi Pesenti (blog.oaxoa.com)

 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 the Software, and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 */
package starling.extensions.lightning {
/**
 * Lightning Object Pool
 *
 * @author Pierluigi Pesenti (blog.oaxoa.com)
 * @contributor Andras Csizmadia (www.vpmedia.eu)
 * @contributor IonSwitz (www.github.com/IonSwitz)
 *
 */
public final class LightningPool {

    /**
     * @private
     */
    private static var MAX_VALUE:uint;

    /**
     * @private
     */
    private static var GROWTH_VALUE:uint;

    /**
     * @private
     */
    private static var COUNTER:uint;

    /**
     * @private
     */
    private static var POOL:Vector.<LightningBase>;

    /**
     * @private
     */
    private static var CURRENT_ITEM:LightningBase;

    /**
     * @private
     */
    private static const INITIALIZED:Boolean = initialize(32, 4);

    /**
     * @private
     */
    private static function initialize(maxPoolSize:uint, growthValue:uint):Boolean {
        trace("LightningPool::initialize: " + arguments);
        MAX_VALUE = maxPoolSize;
        GROWTH_VALUE = growthValue;
        COUNTER = maxPoolSize;
        POOL = new Vector.<LightningBase>(MAX_VALUE);
        // Pre-create objects
        var i:uint = maxPoolSize;
        while (--i > -1)
            POOL[i] = new Lightning(0, 0, 0, true);
        // Flag it
        return true;
    }

    /**
     * Get Lightning from pool
     */
    public static function getLightning():LightningBase {
        // return top element if existing
        if (COUNTER > 0)
            return CURRENT_ITEM = POOL[--COUNTER];
        // Pre-create objects
        var i:uint = GROWTH_VALUE;
        while (--i > -1)
            POOL.unshift(new Lightning(0, 0, 0, true));
        COUNTER = GROWTH_VALUE;
        // Create another one as result
        return getLightning();

    }

    /**
     * Put Lightning to pool
     */
    public static function putLightning(disposedLightning:LightningBase):void {
        //trace("LightningPool::putLightning: " + disposedLightning);
        POOL[COUNTER++] = disposedLightning;
    }

    /**
     * Get pool size
     */
    public static function getSize():uint {
        return COUNTER
    }
}
}
