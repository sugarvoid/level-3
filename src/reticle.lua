reticle = {
    x = 20,
    y = 20,
    update = function(self)
        if btn(⬆️) then self.y = mid(0, self.y - 2, 90) end
        if btn(⬇️) then self.y = mid(0, self.y + 2, 90) end
        if btn(⬅️) then
            self.x = mid(0, self.x - 2, 110)
            sfx(4)
        end
        if btn(➡️) then
            self.x = mid(0, self.x + 2, 110)
            sfx(4)
        end
    end,
}

function draw_reticle()
    spr(1, reticle.x, reticle.y)
    spr(1, reticle.x + 8, reticle.y, 1, 1, true)
    spr(1, reticle.x, reticle.y + 8, 1, 1, false, true)
    spr(1, reticle.x + 8, reticle.y + 8, 1, 1, true, true)
end
