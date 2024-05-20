import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/object"

local gfx = playdate.graphics

-- Set up the game
function setup()
    -- Set background color to black
    gfx.setBackgroundColor(gfx.kColorBlack)

    -- Initialize sprites and other game elements here
    local player = nil

function setupPlayer()
    -- Create player sprite
    player = gfx.sprite.new(gfx.image.new("images/player"))
    player:moveTo(30, 120) -- Start position on the left side
    player:add()

    -- Set up player controls
    function playdate.upButtonDown()
        player:moveBy(0, -5)
    end

    function playdate.downButtonDown()
        player:moveBy(0, 5)
    end
end

local enemies = nil

function setupEnemies()
    -- Set up initial enemy state
end

function spawnEnemy()
    local enemy = gfx.sprite.new(gfx.image.new("images/enemy"))
    enemy:moveTo(400, math.random(0, 240)) -- Start position on the right side
    enemy:add()

    table.insert(enemies, enemy)
end

function updateEnemies()
    for _, enemy in ipairs(enemies) do
        enemy:moveBy(-2, 0) -- Move left

        -- Check for collisions with player
        if enemy:overlappingSprites()[player] then
            transitionToGameOver()
        end
    end
end

    -- Start the game loop
    playdate.timer.performAfterDelay(1000, spawnEnemy, true)
end


function transitionToGameOver()
    -- Handle game over scene transition
end

local lasers = nil

function playdate.AButtonDown()
    local laser = gfx.sprite.new(gfx.image.new("images/laser"))
    laser:moveTo(player.x + 10, player.y)
    laser:add()

    table.insert(lasers, laser)
end

function updateLasers()
    for _, laser in ipairs(lasers) do
        laser:moveBy(5, 0) -- Move right

        -- Check for collisions with enemies
        for _, enemy in ipairs(enemies) do
            if laser:overlappingSprites()[enemy] then
                enemy:remove()
                laser:remove()
                -- Increase score
                -- Remove enemy from enemies table
                -- Remove laser from lasers table
            end
        end
    end
end

function playdate.update()
    gfx.sprite.update()
    playdate.timer.updateTimers()
    updateEnemies()
    updateLasers()
end

local score = 0

function updateScore()
    -- Update score display
end

function increaseScore()
    score = score + 1
    updateScore()
end

function transitionToGameOver()
    -- Handle game over scene transition
    -- Display final score
end

function playdate.update()
    gfx.sprite.update()
    playdate.timer.updateTimers()
end