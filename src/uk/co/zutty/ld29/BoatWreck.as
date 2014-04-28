package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;

    public class BoatWreck extends Entity {

        [Embed(source="/shipwreck2.png")]
        private static const BOAT_WRECK_IMAGE:Class;

        public function BoatWreck() {
            addGraphic(new Image(BOAT_WRECK_IMAGE));

            layer = 450;
        }
    }
}
