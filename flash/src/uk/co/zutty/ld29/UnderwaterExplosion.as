package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Emitter;
    import net.flashpunk.graphics.Spritemap;

    public class UnderwaterExplosion extends Entity {

        [Embed(source="/explosion_wake.png")]
        private static const EXPLOSION_WAKE_IMAGE:Class;
        [Embed(source="/explosion_cloud.png")]
        private static const EXPLOSION_CLOUD_IMAGE:Class;
        [Embed(source="/debris.png")]
        private static const DEBRIS_IMAGE:Class;

        private var _wakeSpritemap:Spritemap = new Spritemap(EXPLOSION_WAKE_IMAGE, 24, 24);
        private var _cloudEmitter:Emitter = new Emitter(EXPLOSION_CLOUD_IMAGE, 16, 16);
        private var _debrisEmitter:Emitter = new Emitter(DEBRIS_IMAGE, 6, 6);

        public function UnderwaterExplosion() {
            _wakeSpritemap.add("wake", [0,1,2,3,4,5,6,7], 0.2, false);
            _wakeSpritemap.centerOrigin();
            addGraphic(_wakeSpritemap)

            _cloudEmitter.newType("cloud", [0,1,2])
            _cloudEmitter.setMotion("cloud", 0, 5, 80, 360, 5, 20);
            _cloudEmitter.setAlpha("cloud", 0.8, 0);
            _cloudEmitter.setGravity("cloud", -50);
            addGraphic(_cloudEmitter);

            _debrisEmitter.newType("debris-a", [0])
            _debrisEmitter.setMotion("debris-a", 0, 5, 80, 360, 5, 20);
            _debrisEmitter.setGravity("debris-a", 30);

            _debrisEmitter.newType("debris-b", [1])
            _debrisEmitter.setMotion("debris-b", 0, 5, 80, 360, 5, 20);
            _debrisEmitter.setGravity("debris-b", 30);

            _debrisEmitter.newType("debris-c", [2])
            _debrisEmitter.setMotion("debris-c", 0, 50, 80, 360, 25, 50);
            _debrisEmitter.setGravity("debris-c", 30);

            addGraphic(_debrisEmitter);

            layer = 150;
        }

        public function trigger():void {
            _wakeSpritemap.play("wake");
            for(var i:int = 0; i < 5; i++) {
                _cloudEmitter.emit("cloud", -8, -8);
            }
            _debrisEmitter.emit("debris-a", -3, -3);
            _debrisEmitter.emit("debris-b", -3, -3);
            _debrisEmitter.emit("debris-c", -3, -3);
        }
    }
}
