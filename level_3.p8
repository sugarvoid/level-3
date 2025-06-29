pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--level 3
--by sugarvoid

function _init()
    g_state = 1
    gameover_str = ""
    start_delay = 60
    palt(0, false)
    palt(14, true)
    poke(0x5f5c, 255)
    all_missiles = {}
    all_buildings = {}
    all_bullets = {}
    all_booms = {}

    sec_left = 40
    game_ticker = 0

    health = 30
    energy = 30
    energy_max = 30
    bullet_cost = 5
    en_recharge_ticks = 0
    next_en_rechage = 60

    spawn_missile_ticks = 0
    next_missile = 60
    frames = 0

    set_up_building(14)
    set_up_building(39)
    set_up_building(65)
    set_up_building(90)
    set_up_building(115)
end

function _update()
    if g_state == 1 then
        update_title()
    elseif g_state == 2 then
        update_game()
    else
        update_gameover()
    end
end

function update_game()
    frames += 1
    game_ticker += 1
    spawn_missile_ticks += 1
    en_recharge_ticks += 1
    if game_ticker >= 30 then
        game_ticker = 0
        sec_left -= 1
        if sec_left == 0 then
            goto_gameover(1)
        end
    end
    if spawn_missile_ticks == next_missile then
        spawn_missile()
        spawn_missile_ticks = 0
    end
    if en_recharge_ticks == next_en_rechage then
        recharge_en()
        en_recharge_ticks = 0
    end

    if btnp(4) then
        if energy >= bullet_cost then
            sfx(0)
            energy -= bullet_cost
            shoot_bullet()
        end
    end

    reticle:update()


    foreach(all_bullets, function(obj) obj:update() end)
    foreach(all_buildings, function(obj) obj:update() end)
    foreach(all_missiles, function(obj) obj:update() end)
    foreach(all_booms, function(obj) obj:update() end)
end

function update_title()
    if btnp(5) then g_state = 2 end
end

function update_gameover()
    if btnp(4) or btnp(5) then
        _init()
    end
end

function _draw()
    if g_state == 1 then
        draw_title()
    elseif g_state == 2 then
        draw_game()
    else
        draw_gameover()
    end
end

function draw_game()
    cls(12)
    map()

    if start_delay > 0 then

    end

    foreach(all_buildings, function(obj) obj:draw() end)
    foreach(all_missiles, function(obj) obj:draw() end)
    foreach(all_booms, function(obj) obj:draw() end)
    foreach(all_bullets, function(obj) obj:draw() end)

    line(0, 111, 128, 111, 0)

    draw_reticle()

    spr(21, reticle.x + 3, 104)
    spr(16, reticle.x + 3, 96)
    sspr(24, 0, 16, 16, reticle.x + 8, 100)

    print("hp", 2, 120, 7)
    rectfill(10, 120, 10 + health, 124, 11)
    rect(10, 120, 10 + 30, 124, 7)

    print("en", 64, 120, 7)
    rectfill(64 + 8, 120, 64 + 8 + energy, 124, 12)
    rect(64 + 8, 120, 64 + 8 + energy_max, 124, 7)

    print(sec_left, 115, 120, 0)
end

function draw_title()
    cls()
    print("press [x] to play", 30, 60, 7)
end

function draw_gameover()
    cls()
    print(gameover_str, 0, 50, 4)
end

function check_gameover()
    --
    --[[
loop through buildings and
 see any health == 0
 if so, go to game over
 ]]
end

function is_colliding(a, b)
    if ((b.x >= a.x + a.w) or
            (b.x + b.w <= a.x) or
            (b.y >= a.y + a.h) or
            (b.y + b.h <= a.y)) then
        return false
    else
        return true
    end
end

function is_point_in_box(p, box)
    if ((box.x >= p.x) or
            (box.x <= p.x) or
            (box.y >= p.y) or
            (box.y <= p.y)) then
        return false
    else
        return true
    end
end

function recharge_en()
    energy = mid(0, energy + bullet_cost, energy_max)
end

