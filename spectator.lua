--[[
  This Lua script for FBNeo continuously reads and interprets specific RAM addresses for:
    - Character selection for both players (p1addr, p2addr)
    - Super Art selection for both players (selectedSuperArt_p1, selectedSuperArt_p2)
    - Color values for both players (p1color, p2color)
    - Game phase tracking (game_phase)

  Memory addresses:
    p1addr              0x02011387  (Player 1 character ID)
    p2addr              0x02011388  (Player 2 character ID)
    selectedSuperArt_p1 0x0201138B  (Player 1 Super Art selection:
                                     0 = Super 1, 1 = Super 2, 2 = Super 3)
    selectedSuperArt_p2 0x0201138C  (Player 2 Super Art selection:
                                     0 = Super 1, 1 = Super 2, 2 = Super 3)
    p1color             0x02015683  (Player 1 color)
    p2color             0x02015684  (Player 2 color)
    game_phase          0x020154A7  (Tracks the current phase of the round:
                                     1 = Round start screen,
                                     2 = In-round,
                                     6 = KO screen,
                                     8 = Transition to next round)

  Character code mappings (hexadecimal values):
    akuma   = 0e
    urien   = 0d
    necro   = 05
    ibuki   = 07
    sean    = 0c
    alex    = 01
    yun     = 03
    remy    = 14
    q       = 12
    chun li = 10
    makoto  = 11
    twelve  = 13
    yang    = 0a
    ken     = 0b
    hugo    = 06
    dudley  = 04
    oro     = 09
    ryu     = 02
    elena  = 08

  Super Art selection mapping:
    0 = Super 1
    1 = Super 2
    2 = Super 3

  Color mappings:
    0 = lp
    1 = mp
    2 = hp
    3 = lk
    4 = mk
    5 = hk
    Any other value outputs "special"

  This version outputs to the console and writes to "mapped_values.txt" only when a change
  is detected compared to the previous frame. The music functionality has been removed.

  Ensure that your FBNeo version supports:
    memory.readbyte(address)
    emu.frameadvance()
--]]

local file_path = "mapped_values.txt"

local characterMap = {
  ["0e"] = "akuma",
  ["0d"] = "urien",
  ["05"] = "necro",
  ["07"] = "ibuki",
  ["0c"] = "sean",
  ["01"] = "alex",
  ["03"] = "yun",
  ["14"] = "remy",
  ["12"] = "q",
  ["10"] = "chun li",
  ["11"] = "makoto",
  ["13"] = "twelve",
  ["0a"] = "yang",
  ["0b"] = "ken",
  ["06"] = "hugo",
  ["04"] = "dudley",
  ["09"] = "oro",
  ["02"] = "ryu",
  ["08"] = "elena"
}

local superMap = {
  [0] = "Super 1",
  [1] = "Super 2",
  [2] = "Super 3"
}

local colorMap = {
  [0] = "lp",
  [1] = "mp",
  [2] = "hp",
  [3] = "lk",
  [4] = "mk",
  [5] = "hk"
}

local function getCharacterName(value)
  local hexKey = string.format("%02x", value)
  return characterMap[hexKey] or "Unknown"
end

local function getSuperName(value)
  return superMap[value] or "Unknown Super"
end

local function getColorName(value)
  return colorMap[value] or "special"
end

local function getPhaseText(phase)
  if phase == 1 then
    return "Round start screen"
  elseif phase == 2 then
    return "In-round"
  elseif phase == 6 then
    return "KO screen"
  elseif phase == 8 then
    return "Transition to next round"
  else
    return "Unknown Phase"
  end
end

-- Memory address definitions
local p1addr_address    = 0x02011387
local p2addr_address    = 0x02011388
local p1super_address   = 0x0201138B
local p2super_address   = 0x0201138C
local p1color_address   = 0x02015683
local p2color_address   = 0x02015684
local gamePhase_address = 0x020154A7
local high_parry_address = 0x06202004
local low_parry_address = 0x06202404

local previousOutput = ""

while true do
    local p1addr    = memory.readbyte(p1addr_address)
    local p2addr    = memory.readbyte(p2addr_address)
    local p1super   = memory.readbyte(p1super_address)
    local p2super   = memory.readbyte(p2super_address)
    local p1color   = memory.readbyte(p1color_address)
    local p2color   = memory.readbyte(p2color_address)
    local gamePhase = memory.readbyte(gamePhase_address)
    local high_parry = memory.readbyte(high_parry_address)
    local low_parry = memory.readbyte(low_parry_address)
    
    local p1Character = getCharacterName(p1addr)
    local p2Character = getCharacterName(p2addr)
    local p1SuperArt  = getSuperName(p1super)
    local p2SuperArt  = getSuperName(p2super)
    local p1ColorText = getColorName(p1color)
    local p2ColorText = getColorName(p2color)
    local phaseText   = getPhaseText(gamePhase)
    
    local currentOutput = string.format(
        "P1: Character: %s (0x%02X), Super: %s (%d), Color: %s (%d)\n" ..
        "P2: Character: %s (0x%02X), Super: %s (%d), Color: %s (%d)\n" ..
        "Game Phase: 0x%02X (%s)\n" ..
        "High Parry: %d\n" ..
        "Low Parry: %d",
        p1Character, p1addr, p1SuperArt, p1super, p1ColorText, p1color,
        p2Character, p2addr, p2SuperArt, p2super, p2ColorText, p2color,
        gamePhase, phaseText,
        high_parry, low_parry
    )
    
    if currentOutput ~= previousOutput then
        local file = io.open(file_path, "w")
        if file then
            file:write(currentOutput .. "\n")
            file:close()
        else
            print("Failed to open file: " .. file_path)
        end
        
        print(currentOutput)
        previousOutput = currentOutput
    end
    
    emu.frameadvance()
end
