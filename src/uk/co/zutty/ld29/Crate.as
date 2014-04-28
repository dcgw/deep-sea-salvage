package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Spritemap;

    import uk.co.zutty.ld29.SalvageFloater;

    public class Crate extends Entity implements Salvage {

        [Embed(source="/crate.png")]
        private static const CRATE_IMAGE:Class;

        private var _claimed:Boolean = false;
        private var _value:int = 0;

        public function Crate() {
            var image:Image = new Image(CRATE_IMAGE);
            image.centerOrigin();
            addGraphic(image);

            layer = 400;

            setHitbox(12, 12, 6, 6);
            type = "salvage";
        }

        override public function added():void {
            _claimed = false;
        }

        public function set value(value:int):void {
            _value = value;
        }

        public function get claimed():Boolean {
            return _claimed;
        }

        public function get interactText():String {
            return "Salvage";
        }

        public function claim():int {
            _claimed = true;
            SalvageFloater.show(x,  y - 8, _value);
            FP.world.recycle(this);
            return _value;
        }
    }
}
