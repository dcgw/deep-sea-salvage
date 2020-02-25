package uk.co.zutty.ld29 {
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;

    public class TitleWorld extends World {

        [Embed(source="/logo.png")]
        private static const LOGO_IMAGE:Class;
        [Embed(source="/press_x.png")]
        private static const PRESS_X_IMAGE:Class;
        [Embed(source="/sky.png")]
        private static const SKY_IMAGE:Class;
        [Embed(source="/waves.png")]
        private static const WAVES_IMAGE:Class;

        public function TitleWorld() {
            addGraphic(new Image(SKY_IMAGE));
            var waves:Image = new Image(WAVES_IMAGE);
            waves.y = 45;
            addGraphic(waves);

            var logo:Image = new Image(LOGO_IMAGE);
            logo.centerOrigin();
            logo.x = FP.halfWidth;
            logo.y = FP.halfHeight - 4;
            addGraphic(logo);

            var continueText:Text = new Text("Press    to start");
            continueText.size = 8;
            continueText.centerOrigin();
            continueText.x = FP.halfWidth + 40;
            continueText.y = FP.halfHeight + 32;
            addGraphic(continueText);

            var pressXToContinueSpritemap:Spritemap = new Spritemap(PRESS_X_IMAGE, 8, 8);
            pressXToContinueSpritemap.add("press_x", [0,1], 0.03);
            pressXToContinueSpritemap.play("press_x");
            pressXToContinueSpritemap.x = FP.halfWidth - 7;
            pressXToContinueSpritemap.y = FP.halfHeight + 24;
            addGraphic(pressXToContinueSpritemap);

        }

        override public function update():void {
            super.update();

            if(Input.check(Key.ANY)) {
                FP.world = new GameWorld();
            }
        }
    }
}
