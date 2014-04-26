package uk.co.zutty.ld29 {
    import flash.geom.Point;

    import net.flashpunk.FP;

    import net.flashpunk.graphics.Emitter;
    import net.flashpunk.graphics.Particle;

    public class BubbleEmitter extends Emitter {

        [Embed(source="/bubble.png")]
        private static const BUBBLE_IMAGE:Class;

        public function BubbleEmitter() {
            super(BUBBLE_IMAGE, 5, 5);
            newType("bubble_left", [0,1,2]);
            newType("bubble_right", [0,1,2]);
            setMotion("bubble_left", 170, 50, 40, 20, 50, 20);
            setMotion("bubble_right", -10, 50, 40, 20, 50, 20);
            setAlpha("bubble_left", 0.8, 0.2);
            setAlpha("bubble_right", 0.8, 0.2);
            setGravity("bubble_left", -100);
            setGravity("bubble_right", -100);
        }

        public function emitBubbles(flipped:Boolean, x:Number, xFlipped:Number, y:Number):void {
            emit(flipped ? "bubble_left" : "bubble_right", flipped ? xFlipped : x, y);
        }

        override public function updateParticle(point:Point, p:Particle):void {
            trace(point.y - FP.camera.y);
            if(point.y + FP.camera.y - 3 <= 0) {
                p.kill();
            }
        }
    }
}
