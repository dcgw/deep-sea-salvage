package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;

    public class Darkness extends Entity {

        private var _lightMap:LightMap = new LightMap();
        private var _depth:Number = 0;
        private var _flipped:Boolean = false;

        public function Darkness() {
            graphic = _lightMap;
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

        private function updateLightmap():void {
            var depthVal = FP.clamp(_depth, 0.1, 0.9);
            _lightMap.updateLightMap(depthVal - 0.1, depthVal + 0.1, _flipped);
        }
    }
}
