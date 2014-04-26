package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Spritemap;

    public class Torpedo extends Entity {

        [Embed(source="/torpedo.png")]
        private static const TORPEDO_IMAGE:Class;

        private static const SPEED:Number = 2;

        private var _spritemap:Spritemap = new Spritemap(TORPEDO_IMAGE, 8, 3);
        private var _bubbleEmitter:BubbleEmitter = new BubbleEmitter();

        private var _flipped:Boolean = false;

        public function Torpedo() {
            _spritemap.centerOrigin();
            _spritemap.add("spin", [0,1], 0.6);
            _spritemap.play("spin")
            addGraphic(_spritemap);
            addGraphic(_bubbleEmitter);

            layer = 300;
        }

        public function set flipped(value:Boolean):void {
            _flipped = value;
            _spritemap.flipped = value;
        }

        override public function update():void {
            x += _flipped ? SPEED : -SPEED;
            _bubbleEmitter.emitBubbles(_flipped, 3, -7, -2);
        }
    }
}
