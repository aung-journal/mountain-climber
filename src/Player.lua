Player = Class{}

function Player:init()

    self.image = gImages['player']
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = 0
    self.y = (VIRTUAL_HEIGHT - 20) -self.height

    self.dx = 0
    self.dy = 0

    self.y_limit = VIRTUAL_HEIGHT - 16 - self.height -- this is to make player on the block
end

function Player:animate()
    
end

function Player:collides(spike)
    -- the 2's are left and top offsets
    -- the 4's are right and bottom offsets
    -- both offsets are used to shrink the bounding box to give the player
    -- a little bit of leeway with the collision
    if (self.x + 2) + (self.width - 4) >= spike.x and self.x + 2 <= spike.x + spike.width then
        if (self.y + 2) + (self.height - 4) >= spike.y and self.y + 2 <= spike.y + spike.height then
            return true
        end
    end

    return false
end

function Player:yPosition(block)
    local margin = 2

    if (self.y + self.height + margin) == block.y then
        if self.x == block.x or self.x <= (block.x + block.width)then
            self.y_limit = block.y - self.height
        end
    end
end

function Player:update(dt)
    -- Apply gravity
    self.dy = self.dy + GRAVITY * dt

    -- Jumping logic
    if love.keyboard.isDown('up') then
        self.dy = -JUMPING_SPEED
    end

    --Running logic
    if love.keyboard.isDown('right') then
        self.dx = WALKING_SPEED
    elseif love.keyboard.isDown('left') then
        self.dx = -WALKING_SPEED
    end

    -- Update the xy-coordinate
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    -- Ensure the player stays within the vertical boundaries
    self.y = math.max(0, math.min(self.y_limit, self.y))

    --Ensure the player stays within the horizontal boundaries
    self.x = math.max(0, math.min(VIRTUAL_WIDTH - self.width, self.x))
end

function Player:render()
    love.graphics.draw(self.image, self.x, self.y)
end