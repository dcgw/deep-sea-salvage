import {Actor, Engine, SpriteSheet} from "excalibur";
import resources from "../resources";

const playerSubSpriteSheet = new SpriteSheet({
    image: resources.playerSub,
    spWidth: 16,
    spHeight: 16,
    rows: 1,
    columns: 4
});

export default class Player extends Actor {
    public onInitialize(engine: Engine): void {
        this.addDrawing("idle", playerSubSpriteSheet.getSprite(0));
        this.addDrawing("spin", playerSubSpriteSheet.getAnimationByIndices(engine, [0, 1, 2, 1], 1666));
        this.addDrawing("dead", playerSubSpriteSheet.getSprite(3));
    }
}
