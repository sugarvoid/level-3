
building={}
building.__index=building

function set_up_building(x)
    local _b=setmetatable({},building)
    _b.health=4
    _b.y=70
    _b.x=x
    _b.top=70
    _b.fallen=false
    _b.hitbox={
        x=_b.x-8,
        y=_b.y,
        w=15,
        h=2,
    }
    add(all_buildings,_b)
end

function building:draw()
    --todo: add smoke animation with low health
    --todo: lower building based on health
    --sspr(56,0,16,8,self.x-8,self.top)
    --line(self.x-8,self.y,self.x-8,self.y+40,4)
    --line(self.x+7,self.y,self.x+7,self.y+40,4)

    for i=0,self.health do
       spr(37,self.x,103-(8*i))
       spr(37,self.x-8,103-(8*i))
       --spr(37,self.x,self.y+(8*i))
       --spr(37,self.x-8,self.y+(8*i))
    end

    rect(self.x-8,self.y,self.x+7,self.y+2,5)
    print(self.health,self.x-2,self.y+4,0)
    spr(38, self.x-4, self.y + (8 * self.health) + 1)
end

function building:update()
    for m in all(all_missiles) do
        if is_colliding(self.hitbox, m.tip) then
            del(all_missiles, m)
            self:take_damage()
            
            sfx(3)
        end
    end
end

function building:take_damage()
    health=mid(0,health-5, 30)
    self.y += 8
    if health == 0 then
        goto_gameover()
    end
    self.health=mid(0,self.health-1,4)
    if self.health==0 then
        --self.health-=1
        --self.health=mid(self.health-2, 0)
        sfx(1)
    end
    -- lower height
    -- check if health
end

function building:check_if_hit(m)
    return is_point_in_box({x=m.x+4,y=m.y+15},self.hitbox)
end
