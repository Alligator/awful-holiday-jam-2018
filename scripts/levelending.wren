import "engine" for Asset, Draw, Trap
import "timer" for Timer
import "levels" for Levels

class LevelEnding {
   nextScene { _nextScene }
   nextScene=(params) { _nextScene = params }

   construct new(nextLevel) {
      _bigFont = Asset.create(Asset.BitmapFont, "sneakattack", "gfx/sneak-attack-bitmap.png")
      Asset.bmpfntSet(_bigFont, "abcdefghijklmnopqrstuvwxyz'!?", 0, 1, 2, 5)

      _level = Levels.Levels[nextLevel - 1]
      _spr = Asset.create(Asset.Sprite, "levelending", "gfx/" + _level["sprite"] + ".png")
      Asset.spriteSet(_spr, 16, 48, 0, 0)

      Asset.loadAll()

      Timer.runLater(300) {
         _nextScene = ["game", nextLevel]
      }
   }

   update(dt) {
   }

   drawCenteredText(font, x, y, text) {
      var w = Asset.measureBmpText(font, text)
      Draw.bmpText(font, x - w/2, y, text)
   }

   draw(w, h) {
      Draw.clear()
      Draw.resetTransform()
      Draw.scale(h / 180)

      var y = 32
      Draw.sprite(_spr, 0, 320/2 - 8, y)

      y = y + 72
      drawCenteredText(_bigFont, 320/2, y, "you survived the conversation")
      drawCenteredText(_bigFont, 320/2, y + 12, "with " + _level["spriteName"] + "!")

      drawCenteredText(_bigFont, 320/2, y + 36, "well done!")
   }

   shutdown() {
      Asset.clearAll()
   }
}