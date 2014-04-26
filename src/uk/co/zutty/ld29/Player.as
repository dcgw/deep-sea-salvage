package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Emitter;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;

    public class Player extends Entity {

        [Embed(source="/player_sub.png")]
        private static const PLAYER_SUB_IMAGE:Class;
        [Embed(source="/bubble.png")]
        private static const BUBBLE_IMAGE:Class;

        private static const SPEED:Number = 0.8;

        private var _spritemap:Spritemap = new Spritemap(PLAYER_SUB_IMAGE, 16, 16);
        private var _bubbleEmitter:Emitter = new Emitter(BUBBLE_IMAGE, 5, 5);

        public function Player() {
            _spritemap.add("idle", [1], 1, false);
            _spritemap.add("spin", [0,1,2,1], 0.6);
            _spritemap.play("idle");
            _spritemap.centerOrigin();
            addGraphic(_spritemap);
            _bubbleEmitter.newType("bubble_left", [0,1,2]);
            _bubbleEmitter.newType("bubble_right", [0,1,2]);
            _bubbleEmitter.setMotion("bubble_left", 170, 50, 40, 20, 50, 20);
            _bubbleEmitter.setMotion("bubble_right", -10, 50, 40, 20, 50, 20);
            _bubbleEmitter.setAlpha("bubble_left", 0.8, 0.2);
            _bubbleEmitter.setAlpha("bubble_right", 0.8, 0.2);
            _bubbleEmitter.setGravity("bubble_left", -100);
            _bubbleEmitter.setGravity("bubble_right", -100);
            //_bubbleEmitter
            addGraphic(_bubbleEmitter);

            Input.define("left", Key.LEFT, Key.A);
            Input.define("right", Key.RIGHT, Key.D);
            Input.define("up", Key.UP, Key.W);
            Input.define("down", Key.DOWN, Key.S);
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
                _bubbleEmitter.emit(_spritemap.flipped ? "bubble_left" : "bubble_right", _spritemap.flipped ? -10 : 6, -2);
            }

            if(y < 0) {
                y = 0;
            } else if(y > GameWorld.MAX_DEPTH) {
                y = GameWorld.MAX_DEPTH;
            }
        }
    }
}
