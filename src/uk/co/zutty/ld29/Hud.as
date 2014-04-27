package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Graphiclist;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.graphics.Text;

    public class Hud extends Entity {

        [Embed(source="/health_indicator.png")]
        private static const HEALTH_INDICATOR_IMAGE:Class;
        [Embed(source="/press_x.png")]
        private static const PRESS_X_IMAGE:Class;

        private var _healthSpritemap1:Spritemap = new Spritemap(HEALTH_INDICATOR_IMAGE, 8, 8);
        private var _healthSpritemap2:Spritemap = new Spritemap(HEALTH_INDICATOR_IMAGE, 8, 8);
        private var _healthSpritemap3:Spritemap = new Spritemap(HEALTH_INDICATOR_IMAGE, 8, 8);

        private var _gameOverList:Graphiclist = new Graphiclist();

        public function Hud() {
            _healthSpritemap1.add("empty", [0], 1, false);
            _healthSpritemap1.add("full", [1], 1, false);
            _healthSpritemap1.play("full");
            _healthSpritemap1.x = 179;
            _healthSpritemap1.y = 3;
            addGraphic(_healthSpritemap1);

            _healthSpritemap2.add("empty", [0], 1, false);
            _healthSpritemap2.add("full", [1], 1, false);
            _healthSpritemap2.play("full");
            _healthSpritemap2.x = 189;
            _healthSpritemap2.y = 3;
            addGraphic(_healthSpritemap2);

            _healthSpritemap3.add("empty", [0], 1, false);
            _healthSpritemap3.add("full", [1], 1, false);
            _healthSpritemap3.play("full");
            _healthSpritemap3.x = 199;
            _healthSpritemap3.y = 3;
            addGraphic(_healthSpritemap3);

            var gameOverText:Text = new Text("Game Over");
            gameOverText.size = 24;
            gameOverText.centerOrigin();
            gameOverText.x = FP.halfWidth;
            gameOverText.y = FP.halfHeight;
            _gameOverList.add(gameOverText);

            var continueText:Text = new Text("Press    to continue");
            continueText.size = 8;
            continueText.centerOrigin();
            continueText.x = FP.halfWidth + 40;
            continueText.y = FP.halfHeight + 18;
            _gameOverList.add(continueText);

            var pressXToContinueSpritemap:Spritemap = new Spritemap(PRESS_X_IMAGE, 8, 8);
            pressXToContinueSpritemap.add("press_x", [0,1], 0.03);
            pressXToContinueSpritemap.play("press_x");
            pressXToContinueSpritemap.x = FP.halfWidth - 20;
            pressXToContinueSpritemap.y = FP.halfHeight + 10;
            _gameOverList.add(pressXToContinueSpritemap);

            _gameOverList.visible = false;
            addGraphic(_gameOverList);

            graphic.scrollX = 0;
            graphic.scrollY = 0;

            layer = 10;
        }

        public function set health(value:int):void {
            _healthSpritemap1.play(value >= 1 ? "full" : "empty");
            _healthSpritemap2.play(value >= 2 ? "full" : "empty");
            _healthSpritemap3.play(value >= 3 ? "full" : "empty");

            if(value <= 0) {
                _gameOverList.visible = true;
            }
        }
    }
}
