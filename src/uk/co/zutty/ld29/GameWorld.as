package uk.co.zutty.ld29 {
    import net.flashpunk.FP;
    import net.flashpunk.World;

    public class GameWorld extends World {
        private var _player:Player = new Player();

        public function GameWorld() {
            _player.x = FP.halfWidth;
            _player.y = FP.halfHeight;
            add(_player);
        }
    }
}
