package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Graphiclist;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.tweens.misc.MultiVarTween;

    public class SalvageFloater extends Entity {

        [Embed(source="/coin_icon.png")]
        private static const COIN_IMAGE:Class;

        private var _text:Text = new Text("");
        private var _floatTween:MultiVarTween = new MultiVarTween();
        private var _alpha:Number = 1;

        private var _image:Image = new Image(COIN_IMAGE);

        public function SalvageFloater() {
            addGraphic(_image);
            _text.size = 8;
            _text.x = 9;
            _text.y = -1;
            addGraphic(_text);

            addTween(_floatTween, false);

            layer = 12;
        }

        override public function added():void {
            _alpha = 1;
            _floatTween.tween(this, {"y": y - 20, "alpha":0}, 50);
            _floatTween.complete = recycle;
            _floatTween.start();
        }

        public function recycle():void {
            FP.world.recycle(this);
        }

        public function get alpha():Number {
            return _alpha;
        }

        public function set alpha(value:Number):void {
            _alpha = value;
            _image.alpha = value;
            _text.alpha = value;
        }

        public function set value(value:int):void {
            _text.text = "" + value;
        }

        public static function show(x:Number, y:Number, value:Number):void {
            var floater:SalvageFloater = FP.world.create(SalvageFloater) as SalvageFloater;
            floater.value = value;
            floater.x = x - 12;
            floater.y = y;
        }
    }
}
