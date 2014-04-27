package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Spritemap;

    import uk.co.zutty.ld29.SalvageFloater;

    public class Treasure extends Entity implements Salvage {

        [Embed(source="/treasure.png")]
        private static const TREASURE_IMAGE:Class;

        private static const VALUE_THRESHOLD_SOME = 500;
        private static const VALUE_THRESHOLD_LOTS = 1000;

        private var _spritemap:Spritemap = new Spritemap(TREASURE_IMAGE, 16, 16);
        private var _claimed:Boolean = false;
        private var _opened:Boolean = false;
        private var _value:int = 500;

        public function Treasure() {
            _spritemap.add("closed", [0], 1, false);
            _spritemap.add("open_empty", [1], 1, false);
            _spritemap.add("open_1", [2], 1, false);
            _spritemap.add("open_2", [3], 1, false);
            _spritemap.add("open_3", [4], 1, false);
            _spritemap.centerOrigin();
            addGraphic(_spritemap);

            layer = 400;

            setHitbox(12, 12, 6, 6);
            type = "salvage";
        }

        override public function added():void {
            _spritemap.play("closed");
            _claimed = false;
            _opened = false;
        }

        public function set value(value:int):void {
            _value = value;
        }

        public function get claimed():Boolean {
            return _claimed;
        }

        public function get interactText():String {
            return _opened ? "Salvage" : "Open";
        }

        public function claim():int {
            if(_claimed) {
                return 0;
            }

            if(!_opened) {
                var openAnim:String;

                if(_value == 0) {
                    openAnim = "open_empty";
                    _claimed = true;
                } else if(_value < VALUE_THRESHOLD_SOME) {
                    openAnim = "open_1";
                } else if(_value < VALUE_THRESHOLD_LOTS) {
                    openAnim = "open_2";
                } else {
                    openAnim = "open_3";
                }

                _spritemap.play(openAnim);
                _opened = true;
                return 0;
            } else {
                _spritemap.play("open_empty");
                _claimed = true;
                SalvageFloater.show(x,  y - 8, _value);
                return _value;
            }
        }
    }
}
