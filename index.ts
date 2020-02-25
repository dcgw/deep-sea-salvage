import {DisplayMode, Engine, Loader} from "excalibur";
import TitleScene from "./scene/title-scene";
import resources from "./resources";
import domready = require("domready");

domready(() => {
    const engine = new Engine({
        width: 210,
        height: 90,
        suppressPlayButton: true,
        suppressHiDPIScaling: true,
        displayMode: DisplayMode.Fixed
    });

    engine.canvas.style.width = "840px";
    engine.canvas.style.height = "360px";
    engine.canvas.style.imageRendering = "pixelated";

    engine.start(new Loader(Object.values(resources))).then(() => {
        engine.addScene("title", new TitleScene(engine));
        engine.goToScene("title");
    }, err => console.log("", err))
});
