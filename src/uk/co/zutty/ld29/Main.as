package uk.co.zutty.ld29 {
    import net.flashpunk.Engine;
    import net.flashpunk.FP;

    [SWF(width="840", height="360", frameRate="60", backgroundColor="000000")]
    public class Main extends Engine {
        public function Main() {
            super(210, 90, 60, true);

            FP.screen.scale = 4;
            FP.screen.color = 0x6699E6;

            //FP.console.enable();
            //FP.console.debug = true;

            FP.world = new TitleWorld();
        }
    }
}
