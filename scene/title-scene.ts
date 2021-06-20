import {Engine, Scene, ScreenElement, Vector} from "excalibur";
import resources from "../resources";
import {label} from "../ui/label";
import {pressButton} from "../ui/press-button";

export default class TitleScene extends Scene {

    public onInitialize(engine: Engine): void {
        const sky = new ScreenElement({
            pos: Vector.Zero
        });
        sky.addDrawing(resources.sky);
        this.add(sky);

        const waves = new ScreenElement({ x: 0, y: 45 });
        sky.addDrawing(resources.waves);
        this.add(waves);

        const cx = engine.halfCanvasWidth;
        const cy = engine.halfCanvasHeight;
        const title = new ScreenElement({
            x: cx - 77,
            y: cy - 27,
        });
        title.addDrawing(resources.title);
        this.add(title);

        this.add(label("Press", cx - 35, cy + 32));
        this.add(label("to start", cx + 5, cy + 32));
        this.add(pressButton("x", cx - 7, cy + 24));

        this.on("activate", () => {
            engine.input.keyboard.once("press", () => engine.goToScene("game"));
        });
    }
}
