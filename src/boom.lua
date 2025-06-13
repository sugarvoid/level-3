
boom={}
boom.__index=boom

function add_boom_sfx(x,y)
    local _b=setmetatable({},boom)

    _b.y=y
    _b.x=x
    _b.alive=true
    _b.timer=15
    sfx(2)
    add(all_booms,_b)
end

function boom:draw()
    if self.alive then
        sspr(64,16,16,16,self.x,self.y)
        --spr(25,self.x,self.y)
        --spr(25,self.x+8,self.y,1,1,true)
        --spr(25,self.x,self.y+8,1,1,false,true)
        --spr(25,self.x+8,self.y+8,1,1,true,true)
    end
end

function boom:update()

    if self.alive then
        self.timer-=1
    end
    if self.timer==0 then
        del(all_booms,self)
    end
end
