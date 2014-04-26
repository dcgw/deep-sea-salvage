package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Spritemap;

    public class Enemy extends Entity implements Destructable {

        [Embed(source="/baddie_sub.png")]
        private static const BADDIE_SUB_IMAGE:Class;

        private static const SPEED:Number = 0.8;
        private static const RATE_OF_FIRE:uint = 20;

        private var _spritemap:Spritemap = new Spritemap(BADDIE_SUB_IMAGE, 16, 16);
        private var _bubbleEmitter:BubbleEmitter = new BubbleEmitter();
        private var _fireTimer:uint = RATE_OF_FIRE;

        public function Enemy() {
            _spritemap.add("idle", [1], 1, false);
            _spritemap.add("spin", [0,1,2,1], 0.6);
            _spritemap.play("idle");
            _spritemap.centerOrigin();
            addGraphic(_spritemap);
            addGraphic(_bubbleEmitter);

            layer = 400;

            setHitbox(10, 10, 5, 5);
            type = "destructable";
        }

        public function hit(damage:int):void {
            FP.world.recycle(this);
        }
    }
}
