Block = Class{}

function Block:init(x, y, biome)
    self.type = 3

    self.x = x
    self.y = y
    self.width = 36
    self.height = 36

    --This is for later purposing of deleting the blocks after you 
    --have reached to next level
    self.inPlay = true
end

function Block:render()
    love.graphics.draw(
        gTextures['main'],
        gFrames['blocks'][self.type],
        self.x, self.y
    )
end

