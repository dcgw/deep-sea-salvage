package uk.co.zutty.ld29 {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Spritemap;

    public class EnemyCapitalSubmarine extends Entity implements Salvage {

        [Embed(source="/baddie_capital_sub.png")]
        private static const CAPITAL_SUB_IMAGE:Class;

        private static const SALVAGE_VALUE:int = 5000;

        private var _claimed:Boolean = false;

        public function EnemyCapitalSubmarine() {
            var spritemap:Spritemap = new Spritemap(CAPITAL_SUB_IMAGE, 128, 48);
            spritemap.add("spin", [0,1,2,1], 0.1);
            spritemap.play("spin");
            addGraphic(spritemap);

            layer = 400;

            setHitbox(120, 20, 0, -20);
            type = "salvage";
        }

        public function get claimed():Boolean {
            return _claimed;
        }

        public function claim():int {
            _claimed = true;
            SalvageFloater.show(x + 60, y + 20, SALVAGE_VALUE);
            return SALVAGE_VALUE;
        }

        public function get interactText():String {
            return "Steal";
        }
    }
}
