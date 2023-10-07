Spike = Class{}

function Spike:init(y)
    self.image = gImages['spike']
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH
    --I set 16 as to make spike just to have smaller gaps
    self.y = y

    self.dx = 0

    self.remove = false
end

function Spike:update(dt)
    self.dx = self.dx + -SPIKE_SPEED * dt
    self.x = self.x + self.dx

    --if the spike has exceeded that the left border of the screen
    if self.x < 0 then
        self.remove = true
    end
end

function Spike:render()
    love.graphics.draw(self.image, self.x, self.y)
end


