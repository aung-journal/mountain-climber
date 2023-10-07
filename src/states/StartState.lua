--reference from http://cdn.cs50.net/games/2018/x/lectures/2/src2.zip
StartState = Class{__includes = BaseState}

-- whether we're highlighting "Start" or "High Scores"
local highlighted = 1

function StartState:update(dt)
    -- toggle highlighted option if we press an arrow key up or down
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = highlighted == 1 and 2 or 1
        gSounds['paddle-hit']:play()
    end

    -- confirm whichever option we have selected to change screens
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['confirm']:play()

        if highlighted == 1 then
            gStateMachine:change('play',{
                biome = math.random(4)
            })
        end
    end

    -- we no longer have this globally, so include here
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function StartState:render()

    -- title
    love.graphics.setFont(gFonts['bold_title'])
    love.graphics.printf("Moutain Climber", 0, VIRTUAL_HEIGHT / 3,
        VIRTUAL_WIDTH, 'center')

    --reset the font to bold_large
    love.graphics.setFont(gFonts['bold_large'])

    -- if we're highlighting 1, render that option blue
    if highlighted == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 50,
        VIRTUAL_WIDTH, 'center')

    --reset the color
    love.graphics.setColor(0, 0, 0, 1)

    -- render option 2 blue if we're highlighting that one
    if highlighted == 2 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("HIGH SCORES", 0, VIRTUAL_HEIGHT / 2 + 90,
        VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(0, 0, 0, 1)
end