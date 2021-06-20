import {Engine, Scene} from "excalibur";
import Player from "../actor/player";

export default class GameScene extends Scene {
    public onInitialize(engine: Engine): void {
        this.add(new Player({
            x: 100,
            y: 45
        }));
    }
}