function goto_gameover(con)
    if con then
        gameover_str = "you saved the city\ncool"
    else
        sfx(1)
        gameover_str = "the city has fallen"
    end

    g_state = 3
end



-->8
--missile
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
    self.body.x=self.x+2
    self.body.y=self.y+7
    self.tip.y=self.y+15
    self.tip.x=self.x+3
end

function spawn_missile()
    local _m=missile:new()
    add(all_missiles, _m)
end

-->8
--bullet
bullet = {}
bullet.__index = bullet

local start_y = 100

function shoot_bullet()
    local _b = setmetatable({}, bullet)
    _b.active = false
    _b.img = 22
    _b.end_y = reticle.y + 8
    _b.halfway = start_y + (_b.end_y - start_y) * 0.5
    _b.three_quat = ceil(start_y + (_b.end_y - start_y) * 0.75)
    _b.y = start_y
    _b.life = 10
    _b.ignited = false
    _b.x = reticle.x + 8
    _b.starting_size = 5
    _b.hitbox = { x = 0, y = 0, h = 18, w = 18 }
    _b.size = 8
    _b.ticker = 0
    _b.peek_y = 0
    add(all_bullets, _b)
end

function bullet:draw()
    if not self.ignited then
        spr(self.img, self.x - 4, self.y - 4)
    end
end

function bullet:update()
    if not self.ignited then
        self.y -= 2
    end

    self.ticker += 1
    self.hitbox.x = self.x - 9
    self.hitbox.y = self.y - 9
    if self.ticker == 20 then
        self.ticker = 0
    end

    if self.y <= self.halfway and self.y >= self.three_quat then
        -- Change sprite at halfway point
        self.img = 23
    elseif self.y <= self.three_quat then
        -- Change sprite at 3/4ths point
        self.img = 24
    else
        -- Default sprite
        self.img = 22
    end

    for m in all(all_missiles) do
        if is_colliding(self.hitbox, m.body) and self.ignited then
            del(all_missiles, m)
        end
    end

    if self.y <= self.end_y then
        self.ignited = true
        add_boom_sfx(self.x - 8, self.y - 8)
    end

    if self.ignited then
        self.life -= 1
        if self.life == 0 then
            del(all_bullets, self)
        end
    end
end


-->8
--reticle
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

-->8
--boom sfx

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

-->8
--building

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
    for i=0,self.health do
       spr(37,self.x,103-(8*i))
       spr(37,self.x-8,103-(8*i))
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
        sfx(1)
    end
end

function building:check_if_hit(m)
    return is_point_in_box({x=m.x+4,y=m.y+15},self.hitbox)
end

