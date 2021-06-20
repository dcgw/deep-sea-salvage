import domready = require("domready");
import {Color, DisplayMode, Engine, Loader} from "excalibur";
import resources from "./resources";
import TitleScene from "./scene/title-scene";

domready(() => {
    const engine = new Engine({
        resolution: { width: 210, height: 90 },
        viewport: { width: 840, height: 360 },
        displayMode: DisplayMode.Fixed,
        antialiasing: false,
        suppressHiDPIScaling: true,
        suppressPlayButton: true,
        backgroundColor: Color.fromHex("#6699E6")
    });

    // Work around Firefox not supporting image-rendering: pixelated
    // See https://github.com/excaliburjs/Excalibur/issues/1676
    if (engine.canvas.style.imageRendering === "") {
        engine.canvas.style.imageRendering = "crisp-edges";
    }

    engine.start(new Loader(Object.values(resources))).then(() => {
        engine.addScene("title", new TitleScene(engine));
        engine.goToScene("title");
    }, err => console.log("", err));
});
