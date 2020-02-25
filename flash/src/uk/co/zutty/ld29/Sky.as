package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;

    public class Sky extends Entity {

        [Embed(source="/sky.png")]
        private static const SKY_IMAGE:Class;

        public function Sky() {
            addGraphic(new Image(SKY_IMAGE));
            layer = 500;
            y = -45;
        }

        override public function update():void {
            x = FP.camera.x;
        }
    }
}
