
bullet={}
bullet.__index=bullet

local start_y=100

function shoot_bullet()
    local _b=setmetatable({},bullet)
    _b.active=false
    _b.img=22
    _b.end_y=recticle.y+8
    _b.halfway=start_y+(_b.end_y-start_y)*0.5
    _b.three_quat=ceil(start_y+(_b.end_y-start_y)*0.75)
    _b.y=start_y
    _b.life=10
    _b.ignited=false
    _b.x=recticle.x
    _b.starting_size=5
    _b.hitbox={x=0,y=0,h=18,w=18}
    _b.size=8
    _b.ticker=0
    _b.peek_y=0
    add(all_bullets,_b)
end

function bullet:draw()
    if not self.ignited then
        --rect(self.x-4,self.y-4,self.x+4,self.y+4,9)
        spr(self.img,self.x-4,self.y-4)
    end
    --rect(self.hitbox.x,self.hitbox.y,self.hitbox.x+self.hitbox.w,self.hitbox.y+self.hitbox.h,5)

end

function bullet:update()
    if not self.ignited then
        self.y-=2
    end

    self.ticker+=1
    self.hitbox.x=self.x-9
    self.hitbox.y=self.y-9
    if self.ticker==20 then
        self.ticker=0
    end

    if self.y<=self.halfway and self.y>=self.three_quat then
        -- Change sprite at halfway point
        self.img=23
    elseif self.y<=self.three_quat then
        -- Change sprite at 3/4ths point
        self.img=24
    else
        -- Default sprite
        self.img=22
    end

    for m in all(all_missiles) do
        if is_colliding(self.hitbox,m.body) and self.ignited then
            del(all_missiles,m)
        end
    end

    if self.y<=self.end_y then
        self.ignited=true
        add_boom_sfx(self.x-8,self.y-8)
    end

    if self.ignited then
        self.life-=1
        if self.life==0 then
            del(all_bullets,self)
        end
    end
end
