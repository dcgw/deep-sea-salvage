package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Emitter;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;

    public class Player extends Entity {

        [Embed(source="/player_sub.png")]
        private static const PLAYER_SUB_IMAGE:Class;

        private static const SPEED:Number = 0.8;
        private static const RATE_OF_FIRE:uint = 20;

        private var _spritemap:Spritemap = new Spritemap(PLAYER_SUB_IMAGE, 16, 16);
        private var _bubbleEmitter:BubbleEmitter = new BubbleEmitter();
        private var _fireTimer:uint = RATE_OF_FIRE;

        public function Player() {
            _spritemap.add("idle", [1], 1, false);
            _spritemap.add("spin", [0,1,2,1], 0.6);
            _spritemap.play("idle");
            _spritemap.centerOrigin();
            addGraphic(_spritemap);
            addGraphic(_bubbleEmitter);

            layer = 200;

            Input.define("left", Key.LEFT, Key.A);
            Input.define("right", Key.RIGHT, Key.D);
            Input.define("up", Key.UP, Key.W);
            Input.define("down", Key.DOWN, Key.S);
            Input.define("fire", Key.SPACE, Key.X);
        }

        public function get flipped():Boolean {
            return _spritemap.flipped;
        }

        override public function update():void {
            var moved:Boolean = false;

            if(Input.check("left")) {
                x -= SPEED;
                moved = true;
                _spritemap.flipped = false;
            } else if(Input.check("right")) {
                x += SPEED;
                moved = true;
                _spritemap.flipped = true;
            }

            if(Input.check("up")) {
                y -= SPEED;
                moved = true;
            } else if(Input.check("down")) {
                y += SPEED;
                moved = true;
            }

            _spritemap.play(moved ? "spin" : "idle");

            if(moved) {
                _bubbleEmitter.emitBubbles(_spritemap.flipped, 6, -10, -2);
            }

            if(y < 0) {
                y = 0;
            } else if(y > GameWorld.MAX_DEPTH) {
                y = GameWorld.MAX_DEPTH;
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
