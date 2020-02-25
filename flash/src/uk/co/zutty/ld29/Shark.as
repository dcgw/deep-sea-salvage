package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.tweens.misc.VarTween;
    import net.flashpunk.utils.Ease;

    public class Shark extends Entity implements Destructable {

        [Embed(source="/shark.png")]
        private static const SHARK_IMAGE:Class;

        private static const IDLE_SPEED:Number = 0.3;
        private static const PURSUE_SPEED:Number = 0.7;
        private static const ATTACK_DELAY:Number = 50;
        private static const AGGRO_RANGE:Number = 80;
        private static const RETREAT_RANGE:Number = 160;

        private var _spritemap:Spritemap = new Spritemap(SHARK_IMAGE, 64, 24);
        private var _dead:Boolean = false;
        public var _sinkSpeed:Number = 0;
        private var _sinkSpeedTween:VarTween = new VarTween();
        private var _spawnX:Number = 0;
        private var _spawnY:Number = 0;
        private var _attackTimer:uint = ATTACK_DELAY;

        public function Shark() {
            _spritemap.add("swim", [0,1,2,1,0,3,4,3], 0.1);
            _spritemap.add("bite", [5,0], 0.1);
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

        public function spawn(x:Number, y:Number):void {
            _spawnX = x;
            _spawnY = y;
            this.x = x;
            this.y = y;
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

        public function swim():void {
            _spritemap.callback = null;
            _spritemap.play("swim");
        }

        override public function update():void {
            var player:Player = (FP.world as GameWorld).player;
            ++_attackTimer;

            if(_dead) {
                moveBy(0, _sinkSpeed, "terrain");
            } else {
                var spawnDist:Number = player.distanceToPoint(_spawnX, _spawnY);
                var dist:Number = distanceFrom(player);
                var yDist:Number = player.y - y;

                if((spawnDist > RETREAT_RANGE || player.dead) && !(x == _spawnX && y == _spawnY)) {
                    moveTowards(_spawnX,  _spawnY, IDLE_SPEED);
                    _spritemap.flipped = x < _spawnX;
                } else if(dist <= AGGRO_RANGE && !player.dead) {
                    moveTowards(player.x,  player.y,  PURSUE_SPEED);
                    _spritemap.flipped = x < player.x;
                }

                var target:Destructable = collide("destructable", x, y) as Destructable;
                if(_attackTimer > ATTACK_DELAY && target) {
                    _attackTimer = 0;
                    target.hit(1);
                    _spritemap.play("bite");
                    _spritemap.callback = swim;
                }
            }
        }
    }
}
