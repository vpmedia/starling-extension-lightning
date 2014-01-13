/*
 Licensed under the MIT License

 Copyright (c) 2008 Pierluigi Pesenti (blog.oaxoa.com)
 Contributor (2014 Andras Csizmadia (www.vpmedia.eu)

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
package {

import flash.display.Sprite;
import flash.events.Event;

import starling.core.Starling;

// http://blog.oaxoa.com/wp-content/examples/showExample.php?f=lightning_test_coil.swf&w=727&h=566

[SWF(width="800", height="600", frameRate="60", backgroundColor="#001a4d")]
public final class Main extends Sprite {

    private var starling:Starling;

    public function Main() {
        addEventListener(Event.ADDED_TO_STAGE, onAdded);
    }

    private function onAdded(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAdded);
        starling = new Starling(Context, stage);
        starling.showStats = true;
        starling.start();
    }

}
}
