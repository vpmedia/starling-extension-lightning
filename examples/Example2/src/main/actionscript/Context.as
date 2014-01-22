/*
 Licensed under the MIT License

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
package {

import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;

import starling.core.Starling;
import starling.display.Shape;
import starling.display.Sprite;
import starling.events.Event;
import starling.extensions.lightning.Lightning;
import starling.extensions.lightning.LightningPool;
import starling.filters.BlurFilter;

// http://blog.oaxoa.com/wp-content/examples/showExample.php?f=lightning_test_coil.swf&w=727&h=566

public final class Context extends Sprite {

    private var fingers;
    private var dot1:Shape;
    private var dot2:Shape;
    private var dot3:Shape;
    private var dot4:Shape;
    private var ll:Lightning;
    private var ll2:Lightning;

    private var glowFilter:BlurFilter;

    private var debugLabel:TextField;

    private var displayDriver:String;

    private static const COLOR:uint = 0xDDEEFF;

    public function Context() {
        addEventListener(Event.ADDED_TO_STAGE, onAdded);
    }

    private function onAdded(event:Event):void {
        displayDriver = Starling.current.context.driverInfo;
        removeEventListener(Event.ADDED_TO_STAGE, onAdded);
        // set starling stage color
        stage.color = 0x001A4D;
        // debug label
        const textFormat:TextFormat = new TextFormat("Arial", 10, 0xFFFFFF);
        debugLabel = new TextField();
        Starling.current.nativeOverlay.addChild(debugLabel);
        debugLabel.width = 800;
        debugLabel.height = 20;
        debugLabel.y = 580;
        debugLabel.embedFonts = false;
        debugLabel.multiline = false;
        debugLabel.selectable = false;
        debugLabel.defaultTextFormat = textFormat;
        debugLabel.text = "Initializing...";
        debugLabel.setTextFormat(textFormat);

        //
        fingers = new Sprite();
        addChild(fingers);
        //
        dot1 = new Shape();
        dot1.name = "dot1";
        dot1.graphics.beginFill(0x6699CC);
        dot1.graphics.drawCircle(0, 0, 8);
        dot1.graphics.endFill();
        fingers.addChild(dot1);
        //
        dot2 = new Shape();
        dot2.name = "dot2";
        dot2.graphics.beginFill(0x6699CC);
        dot2.graphics.drawCircle(0, 0, 8);
        dot2.graphics.endFill();
        fingers.addChild(dot2);
        dot2.x = 50;

        fingers.y = 400;
        fingers.x = fingers.y / 2.5 - 10;

        //
        dot3 = new Shape();
        dot3.graphics.beginFill(0x336699);
        dot3.graphics.drawCircle(0, 0, 8);
        dot3.graphics.endFill();
        dot3.x = 20;
        dot3.y = 50;
        addChild(dot3);

        //
        dot4 = new Shape();
        dot4.graphics.beginFill(0x336699);
        dot4.graphics.drawCircle(0, 0, 8);
        dot4.graphics.endFill();
        dot4.x = 60;
        dot4.y = 50;
        addChild(dot4);

        //
        ll = new Lightning(COLOR, 2);
        ll2 = new Lightning(COLOR, 2);
        ll.childrenProbability = ll2.childrenProbability = .5;
        ll.childrenLifeSpanMin = ll2.childrenLifeSpanMin = .1;
        ll.childrenLifeSpanMax = ll2.childrenLifeSpanMax = 2;
        ll.maxLength = ll2.maxLength = 50;
        ll.maxLengthVary = ll2.maxLengthVary = 200;

        ll.startX = dot3.x;
        ll.startY = dot3.y;
        ll2.startX = dot4.x;
        ll2.startY = dot4.y;

        ll.filter = ll2.filter = glowFilter;

        addChild(ll);
        addChild(ll2);

        updatePositions();

        Starling.current.nativeStage.addEventListener("mouseMove", onMove);
        addEventListener(Event.ENTER_FRAME, onFrameEnter);

    }

    private function updatePositions():void {
        ll.endX = fingers.x + dot1.x;
        ll.endY = fingers.y + dot1.y;
        ll2.endX = fingers.x + dot2.x;
        ll2.endY = fingers.y + dot2.y;
    }

    private function onFrameEnter(event:Event):void {
        debugLabel.text = "LightningPool size= " + LightningPool.getSize() + " | " + ll + " | " + displayDriver;
        ll.update();
        ll2.update();
    }

    private function onMove(e:MouseEvent):void {
        fingers.y = e.stageY - 150;
        if (fingers.y > 600) fingers.y = 600;
        fingers.x = fingers.y / 2.5 - 10;
        updatePositions();
    }
}
}
