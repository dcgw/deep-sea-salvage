package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.tweens.misc.VarTween;
    import net.flashpunk.utils.Ease;

    public class Shark extends Entity implements Destructable {

        [Embed(source="/shark.png")]
        private static const SHARK_IMAGE:Class;

        private static const IDLE_SPEED:Number = 0.3;
        private static const PURSUE_SPEED:Number = 0.8;

        private var _spritemap:Spritemap = new Spritemap(SHARK_IMAGE, 64, 24);
        private var _dead:Boolean = false;
        public var _sinkSpeed:Number = 0;
        private var _sinkSpeedTween:VarTween = new VarTween();

        public function Shark() {
            _spritemap.add("swim", [0,1,2,1,0,3,4,3], 0.1);
            _spritemap.add("bite", [5,0], 0.2, false);
            _spritemap.add("dead_sinking", [6], 1, false);
            _spritemap.add("dead", [7], 1, false);
            _spritemap.play("swim");
            _spritemap.centerOrigin();
            addGraphic(_spritemap);

            addTween(_sinkSpeedTween);

            layer = 400;
            setHitbox(50, 20, 25, 10);
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
            if(!active) {
                return;
            }

            _dead = true;
            _spritemap.play("dead_sinking");
            _sinkSpeedTween.tween(this, "_sinkSpeed", 0.5, 100, Ease.quadIn);
            _sinkSpeedTween.start();
        }

        override public function update():void {
            if(_dead) {
                moveBy(0, _sinkSpeed, "terrain");
            } else {
                moveBy(_spritemap.flipped ? IDLE_SPEED : -IDLE_SPEED, 0, "terrain");

            }
        }
    }
}
