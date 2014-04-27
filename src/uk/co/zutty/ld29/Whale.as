package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.tweens.misc.VarTween;
    import net.flashpunk.utils.Ease;

    public class Whale extends Entity implements Destructable {

        [Embed(source="/whale.png")]
        private static const WHALE_IMAGE:Class;

        private static const SPEED:Number = 0.1;
        private static const WEST_RANGE:Number = 1400;
        private static const EAST_RANGE:Number = 2300;

        private var _spritemap:Spritemap = new Spritemap(WHALE_IMAGE, 96, 32);
        private var _dead:Boolean = false;
        public var _sinkSpeed:Number = 0;
        private var _sinkSpeedTween:VarTween = new VarTween();

        public function Whale() {
            _spritemap.add("swim", [0,1,2,3,4,5,4,3,2,1], 0.1);
            _spritemap.add("dead_sinking", [6], 1, false);
            _spritemap.add("dead", [7], 1, false);
            _spritemap.play("swim");
            _spritemap.centerOrigin();
            addGraphic(_spritemap);

            addTween(_sinkSpeedTween);

            layer = 400;
            setHitbox(60, 24, 30, 12);
            type = "destructable";
        }

        override public function added():void {
            _spritemap.play("swim");
            _sinkSpeed = 0;
            _dead = false;
        }

        override public function moveCollideY(e:Entity):Boolean {
            if(_dead) {
                _spritemap.play("dead");
                active = false;
            }
            return true;
        }

        public function hit(damage:int):void {
            _dead = true;
            _spritemap.play("dead_sinking");
            _sinkSpeedTween.tween(this, "_sinkSpeed", 0.5, 100, Ease.quadIn);
            _sinkSpeedTween.start();
        }

        override public function update():void {
            if(_dead) {
                moveBy(0, _sinkSpeed, "terrain");
            } else {
                moveBy(_spritemap.flipped ? SPEED : -SPEED, 0, "terrain");

                if(x < WEST_RANGE && !_spritemap.flipped) {
                    _spritemap.flipped = true;
                } else if(x > EAST_RANGE && _spritemap.flipped) {
                    _spritemap.flipped = false;
                }
            }
        }
    }
}
