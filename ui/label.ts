import {BaseAlign, Color, FontUnit, Label} from "excalibur";

export const label = (text: string, x: number, y: number) => {
    return new Label({
        text, x, y,
        color: Color.White,
        fontFamily: "'04B_03'",
        fontSize: 8,
        fontUnit: FontUnit.Px,
        baseAlign: BaseAlign.Bottom,
    });
};
