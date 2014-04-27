package uk.co.zutty.ld29 {
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.tweens.misc.MultiVarTween;
    import net.flashpunk.utils.Ease;

    public class GameWorld extends World {

        private static const CAMERA_TWEEN_DELAY:Number = 6;

        public static const SURFACE_DEPTH:Number = 2;
        public static const MAX_DEPTH:Number = 1000;
        public static const WEST_BORDER:Number = 110;
        public static const EAST_BORDER:Number = 2400 - 110;

        private var _player:Player = new Player();
        private var _darkness:Darkness = new Darkness();
        private var _cameraTween:MultiVarTween = new MultiVarTween();

        public function GameWorld() {
            var ogmoLevel:OgmoLoader = new OgmoLoader();
            add(ogmoLevel.terrain);

            _player.x = 1200;
            _player.y = 0;
            FP.camera.x = 1200;
            FP.camera.y = 0;
            add(_player);
            add(_darkness);

            add(new Sky());
            add(new Waves());

            var enemy:Enemy = new Enemy();
            enemy.x = 1200;
            enemy.y = 100;
            add(enemy);

            addTween(_cameraTween, true);
        }

        override public function update():void {
            super.update();

            _darkness.x = _player.x;
            _darkness.y = _player.y;
            _darkness.depth = _player.y / MAX_DEPTH;
            _darkness.flipped = _player.flipped;

            _cameraTween.tween(FP.camera, {x: _player.x - FP.halfWidth, y: _player.y - FP.halfHeight}, CAMERA_TWEEN_DELAY, Ease.quadInOut);
        }
    }
}
