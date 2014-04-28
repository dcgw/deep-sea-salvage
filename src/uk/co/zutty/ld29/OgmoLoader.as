package uk.co.zutty.ld29 {
    import flash.utils.ByteArray;

    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Tilemap;
    import net.flashpunk.masks.Grid;

    public class OgmoLoader {

        [Embed(source="/level.oel", mimeType="application/octet-stream")]
        private static const OGMO_LEVEL_FILE:Class;
        [Embed(source="/tiles.png")]
        private static const TILES_IMAGE:Class;

        private static const TILE_SIZE:int = 24;

        private var _xmlData:XML;

        public function OgmoLoader() {
            var bytes:ByteArray = new OGMO_LEVEL_FILE();
            _xmlData = new XML(bytes.readUTFBytes(bytes.length));
        }

        public function get terrain():Entity {
            var terrain:Entity = new Entity();

            var tilemap:Tilemap = new Tilemap(TILES_IMAGE, _xmlData.width, _xmlData.height, TILE_SIZE, TILE_SIZE);
            var grid:Grid = new Grid(_xmlData.width, _xmlData.height, TILE_SIZE, TILE_SIZE);

            for each(var tile:XML in _xmlData["terrain"][0].tile) {
                var idx:uint = tilemap.getIndex(tile.@tx / TILE_SIZE, tile.@ty / TILE_SIZE);
                tilemap.setTile(tile.@x / TILE_SIZE, tile.@y / TILE_SIZE, idx);
                grid.setTile(tile.@x / TILE_SIZE, tile.@y / TILE_SIZE);
            }

            terrain.addGraphic(tilemap);
            terrain.mask = grid;
            terrain.type = "terrain";
            terrain.layer = 600;

            return terrain;
        }

        public function get background():Entity {
            var background:Entity = getLayer("background");
            background.layer = 700;
            return background;
        }

        public function get foreground():Entity {
            var foreground:Entity = getLayer("foreground");
            foreground.layer = 160;
            return foreground;
        }

        public function getLayer(name:String):Entity {
            var layer:Entity = new Entity();

            var tilemap:Tilemap = new Tilemap(TILES_IMAGE, _xmlData.width, _xmlData.height, TILE_SIZE, TILE_SIZE);

            for each(var tile:XML in _xmlData[name][0].tile) {
                var idx:uint = tilemap.getIndex(tile.@tx / TILE_SIZE, tile.@ty / TILE_SIZE);
                tilemap.setTile(tile.@x / TILE_SIZE, tile.@y / TILE_SIZE, idx);
            }

            layer.addGraphic(tilemap);

            return layer;
        }

        public function get entities():Vector.<Entity> {
            var entities:Vector.<Entity> = new Vector.<Entity>();

            for each(var obj:XML in _xmlData["objects"][0].enemy) {
                var enemy:Enemy = FP.world.create(Enemy, false) as Enemy;
                enemy.spawn(obj.@x, obj.@y);
                entities.push(enemy);
            }

            for each(var obj:XML in _xmlData["objects"][0].whale) {
                var whale:Whale = FP.world.create(Whale, false) as Whale;
                whale.x = obj.@x;
                whale.y = obj.@y;
                entities.push(whale);
            }

            for each(var obj:XML in _xmlData["objects"][0].shark) {
                var shark:Shark = FP.world.create(Shark, false) as Shark;
                shark.spawn(obj.@x, obj.@y);
                entities.push(shark);
            }

            for each(var obj:XML in _xmlData["objects"][0].boat_wreck) {
                var boatWreck:Entity = FP.world.create(BoatWreck, false);
                boatWreck.x = obj.@x;
                boatWreck.y = obj.@y;
                entities.push(boatWreck);
            }

            for each(var obj:XML in _xmlData["objects"][0].shipwreck) {
                var shipwreck:Entity = FP.world.create(Shipwreck, false);
                shipwreck.x = obj.@x;
                shipwreck.y = obj.@y;
                entities.push(shipwreck);
            }

            for each(var obj:XML in _xmlData["objects"][0].capital_sub) {
                var capitalSub:Entity = FP.world.create(EnemyCapitalSubmarine, false);
                capitalSub.x = obj.@x;
                capitalSub.y = obj.@y;
                entities.push(capitalSub);
            }

            for each(var obj:XML in _xmlData["objects"][0].treasure) {
                var treasure:Treasure = FP.world.create(Treasure, false) as Treasure;
                treasure.x = obj.@x;
                treasure.y = obj.@y - 5;
                treasure.value = obj.@value;
                entities.push(treasure);
            }

            for each(var obj:XML in _xmlData["objects"][0].crate) {
                var crate:Crate = FP.world.create(Crate, false) as Crate;
                crate.x = obj.@x;
                crate.y = obj.@y - 5;
                crate.value = obj.@value;
                entities.push(crate);
            }

            return entities;
        }
    }
}
