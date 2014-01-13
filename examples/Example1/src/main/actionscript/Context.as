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

import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFormat;

import starling.core.Starling;
import starling.display.Shape;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.extensions.lightning.Lightning;
import starling.extensions.lightning.LightningFadeType;
import starling.extensions.lightning.LightningPool;
import starling.filters.BlurFilter;

// http://blog.oaxoa.com/wp-content/examples/showExample.php?f=lightning_test_coil.swf&w=727&h=566

public final class Context extends Sprite {

    private static const CX:uint = 360;

    private static const CY:uint = 320;

    private static const COLOR:uint = 0xDDEEFF;

    private var ll:Lightning;

    private var dot1:Shape;

    private var dot2:Shape;

    private var ball:Shape;

    private var p:Point;

    private var debugLabel:TextField;

    public function Context() {
        addEventListener(Event.ADDED_TO_STAGE, onAdded);
    }

    private function onAdded(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAdded);
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
        // ball
        ball = new Shape();
        ball.graphics.beginFill(0x333333);
        ball.graphics.drawCircle(0, 0, 15);
        ball.graphics.endFill();
        ball.x = 400;
        ball.y = 50;
        addChild(ball);
        // dot1
        dot1 = new Shape();
        dot1.graphics.beginFill(0xFFFFFF);
        dot1.graphics.drawCircle(0, 0, 6);
        dot1.graphics.endFill();
        dot1.alpha = .75;
        dot1.x = 100;
        dot1.y = 100;
        addChild(dot1);
        // dot2
        dot2 = new Shape();
        dot2.graphics.beginFill(0xFFFFFF);
        dot2.graphics.drawCircle(0, 0, 3);
        dot2.graphics.endFill();
        dot2.x = 600;
        dot2.y = 100;
        addChild(dot2);
        // lightning
        ll = new Lightning(COLOR, 2);
        //ll.blendMode = BlendMode.ADD;
        ll.childrenDetachedEnd = true;
        ll.childrenLifeSpanMin = .1;
        ll.childrenLifeSpanMax = 2;
        ll.childrenMaxCount = 4;
        ll.childrenMaxCountDecay = .5;
        ll.steps = 150;
        ll.alphaFadeType = LightningFadeType.TIP_TO_END;
        ll.childrenProbability = .3;
        ll.filter = BlurFilter.createGlow(COLOR, 1, 8, 1);
        addChild(ll);

        p = new Point();
        randomizePoint();

        ball.addEventListener(TouchEvent.TOUCH, onTouch);
        addEventListener(Event.ENTER_FRAME, onFrameEnter);

        // Debug
        //addChild(new Bitmap(ll.bBitmapData)).y = 2;
        //addChild(new Bitmap(ll.sBitmapData)).y = 4;
    }

    private function onFrameEnter(event:Event):void {
        debugLabel.text = "LightningPool size= " + LightningPool.getSize() + " | " + ll;
        var rnd:Number = Math.random();
        if (rnd < .05) randomizePoint();
        var dx:Number = CX - ball.x;
        var dy:Number = CY - ball.y;
        var d:Number = Math.sqrt(dx * dx + dy * dy);
        if (d < 310) {
            dot2.visible = true;
            if (ll.childrenDetachedEnd) {
                trace("CLEAR #1");
                ll.childrenDetachedEnd = false;
                ll.alphaFadeType = LightningFadeType.GENERATION;
                ll.disposeAllChildren();
            }

            ll.endX = dot2.x = ball.x;
            ll.endY = dot2.y = ball.y;
        } else {
            dot2.visible = false;
            if (!ll.childrenDetachedEnd) {
                trace("CLEAR #2");
                ll.childrenDetachedEnd = true;
                ll.alphaFadeType = LightningFadeType.TIP_TO_END;
                ll.disposeAllChildren();
            }
            ll.endX = p.x;
            ll.endY = p.y;
        }
        var ddx:Number = CX - ll.endX;
        var ddy:Number = CY - ll.endY;
        var aangle:Number = Math.atan2(ddy, ddx);
        ll.startX = CX - Math.cos(aangle) * 80;
        dot1.scaleX = Math.sin(aangle);
        ll.startY = CY;
        dot1.x = ll.startX;
        dot1.y = ll.startY;
        ll.update();
    }

    private function randomizePoint():void {
        var angle:Number = -Math.random() * Math.PI;
        var dist:Number = 160 + Math.random() * 180;
        p.x = CX + Math.cos(angle) * dist;
        p.y = CY + Math.sin(angle) * dist;
    }

    private function onTouch(e:TouchEvent):void {
        var touch:Touch = e.getTouch(stage);
        if (touch.phase == TouchPhase.MOVED) {
            ball.x = touch.globalX;
            ball.y = touch.globalY;
        }
    }
}
}
