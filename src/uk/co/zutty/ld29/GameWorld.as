package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.tweens.misc.MultiVarTween;
    import net.flashpunk.utils.Ease;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;

    public class GameWorld extends World {

        private static const CAMERA_TWEEN_DELAY:Number = 6;

        public static const SURFACE_DEPTH:Number = 2;
        public static const MAX_DEPTH:Number = 1300;
        public static const DARKNESS_DEPTH:Number = 1000;
        public static const WEST_BORDER:Number = 110;
        public static const EAST_BORDER:Number = 2400 - 110;

        private var _player:Player = new Player();
        private var _darkness:Darkness = new Darkness();
        private var _cameraTween:MultiVarTween = new MultiVarTween();

        private var _hud:Hud = new Hud();

        public function GameWorld() {
            var ogmoLevel:OgmoLoader = new OgmoLoader();
            add(ogmoLevel.terrain);
            for each(var entities:Entity in ogmoLevel.entities) {
                add(entities);
            }

            _player.x = 1200;
            _player.y = 0;
            add(_player);

            var shark:Shark = new Shark();
            shark.x = 1200;
            shark.y = 100;
            add(shark);

            add(_darkness);
            add(_hud);
            add(new Sky());
            add(new Waves());

            addTween(_cameraTween, true);
        }

        override public function begin():void {
            FP.camera.x = 1200 - FP.halfWidth;
            FP.camera.y = -FP.halfHeight;
        }

        public function get player():Player {
            return _player;
        }

        public function get hud():Hud {
            return _hud;
        }

        override public function update():void {
            super.update();

            _hud.health = _player.health;
            _hud.salvage = _player.salvage;

            _darkness.x = _player.x;
            _darkness.y = _player.y;
            _darkness.depth = _player.y / DARKNESS_DEPTH;
            _darkness.flipped = _player.flipped;
            _darkness.lamp = _player.lampOn;

            _cameraTween.tween(FP.camera, {x: _player.x - FP.halfWidth, y: _player.y - FP.halfHeight}, CAMERA_TWEEN_DELAY, Ease.quadInOut);

            if(_player.dead && Input.pressed(Key.ANY)) {
                FP.world = new GameWorld();
            }
        }
    }
}
