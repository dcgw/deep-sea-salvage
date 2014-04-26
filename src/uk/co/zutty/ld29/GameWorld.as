package uk.co.zutty.ld29 {
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.tweens.misc.MultiVarTween;
    import net.flashpunk.utils.Ease;

    public class GameWorld extends World {

        private static const CAMERA_TWEEN_DELAY:Number = 6;

        private var _player:Player = new Player();
        private var _cameraTween:MultiVarTween = new MultiVarTween();

        public function GameWorld() {
            _player.x = FP.halfWidth;
            _player.y = FP.halfHeight;
            add(_player);
            addTween(_cameraTween, true);
        }

        override public function update():void {
            super.update();

            _cameraTween.tween(FP.camera, {x: _player.x - FP.halfWidth, y: _player.y - FP.halfHeight}, CAMERA_TWEEN_DELAY, Ease.quadInOut);
        }
    }
}
