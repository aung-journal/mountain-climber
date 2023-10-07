require 'src/Dependencies'

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    love.window.setTitle('Mountain Climber')

    gFonts = {
        ['regular_small'] = love.graphics.newFont('fonts/Regular.ttf', 8),
        ['regular_medium'] = love.graphics.newFont('fonts/Regular.ttf', 16),
        ['regular_large'] = love.graphics.newFont('fonts/Regular.ttf', 32),
        ['bold_small'] = love.graphics.newFont('fonts/Bold.ttf', 8),
        ['bold_medium'] = love.graphics.newFont('fonts/Bold.ttf', 16),
        ['bold_large'] = love.graphics.newFont('fonts/Bold.ttf', 32),
        ['bold_title'] = love.graphics.newFont('fonts/Bold.ttf', 56)
    }
    
    gImages = {
        ['player'] = love.graphics.newImage('graphics/cancelled/climber.png'),
        --https://media.istockphoto.com/id/1186138653/vector/pixel-art-game-background-with-blue-sky-and-clouds.jpg?s=170667a&w=0&k=20&c=2-Cr2cuAY4kRa5OFzjcaDP83Ju4AdlUldzK53XL-1P4=
        ['main'] = love.graphics.newImage('graphics/blue_sky.jpg'),
        ['spike'] = love.graphics.newImage('graphics/spike.png')
    }

    gPlayers = {
        --draw player by myself and make my game authentically looking tmr
        ['player'] = love.graphics.newImage('graphics/cancelled/climber.png'),

    }

    gTextures = {
        ['main'] = love.graphics.newImage('graphics/dirt.png'),
        ['grounds'] = love.graphics.newImage('graphics/Grounds.png'),
        ['player'] = love.graphics.newImage('graphics/Player/player.png')
    }

    gFrames = {
        ['blocks'] = GenerateQuadsBlocks(gTextures['main']),
        ['grounds'] = GenerateQuadsGrounds(gTextures['grounds'])
    }

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    --reference from http://cdn.cs50.net/games/2018/x/lectures/2/src2.zip
    gSounds = {
        ['paddle-hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall-hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
        ['confirm'] = love.audio.newSource('sounds/confirm.wav', 'static'),
        ['select'] = love.audio.newSource('sounds/select.wav', 'static'),
        ['no-select'] = love.audio.newSource('sounds/no-select.wav', 'static'),
        ['brick-hit-1'] = love.audio.newSource('sounds/brick-hit-1.wav', 'static'),
        ['brick-hit-2'] = love.audio.newSource('sounds/brick-hit-2.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['victory'] = love.audio.newSource('sounds/victory.wav', 'static'),
        ['recover'] = love.audio.newSource('sounds/recover.wav', 'static'),
        ['high-score'] = love.audio.newSource('sounds/high_score.wav', 'static'),
        ['pause'] = love.audio.newSource('sounds/pause.wav', 'static'),
        --one from https://mixkit.co/free-sound-effects/hurt/
        ['pain'] = love.audio.newSource('sounds/pain.wav', 'static'),

        ['music'] = love.audio.newSource('sounds/music.wav', 'static'),
        ['background'] = love.audio.newSource('sounds/meditation_background.mp3', 'static')
    }

    --kick off relaxing meditation music
    gSounds['background']:setLooping(true)
    gSounds['background']:play()

    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end
    }
    gStateMachine:change('start')

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
        % VIRTUAL_WIDTH

    gStateMachine:update(dt)

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    love.keyboard.keysPressed = {}
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else 
        return false
    end
end

function love.draw()

    push:apply('start')

    love.graphics.draw(gImages['main'], -backgroundScroll, 0)

    love.graphics.draw(gTextures['grounds'] ,gFrames['grounds'][3], -groundScroll, VIRTUAL_HEIGHT - 16)
    --because globally setting math.random() is not working, I go through changing the states through enter state
    --but it doesn't also work as biome here were say as it is returning nill value

    gStateMachine:render()

    displayFPS()

    push:apply('end')
end

--reference from http://cdn.cs50.net/games/2018/x/lectures/2/src2.zip
function displayFPS()
    love.graphics.setFont(gFonts['bold_medium'])
    love.graphics.setColor(0,0,0,1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
end



