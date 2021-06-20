import {ScreenElement, SpriteSheet} from "excalibur";
import resources from "../resources";

export const pressButton = (button: "c" | "x", x: number, y: number) => {
    const element = new ScreenElement({ x, y });
    element.onInitialize = engine => element.addDrawing("press", new SpriteSheet({
        image: button === "c" ? resources.pressC : resources.pressX,
        spWidth: 8,
        spHeight: 8,
        rows: 1,
        columns: 2
    }).getAnimationForAll(engine, 555));
    return element;
};
