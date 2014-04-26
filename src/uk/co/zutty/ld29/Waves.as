package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;

    public class Waves extends Entity {

        [Embed(source="/waves.png")]
        private static const WAVES_IMAGE:Class;

        public function Waves() {
            addGraphic(new Image(WAVES_IMAGE));

            layer = 100;
            y = 1;
        }

        override public function update():void {
            x = Math.round(FP.camera.x);
        }
    }
}
