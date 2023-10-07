--reference from http://cdn.cs50.net/games/2018/x/lectures/2/src2.zip
PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.biome = params.biome
end

function PlayState:init()
    self.player = Player()
    self.spikeList = {}
    self.timer = 0

    self.blocks = LevelMaker.createMap(self.biome)
end

function PlayState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
            gSounds['pause']:play()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        gSounds['pause']:play()
        return
    end

    --update timer for spike spawning
    self.timer = self.timer + dt

    --another 3 spikes spawn every 3 seconds
    if self.timer > 1 then

        --this makes is spawn at a certain point
        --I set 16 as to make spike just to have smaller gaps
        local y = math.random(16 ,VIRTUAL_HEIGHT - 16 - 16)

        table.insert(self.spikeList, Spike(y))

        --reset timer
        self.timer = 0
    end

    --This is the update logic for the spikes
    for k, spike in pairs(self.spikeList) do
        spike:update(dt)
    end

    --This is removal of spikes if they have exceeded the left border
    --of the screen
    for k, spike in pairs(self.spikeList) do
        if spike.remove then
            table.remove(self.spikeList, k)
        end
    end

    -- Collision between player and spikes
    for k, spike in pairs(self.spikeList) do
        if self.player:collides(spike) then
            gSounds['pain']:play()
            gSounds['hurt']:play()
        end
    end

    --[[Collision between player and blocks
    for k, block in pairs(self.blocks) do
        if self.player:collides(block) then
            self.player.y_limit = block.y
        end
    end
    ]]

    --[[ this is for later purposes
    --detect collision across all blocks with the player
    for k, block in pairs(self.blocks) do

        if self.player:collides(block) then
    ]]

    -- update positions based on velocity
    self.player:update(dt)
end

function PlayState:render()
    --render blocks
    for k, block in pairs(self.blocks) do
        block:render()
    end

    for k, spike in pairs(self.spikeList) do
        spike:render()
    end

    self.player:render()

    -- pause text, if paused
    if self.paused then
        love.graphics.setFont(gFonts['bold_title'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end