package uk.co.zutty.ld29 {
    import flash.geom.Point;

    import net.flashpunk.Entity;

    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.tweens.misc.VarTween;
    import net.flashpunk.utils.Ease;

    public class Enemy extends Entity implements Destructable, Salvage {

        [Embed(source="/baddie_sub.png")]
        private static const BADDIE_SUB_IMAGE:Class;

        private static const SPEED:Number = 0.8;
        private static const RATE_OF_FIRE:uint = 20;
        private static const AGGRO_RANGE:Number = 100;
        private static const CLOSE_RANGE:Number = 50;
        private static const FIRE_RANGE:Number = 70;
        private static const RETREAT_RANGE:Number = 200;
        private static const Y_ALIGN_RANGE:Number = 16;
        private static const SALVAGE_VALUE:Number = 50;

    private var _spritemap:Spritemap = new Spritemap(BADDIE_SUB_IMAGE, 16, 16);
        private var _bubbleEmitter:BubbleEmitter = new BubbleEmitter();
        private var _fireTimer:uint = RATE_OF_FIRE;
        private var _dead:Boolean = false;
        public var _sinkSpeed:Number = 0;
        private var _sinkSpeedTween:VarTween = new VarTween();
        private var _spawnX:Number = 0;
        private var _spawnY:Number = 0;
        private var _salvageClaimed:Boolean = false;

        public function Enemy() {
            _spritemap.add("idle", [1], 1, false);
            _spritemap.add("spin", [0,1,2,1], 0.6);
            _spritemap.add("dead", [3], 1, false);
            _spritemap.play("idle");
            _spritemap.centerOrigin();
            addGraphic(_spritemap);
            addGraphic(_bubbleEmitter);

            addTween(_sinkSpeedTween);

            layer = 400;

            setHitbox(10, 10, 5, 5);
            type = "destructable";
        }

        override public function added():void {
            _sinkSpeed = 0;
            _dead = false;
        }

        public function spawn(x:Number, y:Number):void {
            _spawnX = x;
            _spawnY = y;
            this.x = x;
            this.y = y;
        }

        public function hit(damage:int):void {
            _dead = true;
            _spritemap.play("dead");
            _sinkSpeedTween.tween(this, "_sinkSpeed", 0.5, 100, Ease.quadIn);
            _sinkSpeedTween.start();
        }

        private function _moveTowards(x:Number, y:Number) {
            moveTowards(x,  y, SPEED, "terrain");
            _spritemap.flipped = this.x < x;
            _bubbleEmitter.emitBubbles(_spritemap.flipped, 6, -10, -2);
        }

        override public function moveCollideY(e:Entity):Boolean {
            if(_dead) {
                type = "salvage";
                active = false;
            }
            return true;
        }

        public function get claimed():Boolean {
            return _salvageClaimed;
        }

        public function claim():int {
            _salvageClaimed = true;
            SalvageFloater.show(x,  y - 8, SALVAGE_VALUE);
            return SALVAGE_VALUE;
        }

        public function get interactText():String {
            return "Salvage";
        }

        override public function update():void {
            var player:Player = (FP.world as GameWorld).player;
            ++_fireTimer;

            if(_dead) {
                moveBy(0, _sinkSpeed, "terrain");
            } else {
                var spawnDist:Number = player.distanceToPoint(_spawnX, _spawnY);
                var dist:Number = distanceFrom(player);
                var yDist:Number = player.y - y;

                if((spawnDist > RETREAT_RANGE || player.dead) && !(x == _spawnX && y == _spawnY)) {
                    _moveTowards(_spawnX,  _spawnY);
                } else if(dist <= AGGRO_RANGE && dist > CLOSE_RANGE && !player.dead) {
                    _moveTowards(player.x,  player.y);
                } else if(dist <= AGGRO_RANGE && !player.dead) {
                    _moveTowards(x, player.y);
                    _spritemap.flipped = x < player.x;
                }

                if(_fireTimer > RATE_OF_FIRE && dist <= FIRE_RANGE && yDist <= Y_ALIGN_RANGE && !player.dead) {
                    _fireTimer = 0;
                    var torpedo:Torpedo = FP.world.create(Torpedo) as Torpedo;
                    torpedo.x = x;
                    torpedo.y = y;
                    torpedo.flipped = _spritemap.flipped;
                }
            }
        }
    }
}
