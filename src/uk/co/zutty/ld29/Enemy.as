package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.tweens.misc.VarTween;
    import net.flashpunk.utils.Ease;

    public class Enemy extends Entity implements Destructable {

        [Embed(source="/baddie_sub.png")]
        private static const BADDIE_SUB_IMAGE:Class;

        private static const SPEED:Number = 0.8;
        private static const RATE_OF_FIRE:uint = 20;

        private var _spritemap:Spritemap = new Spritemap(BADDIE_SUB_IMAGE, 16, 16);
        private var _bubbleEmitter:BubbleEmitter = new BubbleEmitter();
        private var _fireTimer:uint = RATE_OF_FIRE;
        private var _dead:Boolean = false;
        public var _sinkSpeed:Number = 0;
        private var _sinkSpeedTween:VarTween = new VarTween();

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

        public function hit(damage:int):void {
            _dead = true;
            _spritemap.play("dead");
            _sinkSpeedTween.tween(this, "_sinkSpeed", 0.5, 100, Ease.quadIn);
            _sinkSpeedTween.start();
        }

        override public function update():void {
            if(_dead) {
                y += _sinkSpeed;
            }
        }
    }
}
