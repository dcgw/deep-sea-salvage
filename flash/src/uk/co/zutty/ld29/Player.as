package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Emitter;
    import net.flashpunk.graphics.Graphiclist;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.tweens.misc.VarTween;
    import net.flashpunk.utils.Ease;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;

    public class Player extends Entity implements Destructable {

        [Embed(source="/player_sub.png")]
        private static const PLAYER_SUB_IMAGE:Class;

        private static const SPEED:Number = 0.8;
        private static const RATE_OF_FIRE:uint = 20;
        private static const STARTING_HEALTH:int = 4;
        private static const LAMP_DEPTH:Number = 200;

        private var _spritemap:Spritemap = new Spritemap(PLAYER_SUB_IMAGE, 16, 16);
        private var _bubbleEmitter:BubbleEmitter = new BubbleEmitter();
        private var _fireTimer:uint = RATE_OF_FIRE;

        private var _health:int = STARTING_HEALTH;
        private var _salvage:int = 0;
        private var _dead:Boolean = false;
        public var _sinkSpeed:Number = 0;
        private var _sinkSpeedTween:VarTween = new VarTween();

        public function Player() {
            _spritemap.add("idle", [1], 1, false);
            _spritemap.add("spin", [0,1,2,1], 0.6);
            _spritemap.add("dead", [3], 1, false);
            _spritemap.play("idle");
            _spritemap.centerOrigin();
            addGraphic(_spritemap);
            addGraphic(_bubbleEmitter);

            addTween(_sinkSpeedTween);

            layer = 200;

            setHitbox(10, 10, 5, 5);
            type = "destructable";

            Input.define("left", Key.LEFT, Key.A);
            Input.define("right", Key.RIGHT, Key.D);
            Input.define("up", Key.UP, Key.W);
            Input.define("down", Key.DOWN, Key.S);
            Input.define("fire", Key.SPACE, Key.X);
            Input.define("salvage", Key.SHIFT, Key.C);
        }

        override public function added():void {
            _sinkSpeed = 0;
            _health = STARTING_HEALTH;
            _dead = false;
        }

        public function get salvage():int {
            return _salvage;
        }

        public function get health():int {
            return _health;
        }

        public function get dead():Boolean {
            return _dead;
        }

        public function get lampOn():Boolean {
            return !_dead && y > LAMP_DEPTH;
        }

        public function hit(damage:int):void {
            if(!active) {
                return;
            }

            _health -= damage;
            if(_health <= 0) {
                _dead = true;
                _spritemap.play("dead");
                _sinkSpeedTween.tween(this, "_sinkSpeed", 0.5, 100, Ease.quadIn);
                _sinkSpeedTween.start();
            }
        }

        public function get flipped():Boolean {
            return _spritemap.flipped;
        }

        override public function moveCollideY(e:Entity):Boolean {
            if(_dead) {
                active = false;
            }
            return true;
        }

        override public function update():void {
            if(_dead) {
                moveBy(0, _sinkSpeed, "terrain");
                return;
            }

            var moved:Boolean = false;
            var mx:Number = 0;
            var my:Number = 0;

            if(Input.check("left")) {
                mx = -SPEED;
                moved = true;
                _spritemap.flipped = false;
            } else if(Input.check("right")) {
                mx = SPEED;
                moved = true;
                _spritemap.flipped = true;
            }

            if(Input.check("up")) {
                my = -SPEED;
                moved = true;
            } else if(Input.check("down")) {
                my = SPEED;
                moved = true;
            }

            _spritemap.play(moved ? "spin" : "idle");

            if(moved) {
                _bubbleEmitter.emitBubbles(_spritemap.flipped, 6, -10, -2);
            }

            moveBy(mx, my, "terrain");

            var hud:Hud = (FP.world as GameWorld).hud;

            if(y < GameWorld.SURFACE_DEPTH) {
                y = GameWorld.SURFACE_DEPTH;
            } else if(y > GameWorld.MAX_DEPTH) {
                y = GameWorld.MAX_DEPTH;
            }
            if(x < GameWorld.WEST_BORDER) {
                x = GameWorld.WEST_BORDER;
                hud.showYouCantGoThatWay();
            } else if(x > GameWorld.EAST_BORDER) {
                x = GameWorld.EAST_BORDER;
                hud.showYouCantGoThatWay();
            }

            hud.showInteract = false;

            var salvage:Salvage = collide("salvage", x, y) as Salvage;
            if(salvage && !salvage.claimed) {
                hud.interactText = salvage.interactText;
                hud.showInteract = true;

                if(Input.pressed("salvage")) {
                    _salvage += salvage.claim();
                }
            }

            if(++_fireTimer > RATE_OF_FIRE && Input.pressed("fire")) {
                _fireTimer = 0;
                var torpedo:Torpedo = FP.world.create(Torpedo) as Torpedo;
                torpedo.x = x;
                torpedo.y = y;
                torpedo.flipped = _spritemap.flipped;
            }
        }
    }
}
