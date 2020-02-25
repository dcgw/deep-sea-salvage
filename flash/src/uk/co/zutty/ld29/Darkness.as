package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;

    public class Darkness extends Entity {

        private var _lightMap:LightMap = new LightMap();
        private var _depth:Number = 0;
        private var _lamp:Boolean = false;
        private var _flipped:Boolean = false;

        public function Darkness() {
            graphic = _lightMap;
            layer = 100;
        }

        public function set flipped(value:Boolean):void {
            if(value != _flipped) {
                _flipped = value;
                updateLightmap();
            }
        }

        public function set depth(value:Number):void {
            if(value != _depth) {
                _depth = value;
                updateLightmap();
            }
        }

        public function set lamp(value:Boolean):void {
            if(value != _lamp) {
                _lamp = value;
                updateLightmap();
            }
        }

        private function updateLightmap():void {
            _lightMap.updateLightMap(FP.clamp(_depth - 0.1, 0, 1), FP.clamp(_depth + 0.1, 0, 1), _flipped, _lamp);
        }
    }
}
