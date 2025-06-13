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

    sec_left = 10
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

    -- for bu in all(all_bullets) do
    --     bu:update()
    -- end
    -- for bi in all(all_buildings) do
    --     bi:update()
    -- end
    -- for m in all(all_missiles) do
    --     m:update()
    -- end
    -- for bo in all(all_booms) do
    --     bo:update()
    -- end
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

    -- for b in all(all_buildings) do
    --     b:draw()
    -- end
    -- for bu in all(all_bullets) do
    --     bu:draw()
    -- end
    -- for m in all(all_missiles) do
    --     m:draw()
    -- end
    -- for bo in all(all_booms) do
    --     bo:draw()
    -- end
    line(0, 111, 128, 111, 0)


    -- ground
    --rectfill(0, 128-18, 127, 127, 5)

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
