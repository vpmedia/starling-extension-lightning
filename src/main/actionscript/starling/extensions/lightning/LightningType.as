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
 * Lightning Preset Helper
 *
 * @author Pierluigi Pesenti (blog.oaxoa.com)
 * @contributor Andras Csizmadia (www.vpmedia.eu)
 * @contributor IonSwitz (www.github.com/IonSwitz)
 *
 */
public final class LightningType {

    /**
     * TBD
     */
    public static const DISCHARGE:String = "discharge";

    /**
     * TBD
     */
    public static const LIGHTNING:String = "lightning";

    /**
     * TBD
     */
    public static const SHOCK:String = "shock";

    /**
     * TBD
     */
    public static function setType(lightning:Lightning, type:String):void {
        switch (type) {
            case DISCHARGE :
                lightning.childrenLifeSpanMin = 1;
                lightning.childrenLifeSpanMax = 3;
                lightning.childrenProbability = 1; // [0,1]
                lightning.childrenMaxGenerations = 3;
                lightning.childrenMaxCount = 4;
                lightning.childrenAngleVariation = 110;
                lightning.thickness = 2;
                lightning.steps = 100;
                lightning.smoothPercentage = 50; // [0,100]
                lightning.wavelength = .3;
                lightning.amplitude = .5;
                lightning.speed = .7;
                lightning.maxLength = 0;
                lightning.maxLengthVary = 0;
                lightning.childrenDetachedEnd = false; // true = lightning ; false = discharge
                lightning.alphaFadeType = LightningFadeType.GENERATION;
                lightning.thicknessFadeType = LightningFadeType.NONE;
                break;
            case LIGHTNING :
                lightning.childrenLifeSpanMin = .1;
                lightning.childrenLifeSpanMax = 2;
                lightning.childrenProbability = 1;
                lightning.childrenMaxGenerations = 3;
                lightning.childrenMaxCount = 4;
                lightning.childrenAngleVariation = 130;
                lightning.thickness = 3;
                lightning.steps = 100;
                lightning.smoothPercentage = 50;
                lightning.wavelength = .3;
                lightning.amplitude = .5;
                lightning.speed = 1;
                lightning.maxLength = 0;
                lightning.maxLengthVary = 0;
                lightning.childrenDetachedEnd = true;
                lightning.alphaFadeType = LightningFadeType.TIP_TO_END;
                lightning.thicknessFadeType = LightningFadeType.GENERATION;
                break;
            case SHOCK :
                lightning.childrenLifeSpanMin = .1;
                lightning.childrenLifeSpanMax = 2;
                lightning.childrenProbability = 1;
                lightning.childrenMaxGenerations = 4;
                lightning.childrenMaxCount = 6;
                lightning.childrenAngleVariation = 10;
                lightning.thickness = 5;
                lightning.thickness = 3;
                lightning.steps = 100;
                lightning.smoothPercentage = 50;
                lightning.wavelength = .3;
                lightning.amplitude = .5;
                lightning.speed = 1;
                lightning.maxLength = 0;
                lightning.maxLengthVary = 0;
                lightning.childrenDetachedEnd = true;
                lightning.alphaFadeType = LightningFadeType.TIP_TO_END;
                lightning.thicknessFadeType = LightningFadeType.GENERATION;
                break;
        }
    }
}
}