package uk.co.zutty.ld29 {
    import flash.display.BitmapData;
    import flash.display.GradientType;
    import flash.display.InterpolationMethod;
    import flash.display.Shape;
    import flash.display.SpreadMethod;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    import net.flashpunk.FP;

    import net.flashpunk.Graphic;

    public class LightMap extends Graphic {

        private static const MARGIN:int = 30;

        private var _lightMap:BitmapData = new BitmapData(FP.width + MARGIN, FP.height + MARGIN, true, 0);
        private var _lightMapRect:Rectangle = _lightMap.rect;

        public function updateLightMap(startAlpha:Number, endAlpha:Number):void {
            var type:String = GradientType.LINEAR;
            var colors:Array = [0x000000, 0x000000];
            var alphas:Array = [startAlpha, endAlpha];
            var ratios:Array = [0, 255];
            var spreadMethod:String = SpreadMethod.PAD;
            var interp:String = InterpolationMethod.LINEAR_RGB;
            var boxWidth:Number = _lightMap.rect.width;
            var boxHeight:Number = _lightMap.rect.height;
            var boxRotation:Number = Math.PI / 2;
            var matrix:Matrix = new Matrix();

            matrix.createGradientBox(boxWidth, boxHeight, boxRotation);

            var shape:Shape = new Shape();

            shape.graphics.beginGradientFill(type, colors, alphas, ratios, matrix, spreadMethod, interp);
            shape.graphics.drawRect(0, 0, boxWidth, boxHeight);
            shape.graphics.endFill();

            _lightMap.fillRect(_lightMapRect, 0);
            _lightMap.draw(shape);
        }

        override public function render(target:BitmapData, point:Point, camera:Point):void {
            _point.x = point.x + x - (_lightMapRect.width / 2) - camera.x * scrollX;
            _point.y = point.y + y - (_lightMapRect.height / 2) - camera.y * scrollY;

            target.copyPixels(_lightMap, _lightMapRect, _point, null, null, true);
        }
    }
}
