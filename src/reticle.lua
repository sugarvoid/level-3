recticle={
    x=20,
    y=20,
    update=function(self)
        if btn(⬆️) then self.y-=2 end
        if btn(⬇️) then self.y+=2 end
        if btn(⬅️) then self.x-=2 sfx(4) end
        if btn(➡️) then self.x+=2 sfx(4) end
    end,
}

function draw_recticle()
    spr(1,recticle.x,recticle.y)
    spr(1,recticle.x+8,recticle.y,1,1,true)
    spr(1,recticle.x,recticle.y+8,1,1,false,true)
    spr(1,recticle.x+8,recticle.y+8,1,1,true,true)
end
