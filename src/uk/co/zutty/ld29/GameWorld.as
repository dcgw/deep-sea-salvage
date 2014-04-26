package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.tweens.misc.MultiVarTween;
    import net.flashpunk.utils.Ease;

    public class GameWorld extends World {

        private static const CAMERA_TWEEN_DELAY:Number = 6;
        public static const MAX_DEPTH:Number = 1000;

        private var _player:Player = new Player();
        private var _darkness:Darkness = new Darkness();
        private var _cameraTween:MultiVarTween = new MultiVarTween();

        public function GameWorld() {
            _player.x = FP.halfWidth;
            _player.y = FP.halfHeight;
            add(_player);
            add(_darkness);
            addTween(_cameraTween, true);
        }

        override public function update():void {
            super.update();

            _darkness.x = _player.x;
            _darkness.y = _player.y;
            _darkness.depth = _player.y / MAX_DEPTH;

            _cameraTween.tween(FP.camera, {x: _player.x - FP.halfWidth, y: _player.y - FP.halfHeight}, CAMERA_TWEEN_DELAY, Ease.quadInOut);
        }
    }
}
