package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.graphics.Text;

    public class Hud extends Entity {

        [Embed(source="/health_indicator.png")]
        private static const HEALTH_INDICATOR_IMAGE:Class;

        private var _healthSpritemap1:Spritemap = new Spritemap(HEALTH_INDICATOR_IMAGE, 8, 8);
        private var _healthSpritemap2:Spritemap = new Spritemap(HEALTH_INDICATOR_IMAGE, 8, 8);
        private var _healthSpritemap3:Spritemap = new Spritemap(HEALTH_INDICATOR_IMAGE, 8, 8);

        private var _gameOverText:Text = new Text("Game Over");

        public function Hud() {
            _healthSpritemap1.add("empty", [0], 1, false);
            _healthSpritemap1.add("full", [1], 1, false);
            _healthSpritemap1.play("full");
            _healthSpritemap1.x = 179;
            _healthSpritemap1.y = 3;
            _healthSpritemap1.scrollX = 0;
            _healthSpritemap1.scrollY = 0;
            addGraphic(_healthSpritemap1);

            _healthSpritemap2.add("empty", [0], 1, false);
            _healthSpritemap2.add("full", [1], 1, false);
            _healthSpritemap2.play("full");
            _healthSpritemap2.x = 189;
            _healthSpritemap2.y = 3;
            _healthSpritemap2.scrollX = 0;
            _healthSpritemap2.scrollY = 0;
            addGraphic(_healthSpritemap2);

            _healthSpritemap3.add("empty", [0], 1, false);
            _healthSpritemap3.add("full", [1], 1, false);
            _healthSpritemap3.play("full");
            _healthSpritemap3.x = 199;
            _healthSpritemap3.y = 3;
            _healthSpritemap3.scrollX = 0;
            _healthSpritemap3.scrollY = 0;
            addGraphic(_healthSpritemap3);

            _gameOverText.size = 24;
            _gameOverText.x = FP.halfWidth - (_gameOverText.width / 2);
            _gameOverText.y = FP.halfHeight - (_gameOverText.height / 2);
            _gameOverText.scrollX = 0;
            _gameOverText.scrollY = 0;
            _gameOverText.visible = false;
            addGraphic(_gameOverText);

            layer = 10;
        }

        public function set health(value:int):void {
            _healthSpritemap1.play(value >= 1 ? "full" : "empty");
            _healthSpritemap2.play(value >= 2 ? "full" : "empty");
            _healthSpritemap3.play(value >= 3 ? "full" : "empty");

            if(value <= 0) {
                _gameOverText.visible = true;
            }
        }
    }
}
