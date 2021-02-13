--[[
----
MIRIN_PORTABLE.LUA v1.0
THE QUINTESSENTIAL PORTING SCRIPT FOR MIRIN 2.0

Created by Sudospective
Special thanks to Mr. ThatKid
----

----
If you plan on using this porting script there are a few things you should do:

- CorrectZDist(self) and CorrectFOV(self) in main ActorFrame
- Load external Lua through loadfile(path_to_lua)
  (thats the whole point of this script's purpose ~wo)

There are a lot more changes to consider, mainly everything listed under alias below.

If you find any mods that don't work right and need to be ported, @ me in the UKSRT
Discord or send me a DM, and I'll look into it when I have the time.

(also not to be self-selling or whatever but i could use more twitter followers @sudospective)

(also also check out my website its fun https://sudospective.net)

Happy porting!
----
]]--

xero()

bw, bh = 640, 480
sm_scaleW, sm_scaleH = sw / bw, sh / bh
sm_scaleR = sm_scaleW / sm_scaleH
sm_fix = (FUCK_EXE and 0) or 1

function CorrectZDist(actor)
    if not FUCK_EXE and actor and actor.GetNumChildren then
        actor:fardistz(1000 * sm_scaleW)
        for an = 0, actor:GetNumChildren() - 1 do
            CorrectZDist(actor:GetChildAt(an))
        end
    end
end
function CorrectFOV(actor, fov)
    if not FUCK_EXE and actor and actor.GetNumChildren then
        actor:fov(fov)
        for an = 0, actor:GetNumChildren() - 1 do
            CorrectFOV(actor:GetChildAt(an), fov)
        end
    end
end

--[[
    ////////////////////////////////////////////////////////////////
    // USE THESE COMPATIBLITY MODS INSTEAD OF THE NITG EQUIVALENT //
    ////////////////////////////////////////////////////////////////

    Everything else should work the same.
    If you put in a little bit of effort, you save Kid a lot of work.
--]]

-- Generic Conversion
--[[
alias
{'targetrotationx1', 'confusionxoffset'..sm_fix}				-- Column ConfusionX
{'targetrotationx2', 'confusionxoffset'..sm_fix + 1}
{'targetrotationx3', 'confusionxoffset'..sm_fix + 2}
{'targetrotationx4', 'confusionxoffset'..sm_fix + 3}

{'targetrotationy1', 'confusionyoffset'..sm_fix}				-- Column ConfuionY
{'targetrotationy2', 'confusionyoffset'..sm_fix + 1}
{'targetrotationy3', 'confusionyoffset'..sm_fix + 2}
{'targetrotationy4', 'confusionyoffset'..sm_fix + 3}

{'targetrotationz1', 'confusionoffset'..sm_fix}					-- Column ConfusionZ
{'targetrotationz2', 'confusionoffset'..sm_fix + 1}
{'targetrotationz3', 'confusionoffset'..sm_fix + 2}
{'targetrotationz4', 'confusionoffset'..sm_fix + 3}

{'targetx1', 'movex'..sm_fix}									-- Column MoveX
{'targetx2', 'movex'..sm_fix + 1}
{'targetx3', 'movex'..sm_fix + 2}
{'targetx4', 'movex'..sm_fix + 3}

{'targety1', 'movey'..sm_fix}									-- Column MoveY
{'targety2', 'movey'..sm_fix + 1}
{'targety3', 'movey'..sm_fix + 2}
{'targety4', 'movey'..sm_fix + 3}

{'targetz1', 'movez'..sm_fix}									-- Column MoveZ
{'targetz2', 'movez'..sm_fix + 1}
{'targetz3', 'movez'..sm_fix + 2}
{'targetz4', 'movez'..sm_fix + 3}

{'targetskewx1', 'noteskewx'..sm_fix}							-- Column NoteSkewX
{'targetskewx2', 'noteskewx'..sm_fix + 1}
{'targetskewx3', 'noteskewx'..sm_fix + 2}
{'targetskewx4', 'noteskewx'..sm_fix + 3}

{'targetstealth1', 'dark'..sm_fix}								-- Column Dark
{'targetstealth2', 'dark'..sm_fix + 1}
{'targetstealth3', 'dark'..sm_fix + 2}
{'targetstealth4', 'dark'..sm_fix + 3}

{'targetreverse1', 'reverse'..sm_fix}							-- Column Reverse
{'targetreverse2', 'reverse'..sm_fix + 1}
{'targetreverse3', 'reverse'..sm_fix + 2}
{'targetreverse4', 'reverse'..sm_fix + 3}
]]--

{'confusionzoffset', 'confusionoffset'}							-- Confusion Z offset alias hack
{'hidenoteflashes', 'hidenoteflash'}

--[[
{'targetrotationx', 'confusionxoffset'}							-- just in case you end up typing these
{'targetrotationy', 'confusionyoffset'}
{'targetrotationz', 'confusionzoffset'}
{'targetstealth', 'dark'}
]]--

-- SM Specific Conversion
if not FUCK_EXE then

    -- Player Notefield
    local PN = {}
    for pn = 1, 2 do
        if P[pn]:GetChild('NoteField'):GetNumWrapperStates() == 0 then
            P[pn]:GetChild('NoteField'):AddWrapperState()
        end
        PN[pn] = P[pn]:GetChild('NoteField'):GetWrapperState(1)
        PN[pn]:rotafterzoom(false)
    end

    -- Player Options
    local POptions = {
        GAMESTATE:GetPlayerState(0):GetPlayerOptions('ModsLevel_Song'),
        GAMESTATE:GetPlayerState(1):GetPlayerOptions('ModsLevel_Song')
    }
    
    -- These mods were aliased from NotITG to OutFox. You can use them like you already do.
    alias
    {'holdstealth', 'stealthholds'}									-- Hold stealth
    {'centered2', 'centeredpath'}									-- Cenetered but math that makes sense
    {'arrowpath', 'notepath'}										-- Arrow path
    {'arrowpath0', 'notepath1'}										-- Arrow path 1
    {'arrowpath1', 'notepath2'}										-- Arrow path 2
    {'arrowpath2', 'notepath3'}										-- Arrow path 3
    {'arrowpath3', 'notepath4'}										-- Arrow path 4
    --[[
    For reference, these mods were defined for OutFox using Actor tweens or existing mods:
    ----
    'x', 'y', 'z'													-- X, Y, and Z position tweenmods
    'rotationx', 'rotationy', 'rotationz'							-- X, Y, and Z rotation tweenmods
    'zoomx', 'zoomy', 'zoomz'                                       -- X, Y, and Z zoom tweenmods
    'tiny'														    -- Tiny
    'hide'														    -- Hide
    'hidenoteflash'												    -- Hide note flash
    'holdgirth'													    -- Hold girth
    ---
    ]]--
    
    -- NON-COLUMN
    for _, tween in ipairs {
        'x',
        'y',
        'z',
        'rotationx',
        'rotationy',
        'rotationz',
        'skewx',
        'skewy',
    } do
        definemod {
            tween,
            function(n, pn)
                if PN[pn] then PN[pn][tween](PN[pn], n) end
            end,
            defer = true
        }
    end

    definemod
    {
        'zoomx',
        function(n, pn)
            if PN[pn] then PN[pn]:zoomx(n * 0.01) end
        end,
        defer = true
    }
    {
        'zoomy',
        function(n, pn)
            if PN[pn] then PN[pn]:zoomy(n * 0.01) end
        end,
        defer = true
    }
    {
        'zoomz',
        function(n, pn)
            if PN[pn] then PN[pn]:zoomz(n * 0.01 * sm_scaleR) end
        end,
        defer = true
    }
    {
        'tiny',
        function(n)
            return n, n
        end,
        'tinyx', 'tinyy',
        defer = true
    }
    {
        'hide',
        function(n, pn)
            if PN[pn] then PN[pn]:visible(n <= 0) end
        end,
        defer = true
    }
    {
        'hidenoteflash',
        function(n)
            return n, n, n, n
        end,
        'hidenoteflash1', 'hidenoteflash2', 'hidenoteflash3', 'hidenoteflash4',
        defer = true
    }
    {
        'holdgirth',
        function(n)
            return -n, -n, -n, -n
        end,
        'holdtinyx1', 'holdtinyx2', 'holdtinyx3', 'holdtinyx4',
        defer = true
    }

    -- COLUMN
    for col = 1, 4 do
        for _, mod in ipairs {
            'ConfusionXOffset',
            'ConfusionYOffset',
            'ConfusionZOffset',
            'MoveX',
            'MoveY',
            'MoveZ',
            'NoteSkewX',
            'NoteSkewY',
            'Dark',
            'Reverse'
        } do
            local modname = mod..col
            definemod {
                string.lower(mod)..col - 1,
                function(n, pn)
                    if POptions[pn] then
                        POptions[pn][modname](POptions[pn], n, -1)
                    end
                end,
                defer = true
            }
        end
    end
end
