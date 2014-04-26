package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Spritemap;

    public class Torpedo extends Entity {

        [Embed(source="/torpedo.png")]
        private static const TORPEDO_IMAGE:Class;

        private static const SPEED:Number = 2;
        private static const PRIME_DELAY:uint = 7;

        private var _spritemap:Spritemap = new Spritemap(TORPEDO_IMAGE, 8, 3);
        private var _bubbleEmitter:BubbleEmitter = new BubbleEmitter();

        private var _flipped:Boolean = false;
        private var _primed:Boolean = false;
        private var _timer:uint = 0;

        public function Torpedo() {
            _spritemap.centerOrigin();
            _spritemap.add("spin", [0,1], 0.6);
            _spritemap.play("spin")
            addGraphic(_spritemap);
            addGraphic(_bubbleEmitter);

            layer = 300;

            setHitbox(8, 3, 4, 2);
            type = "torpedo";
        }

        override public function added():void {
            _primed = false;
            _timer = 0;
        }

        public function set flipped(value:Boolean):void {
            _flipped = value;
            _spritemap.flipped = value;
        }

        override public function update():void {
            x += _flipped ? SPEED : -SPEED;
            _bubbleEmitter.emitBubbles(_flipped, 3, -7, -2);

            ++_timer;

            if(!_primed && _timer >= PRIME_DELAY) {
                _primed = true;
            }

            if(_primed) {
                var entity:Entity = collide("destructable", x, y);
                if(entity) {
                    FP.world.recycle(this);
                    (entity as Destructable).hit(1);
                }
            }
        }
    }
}
