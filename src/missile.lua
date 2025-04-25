
missile={}
missile.__index=missile

local pos={4,6,10,12,14,28,30,32,34,36,54,56,58,60,78,80,82,84,106,108,112,116}

function missile:new()
    local _m=setmetatable({},missile)
    _m.anmi_t=0
    _m.y=0
    _m.x=rnd(pos)
    --_m.x=10+rnd(120)
    _m.tip={x=0,y=0,w=2,h=1}
    _m.body={x=0,y=0,w=3,h=8}
    _m.launched=false
    return _m
end

function missile:draw()
    --todo: add flame animation
    spr(5+self.anmi_t%15\7.5,self.x,self.y)
    spr(7,self.x,self.y+8)
    --pset(self.tip.x,self.tip.y,8)
    --rect(self.body.x,self.body.y,self.body.x+self.body.w,self.body.y+self.body.h,8)
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
