import {Actor, Engine, Scene, Vector} from "excalibur";
import resources from "../resources";

export default class TitleScene extends Scene {

    public onInitialize(engine: Engine): void {
        const title = new Actor({
            pos: new Vector(engine.canvasWidth / 2, engine.canvasHeight / 2)
        });
        title.addDrawing(resources.title);
        this.addUIActor(title);
    }
}
