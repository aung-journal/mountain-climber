LevelMaker = Class{}

function LevelMaker.createMap(level, biome)
    local Blocks = {}

    -- Define the number of rows
    local numRows = 8

    -- Calculate the total number of Blocks
    local totalBlocks = numRows * (numRows + 1) / 2

    -- Calculate the x and y offset for the bottom-right corner block
    local xOffset = VIRTUAL_WIDTH - 36
    local yOffset = VIRTUAL_HEIGHT - 16 - 36

    -- Distribute the Blocks to create the stair-like pattern
    local BlockIndex = 1
    for y = 1, numRows do
        local numCols = y -- Varying number of columns for each row

        for x = 1, numCols do
            local BlockX = xOffset - (numCols - x) * 36
            local BlockY = yOffset - (numRows - y) * 36

            b = Block(
                -- x-coordinate
                BlockX,
                -- y-coordinate
                BlockY
            )

            table.insert(Blocks, b)
            BlockIndex = BlockIndex + 1
            if BlockIndex > totalBlocks then
                break
            end
        end
    end

    return Blocks
end



