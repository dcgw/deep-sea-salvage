import {Texture} from "excalibur";
import playerSub from "./actor/player_sub.png";
import sky from "./scene/sky.png";
import title from "./scene/title.png";
import waves from "./scene/waves.png";
import pressC from "./ui/press-c.png";
import pressX from "./ui/press-x.png";

export default {
    playerSub: new Texture(playerSub),
    pressC: new Texture(pressC),
    pressX: new Texture(pressX),
    title: new Texture(title),
    sky: new Texture(sky),
    waves: new Texture(waves)
};
