package uk.co.zutty.ld29 {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.BlendMode;
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

        [Embed(source="/lamp_lightmap.png")]
        private static const LAMP_LIGHTMAP_IMAGE:Class;

        private static const MARGIN:int = 30;

        private var _lampBitmap:Bitmap = new Bitmap(FP.getBitmap(LAMP_LIGHTMAP_IMAGE));

        private var _lightMap:BitmapData = new BitmapData(FP.width + MARGIN, FP.height + MARGIN, true, 0);
        private var _lightMapRect:Rectangle = _lightMap.rect;

        public function updateLightMap(startAlpha:Number, endAlpha:Number, flipped:Boolean, lamp:Boolean):void {
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

            if(lamp) {
                FP.matrix.identity();
                FP.matrix.tx = _lightMapRect.width / 2;
                var offX:Number = _lampBitmap.width + 6;
                FP.matrix.tx += flipped ? offX : -offX;
                FP.matrix.ty = -(_lampBitmap.height / 2) + (_lightMapRect.height / 2) + 2;
                FP.matrix.a = flipped ? -1 : 1;

                _lightMap.draw(_lampBitmap, FP.matrix, null, BlendMode.ERASE);
            }
        }

        override public function render(target:BitmapData, point:Point, camera:Point):void {
            _point.x = point.x + x - (_lightMapRect.width / 2) - camera.x * scrollX;
            _point.y = point.y + y - (_lightMapRect.height / 2) - camera.y * scrollY;

            target.copyPixels(_lightMap, _lightMapRect, _point, null, null, true);
        }
    }
}
