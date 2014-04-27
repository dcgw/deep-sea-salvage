package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Graphiclist;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.graphics.Text;

    public class Hud extends Entity {

        [Embed(source="/health_indicator.png")]
        private static const HEALTH_INDICATOR_IMAGE:Class;
        [Embed(source="/press_x.png")]
        private static const PRESS_X_IMAGE:Class;
        [Embed(source="/press_c.png")]
        private static const PRESS_C_IMAGE:Class;
        [Embed(source="/coin_icon.png")]
        private static const COIN_IMAGE:Class;

        private var _healthSpritemap1:Spritemap = new Spritemap(HEALTH_INDICATOR_IMAGE, 8, 8);
        private var _healthSpritemap2:Spritemap = new Spritemap(HEALTH_INDICATOR_IMAGE, 8, 8);
        private var _healthSpritemap3:Spritemap = new Spritemap(HEALTH_INDICATOR_IMAGE, 8, 8);

        private var _gameOverList:Graphiclist = new Graphiclist();

        private var _interactText:Text = new Text("interact");
        private var _interactList:Graphiclist = new Graphiclist();

        private var _salvageText:Text = new Text("0000000");

        public function Hud() {
            _healthSpritemap1.add("full", [0], 1, false);
            _healthSpritemap1.add("empty", [1], 1, false);
            _healthSpritemap1.add("alert", [1,2], 0.03);
            _healthSpritemap1.play("full");
            _healthSpritemap1.x = 179;
            _healthSpritemap1.y = 3;
            addGraphic(_healthSpritemap1);

            _healthSpritemap2.add("full", [0], 1, false);
            _healthSpritemap2.add("empty", [1], 1, false);
            _healthSpritemap2.add("alert", [1,2], 0.03);
            _healthSpritemap2.play("full");
            _healthSpritemap2.x = 189;
            _healthSpritemap2.y = 3;
            addGraphic(_healthSpritemap2);

            _healthSpritemap3.add("full", [0], 1, false);
            _healthSpritemap3.add("empty", [1], 1, false);
            _healthSpritemap3.add("alert", [1,2], 0.03);
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

            _interactText.size = 8;
            _interactText.x = 10;
            _interactList.add(_interactText);
            var interactButtonSpritemap:Spritemap = new Spritemap(PRESS_C_IMAGE, 8, 8);
            interactButtonSpritemap.add("press_c", [0,1], 0.03);
            interactButtonSpritemap.play("press_c");
            interactButtonSpritemap.y = 1;
            _interactList.add(interactButtonSpritemap);
            _interactList.x = FP.halfWidth - 25;
            _interactList.y = FP.halfHeight + 25;
            _interactList.visible = false;
            addGraphic(_interactList);

            var coinIcon:Image = new Image(COIN_IMAGE);
            coinIcon.x = 3;
            coinIcon.y = 3;
            addGraphic(coinIcon);

            _salvageText.size = 8;
            _salvageText.x = 12;
            _salvageText.y = 2;
            addGraphic(_salvageText);

            _gameOverList.visible = false;
            addGraphic(_gameOverList);

            graphic.scrollX = 0;
            graphic.scrollY = 0;

            layer = 10;
        }

        public function set health(value:int):void {
            if(value == 1) {
                _healthSpritemap1.play("alert");
                _healthSpritemap2.play("alert");
                _healthSpritemap3.play("alert");
            } else {
                _healthSpritemap1.play(value >= 2 ? "full" : "empty");
                _healthSpritemap2.play(value >= 3 ? "full" : "empty");
                _healthSpritemap3.play(value >= 4 ? "full" : "empty");
            }

            if(value <= 0) {
                _gameOverList.visible = true;
            }
        }

        public function set salvage(value:int):void {
            var strVal:String = "" + value;
            _salvageText.text = "0000000".substring(0, 7 - strVal.length) + strVal;
        }

        public function set interactText(value:String):void {
            _interactText.text = value;
        }

        public function set showInteract(value:Boolean):void {
            _interactList.visible = value;
        }
    }
}