__gfx__
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee5555eeeeeeeeee8eee8eeeeeeeeee80000000000080000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee99eeeeee88eeeee5555eeeeeeeeee88e8e8e88eee88880000000000000000080800000080000000000000
ee7ee7eeeeee7777eeeeeeeeeeeeeeeeeeeeeeeeee9aa9eeee8998eeee5555eeeeeeeeee8e8eee8ee888eee80000000000000000000000800000800000000000
eee77eeeeeeeeeeeeeee7777eeeeeeeeeeeeeeeee9a77a9ee89aa98eee5555eeeeeeeeee8eeeeeeeeeeeeee80808008008000080000000000000080000000000
eee77eeeee7eeeeeeee7eeeeeeee886ee688eeee9a7777a989aaaa98ee5555eeeeeeeeee8eeeeeeeeeeeeee80000000000000000008000800000000000000000
ee7ee7eeee7eeee7eee7eeeeeee7556556557eee9a7777a989aaaa98ee5555eeeeeeeeee8eeeeeeeeeeeeee80080080000008000000000000080000000000000
eeeeeeeeee7eeeeeeee7eee7eee0336776330eeee9a77a9ee89aa98eeee55eeeeeeeeeee8eeeeeeeeeeeeee80000800800800080080000000800000000000000
eeeeeeeeee7ee7eeeee7ee7eeee0336776330eeeee5555eeee5555eeeee55eeeeeeeeeee8eeeeeeeeeeeeee80800000080000000000080000000800000000000
eeeeeeeeeeeeeeeeeeeeeeeeeee0333773330eeeeeeee55eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeee0333773330eeeeeeee55eeeeeeeeeeeeeeeeeeeeeeeeeeeaaaeaeeeeeeeeeeeeeeeee00000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeee0333773330eeeeeeee88eeeeea99aeeeea9eeeeeeeeeeea9e88e8eeeeeeeeeeeeeeee00000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeee0833333380eeeeeeee57eeeea99aeeeea99eeeeea99eeeae99989eeeeeeeeeeeeeeee00000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeee3835555383eeeeeee5575eea989eeeea98aeeeee98aeeea89e8aaeeeeeeeeeeeeeeee00000000000000000000000000000000
eeeeeeeeeeee9ee9eeeeeeeeee037777777730eeeeee5550ee999aeeee99aeeeeee9aeeeee898aa8eeeeeeeeeeeeeeee00000000000000000000000000000000
eeeee99eeeeeeaaeeeeeeeeeee033333333330eeeeee5055ee9aeeeeeeeeeeeeeeeeeeeeeae8aa9eeeeeeeeeeeeeeeee00000000000000000000000000000000
eeeeeaaeeeeeeeeeeeeeeeeeee00e00ee00e00eeeee00000eeaeeeeeeeeeeeeeeeeeeeeeee89a8e9eeeeeeeeeeeeeeee00000000000000000000000000000000
e3e3e3e355555555e3e3e3e3e3e3e3e344444444ffffffffeeeeeeeeeeffefefeee8eeee8eeee8ee000000000000000000000000000000000000000000000000
3e3e3e3e555555553e3e3e3e3e3e3e3e44444444ffffffffeeeeeeeeffffffff8eee8eee8e9e88ee000000000000000000000000000000000000000000000000
e3e3e3e355555555e3e00003e300e3e344444444f77ff77feeeeeeeef77ff77f88eee8ee899e8eee000000000000000000000000000000000000000000000000
3e3e3e3e555555553e04440e3e04003e44444444f77ff77feeeeeeeef77ff77fe88e98e899e88eee000000000000000000000000000000000000000000000000
e3e3e3e355555555e30444400044440044444444ffffffffffffffffffffffffe988998899988eee000000000000000000000000000000000000000000000000
3e3e3e3e55555555304444444444444444444444f77ff77ffff55ffff77ff77fe999999999998eee000000000000000000000000000000000000000000000000
e3e3e3e355555555044444444444444444444444f77ff77ffff55ffff77ff77feee9999999998eee000000000000000000000000000000000000000000000000
3e3e3e3e55555555444444444444444444444444fffffffffff55fffffffffffee9999999998888e000000000000000000000000000000000000000000000000
7e7e7e7e000000000000000000000000000000000000000000000000000000009999999999998ee8000000000000000000000000000000000000000000000000
e7e7e7e7000000000000000000000000000000000000000000000000000000009889999999988eee000000000000000000000000000000000000000000000000
7e7e7e7e00000000000000000000000000000000000000000000000000000000ee899999998888ee000000000000000000000000000000000000000000000000
e7e7e7e700000000000000000000000000000000000000000000000000000000e88e99999988ee88000000000000000000000000000000000000000000000000
7e7e7e7e00000000000000000000000000000000000000000000000000000000e8ee998e8ee8eee8000000000000000000000000000000000000000000000000
e7e7e7e700000000000000000000000000000000000000000000000000000000eeee98eee8ee8eee000000000000000000000000000000000000000000000000
7e7e7e7e00000000000000000000000000000000000000000000000000000000eee98eeee88e8eee000000000000000000000000000000000000000000000000
e7e7e7e700000000000000000000000000000000000000000000000000000000eeeeeeeeee8ee8ee000000000000000000000000000000000000000000000000
__label__
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc9cccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc9ccc9cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc9cc9cc9cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc9cc9c99cccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0cccccccccccccccccccc99c9c9ccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc000ccccccccccccccccccccc9c9ccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000ccccccccccccccccccccc9c9cc9cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000ccccccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0cccc0000ccccccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc00cccc0000ccccccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000cccc0000ccccccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccc000000cccc0000ccccccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccc0000000ccccc0000ccccccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc00000000cccccc0000ccccc0ccccccccccccccc555555cccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc0000000cccccccc0000ccc000ccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccc0cc00000cccccccccc0000c00000ccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccc000cc0000ccccccccccc0000000000ccccccccccccccc555555cccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccc0000cc0000c0ccccccccc000000000cccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccc0cc0000cc000000ccccccccc0000000cccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccc000cc0000cc000000ccccccccc00000cccccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccc0000cc0000cc000000cccc0cccc000cccccccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccc0000cc0000cc00000cccc00cccc0cccccccccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc0cccc0000cc0000cc0000ccc0000ccccccccccccccccccccccccccccccc55cccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccc000cccc0000cc0000cc0000c000000ccccccccccccccccccccccccccccccc55cccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccc00000cccc0000cc0000cc0000000000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccc0000000cccc0000cc0000cc000000000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccc0000000ccccc0000cc0000cc0000000cccccccccccccccc9cccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccc0000000ccccccc0000cc000ccc00000ccccccccccccccccc999ccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccc000000ccccccccc0000cc000ccc000ccccccccccccccccccc999ccc9ccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccc00000cccccccccc0000c000cccc0cccccccccccccccccc99c999cc99ccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccc00000c0cccccccc0000000ccccccccccccccccccccccccc9c999c9ccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccc0000000cccccccccc00000ccccccccccccccccccccccccc9c9999cccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccc0cccccccc0000000ccccccccccc000cccccccccccccccccccccccccc99999ccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccc000cccccccc0000000cccccccccccc0ccccccc0ccccccccccccccccccc5555555ccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccc0000cccccccc000000cccc0cccccccccccccc000ccccccccccccccccccc5555555cccccccccccccccccccccccccccccccccccccccccccccccc88888
ccccccccc0000cccccccc00000ccc000cccccccccccc00000ccccccccccccccccccc5555555cccccccccccccccccccccccccccccccccccccccccccccc8888888
ccccccccc0000cccccccc00000c00000cccccccccc0000000ccccccccccccccccccc5555555cccccccccccccccccccccccccccccccccccccccccccc888899999
ccccccccc0000cccccccc00000000000ccccccccc00000000ccccccccccccccccccc5555555ccccccccccccccccccccccccccccccccccccccccccc8889999999
ccccccccc0000cccccccc0000000000cccccccc000000c000ccccccccccccccccccc5555555cccccccccccccccccccccccccccccccccccccccccc88899999999
ccccccccc0000cccccccc00000000ccccccccc00000ccc000ccccccccccccccccccc5555555ccccccccccccccccccccccccccccccccccccccccc88899999aaaa
ccccccccc0000cccccccc000000ccccccccccc00ccccc0000ccccccccccccccccccc5555555ccccccccccccccccccccccccccccccccccccccccc889999aaaaaa
ccccccccc0000ccccc0cc0000ccccccccccccc0cccc000000ccccccccccccccccccc5555555cccccccccccccccccccccccccccccccccccccccc889999aaaaaaa
ccccccccc0000ccc000cc000cccccccccccccccccc0000000ccccccccccccccccccc5555555cccccccccccccccccccccccccccccccccccccccc88999aaaaaaaa
ccccccccc0000c00000cc0cccccccccccccccccccc00cc000ccccccccccccccccccc5555555ccccccccccccccccccccccccccccccccccccccc889999aaaaaaaa
ccccccccc0000000000ccccccccccccccccccccccc0ccc000ccccccccccccccccccc5555555ccccccccccccccccccccccccccccccccccccccc88999aaaaaaaaa
ccccccccc000000000cccccccccccccccccccccccccccc000ccccccccccccccccccc5555555ccccccccccccccccccccccccccccccccccccccc88999aaaaaaaaa
ccccccccc0000000cccccccccccccccccccccccccccccc000ccccccccccccccccccc5555555ccccccccccccccccccccccccccccccccccccccc88999aaaaaaaaa
ccccccccc00000cccccccccccccccccccccccccccccccc000ccccccccccccccccccc5555555ccccccccccccccccccccccccccccccccccccccc88999aaaaaaaaa
ccccccccc000ccccccccccccccccccccccccccccccccc0000ccccccccccccccccccccc555ccccccccccccccccccccccccccccccccccccccccc889999aaaaaaaa
ccccccccc0ccccccccccccccccccccccccccccccccc00000cccccccccccccccccccccc555ccccccccccccccccccccccccccccccccccccccccc889999aaaaaaaa
ccccccccccccccccccccccccccccccccccccccccc00000cccccccccccccccccccccccc555cccccccccccccccccccccccccccccccccccccccccc889999aaaaaaa
cccccccccccccccccccccccccccccccccccccccc00000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc8899999aaaaaa
ccccccccccccccccccccccccccccccccccccccc000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc88999999aaaa
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc888999999999
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc88899999999
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc8889999999
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaccccccccccccccccccccc888899999
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaccccccccccccccccccccc8888888
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaacccccccccccccccccccccc88888
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaacccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaacccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaacccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaacccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaacccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaacccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaacccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaccccccccccccccccccccccccccccccccc00000000000ccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaccccccccccccccccccccccccccccccccc0fffffffff0ccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaacccccccccccccccccccccccccccccccccc0fffffffff0ccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaccccccccccccccccccccccccccccccccccc0fffffffff0ccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0fffffffff0ccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccaaacccccccccccccccccccccccccccccccccccccccccccccccccccc0fffffffff0ccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccc0fffffffff0ccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccc0fffffffff0ccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccc0fffffffff0ccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccaaaccccccccccccccccccccccccccccccccccccc0000000000ccccc0fffffffff0ccccccccccccc
cccccccccccc00000000000ccccccccccccccccccccc0000ccccccccccccccccccccccccccccccccccccccccc0ffffffff0ccccc0fffffffff0ccccccccccccc
ccccccccc0000444444444400cccccccccccccccccc0044000ccccccccccccccccccccccccccccccccccccccc0ffffffff0ccccc0fffffffff0ccccccccccccc
ccccccc00044444444444444000cccccccccccccc00044444000ccccccccccccccccccccccccccccccccccccc0ffffffff0ccccc0fffffffff0ccccccccccccc
cccccc0044444444444444444440ccccccccc00000444444444000ccccccccccccccccccccccc000000ccccc00ffffffff0ccccc0fffffffff0ccccccccccccc
cccc0004444444444444444444440000ccc0004444444444444440000cccccccccccccccccc000444400000000ffffffff0ccccc0fffffffff0cccc000000ccc
cc0004444444444444444444444055550c044444444444444444444400ccccccccccccccc00444444444444440ffffffff0ccccc0fffffffff0cccc0ffff0ccc
00044444444444444444444444005005504444444444444444444444400000ccccccccc0004444444444444440ffffffff0ccccc0fffffffff0cccc0ffff0ccc
0444444444444444444444440050509055044444444444444444444444444400cccccc00444444444444444440ffffffff0ccccc0fffffffff0cccc0ffff0ccc
444444444444444444444440555050990550444444444444444444444444444000000044444444444444444440ffffffff00cccc0fffffffff0cccc0ffff0ccc
444444444444444400000005555055099050000000000000004444444444444444444444444444444444444440ffffffff040ccc0fffffffff0cccc0ffff0ccc
444444444444440003333055555005500050333333333333300000000000044444444444444444444444444440ffffffff0440cc0fffffffff0cccc0ffff0ccc
444444444444000333330555555500555550333333333333333333333333304444444444444444444444444440ffffffff04440c0fffffffff0cccc0ffff0ccc
444444444440033333005555555550000003333333333333333333333333330444444444444444444444444440ffffffff04440c0fffffffff0cccc0ffff0ccc
444444444000000000555555555555550333333300000000000000000000000444444444444444444444444440ffffffff0444400fffffffff0cccc0ffff0ccc
444444444033333305555555555555000000000000333333333333333333333044444444444444444444444440ffffffff0444440fffffffff0cccc0ffff0ccc
000000000033333055555555555550333333333330333330000000000000003300000000000000000000000000ffffffff0000000fffffffff00000000000000
666666666033330555555555555003333333333333033330777777777777770306666666666666666666666660ffffffff0666660fffffffff06666666666666
666666666033005555555555550333333000000033303330777777777777777030666666666666666666666660ffffffff0666660fffffffff06666666666666
666666666030555555555555503333333077777003330333077777777777777703066666666666666666666660ffffffff0666660fffffffff06666666666666
66666666600555555555555003333333307777770033033307777777777777700030666666666666666666666000000000066666000000000006666666666666
66666666605555555555550333333333307777777033303330777777770000033330666666666666666666666666666666666666666666666666666666666666
66666666600555555555503333333333300000000000330330000000003333333330066666666666666666666666666666666666666666666666666666666666
66666666600555555550033333333333303333333330033033333333333333333000066666666666666666666666666666666666666666666666666666666666
66666666603055555503333333333333303333333333003033333333330000000077066666666666666666666666666666666666666666666666666666666666
66666666603055555033333333333333003333333333300300000000000333333077066666666666666666666666666666666666666666666666666666666666
66666666603305550333333333333333033333333333330303333333333333333077066666666666666666666666666666666666666666666666666666666666
66666666603300000333333333333333033333333333330303300003333333333000066666666666666666666666666666666666666666666666666666666666
66666666603333333333333333333333033333333333330303307703333333333333066666666666666666666666666666666666666666666666666666666666
66666666603333333333333333333333033333333333330303307703333333333333066666666666666666666666666666666666666666666666666666666666
66666666603333333333333333333333033333333333330303307703333333333333066666666666666666666666666666666666666666666666666666666666
66666666603330000003333333333333000000000000330303300003333333333333066666666666666666666666666666666666666666666666666666666666
66666666603300555500333333333333333333333330000303333333333333333333066666666666666666666666666666666666666666666666666666666666
66666666660005555550033333333333333333333333333303333333333333333333066666666666666666666666666666666666666666666666666666666666
00000000000055555555033333333333333330000000333303333333333333333333066660000000000000000000000000000000000000000000000000000000
66666666666055000555033333333333333300555550033303333333333333333333066666666666666666666666666666666666666666666666666666666666
66666666666055080055000033333333333055555555003303333333333333333333066666666666666666666666666666666666666666666666666666666666
66666666666055088055066600003333330055555555503303333333333333333000066666666666666666666666666666666666666666666666666666666666
66666666666055008055066666660000330555555555503303333333333333300550666666666666666666666666666666666666666666666666666666666666
66666666666005500055066666666666000555000055500303333333333330008500666666666666666666666666666666666666666666666666666666666666
66666666666600555555066666666666660550888055550303333333333300885506666666666666666666666666666666666666666666666666666666666666
66666666666660055500666666666666660550888005550003333333330008555006666666666666666666666666666666666666666666666666666666666666
66666666666666000006666666666666660050888805550600000000000055555066666666666666666666666666666666666666666666666666666666666666
66666666666666666666666666666666666050888805550666666666666005550066666666666666666666666666666666666666666666666666666666666666

__map__
3030303030303030303030303030303000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3030303030303030303030303030303000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3030303030303030303030303030303000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020202020202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2222232323232323222323232323232300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2424242424242424242424242424242400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2424242424242424242424242424242400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2121212121212121212121212121212100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2121212121212121212121212121212100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00060000085500e5501155004550005001c5000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
001000000000012550105500e5500c5500e55012550175501f5502255000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000c00002e61020610166101461010610086100561001610006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600
000500000000003050000500005001050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000700000111000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
000700002215000000000002410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
