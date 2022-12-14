local function signum(n)
    if n == 0 then
        return 0
    elseif n < 0 then
        return -1
    else
        return 1
    end
end

-- Look, ma, no classes!
local function Field()
    local field = {
        bottom = 0,
        cells = {},
    }

    function field:add_wall(x, y)
        self.cells[x .. ":" .. y] = "#"
        if y > self.bottom then
            self.bottom = y
        end
    end

    function field:add_sand(x, y)
        self.cells[x .. ":" .. y] = "*"
    end

    function field:is_empty(x, y)
        if PART == 2 and y == self.bottom + 2 then
            return false
        end
        return self.cells[x .. ":" .. y] == nil
    end

    return field
end

local function segments(s)
    local init = 1
    return function()
        local start, _, sx, sy, ex, ey = s:find("(%d+),(%d+) [-]> (%d+),(%d+)", init)
        init = s:find('[-]>', start)
        return tonumber(sx), tonumber(sy), tonumber(ex), tonumber(ey)
    end
end

-- non-local! global variable, accessed everywhere
PART = tonumber(arg[1])
local field = Field()

for line in io.stdin:lines() do
    for sx, sy, ex, ey in segments(line) do
        field:add_wall(ex, ey)
        while sx ~= ex or sy ~= ey do
            field:add_wall(sx, sy)
            sx = sx + signum(ex - sx)
            sy = sy + signum(ey - sy)
        end
    end
end

local units_dropped = 0
while field:is_empty(500, 0) do
    local x, y = 500, 0
    local found = false
    while not found and (PART == 2 or y < field.bottom) do
        y = y + 1
        if field:is_empty(x, y) then
        elseif field:is_empty(x - 1, y) then
            x = x - 1
        elseif field:is_empty(x + 1, y) then
            x = x + 1
        else
            field:add_sand(x, y - 1)
            found = true
        end
    end
    if not found then break end
    units_dropped = units_dropped + 1
end

print(units_dropped)
