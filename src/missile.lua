
missile={}
missile.__index=missile

local pos={4,6,10,12,14,28,30,32,34,36,54,56,58,60,78,80,82,84,106,108,112,116}

function missile:new()
    local m=setmetatable({},missile)
    m.anmi_t=0
    m.y=0
    m.x=rnd(pos)
    m.tip={x=0,y=0,w=2,h=1}
    m.body={x=0,y=0,w=3,h=8}
    m.launched=false
    return m
end

function missile:draw()

    spr(5+self.anmi_t%15\7.5,self.x,self.y)
    spr(7,self.x,self.y+8)

end

function missile:update()
    self.y+=0.4
    self.anmi_t+=1
    --self.y+=1
    self.body.x=self.x+2
    self.body.y=self.y+7
    self.tip.y=self.y+15
    self.tip.x=self.x+3
end

function spawn_missile()
    local _m=missile:new()
    add(all_missiles, _m)
end
