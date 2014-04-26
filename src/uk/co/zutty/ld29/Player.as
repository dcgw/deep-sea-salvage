package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Spritemap;

    public class Player extends Entity {

        [Embed(source="/player_sub.png")]
        private static const PLAYER_SUB_IMAGE:Class;

        private var _spritemap:Spritemap = new Spritemap(PLAYER_SUB_IMAGE, 16, 16);

        public function Player() {
            _spritemap.add("idle", [1], 1, false);
            _spritemap.add("spin", [0,1,2,1], 0.5);
            _spritemap.play("idle");
            _spritemap.centerOrigin();
            addGraphic(_spritemap);
        }
    }
}
