package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;

    public class Shipwreck extends Entity {

        [Embed(source="/shipwreck.png")]
        private static const SHIPWRECK_IMAGE:Class;

        public function Shipwreck() {
            addGraphic(new Image(SHIPWRECK_IMAGE));

            layer = 450;
        }
    }
}
