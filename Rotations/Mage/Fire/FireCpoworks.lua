local rotationName  = "Cpoworks"
local versionNum    = "1.0.0"
local colorRed      = "|cffFF0000"
local br = _G["br"]
---------------
--- Toggles ---
---------------
local function createToggles()
    -- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.flamestrike},
        [2] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.iceBlock}
    };
    CreateButton("Rotation",1,0)

    -- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.timeWarp},
        [2] = { mode = "On", value = 2 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = br.player.spell.timeWarp},
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.timeWarp}
    };
    CreateButton("Cooldown",2,0)

    -- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.blazingBarrier},
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.blazingBarrier}
    };
    CreateButton("Defensive",3,0)

    -- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = br.player.spell.counterspell},
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = br.player.spell.counterspell}
    };
    CreateButton("Interrupt",4,0)

    -- Combustion Button
    CombustionModes = {
        [1] = {mode = "On", value = 1, overlay = "AoE Enabled", tip = "Will use AoE During Combustion", highlight = 1, icon = br.player.spell.combustion},
        [2] = {mode = "Off", value = 0, overlay = "AoE Disabled", tip = "Will Not use AoE During Combustion", highlight = 0, icon = br.player.spell.combustion}
    };
    CreateButton("Combustion",1,1)

    -- Dragonbreath Button
    DragonsBreathModes = {
       [1] = { mode = "On", value = 1 , overlay = "Dragonbreath Enabled", tip = "Always use Dragonbreath.", highlight = 1, icon = br.player.spell.dragonsBreath},
       [2] = { mode = "Off", value = 2 , overlay = "Dragonbreath Disabled", tip = "Don't use Dragonbreath.", highlight = 0, icon = br.player.spell.dragonsBreath}
    };
    CreateButton("DragonsBreath",2,1)
    -- Save FB Button
    SaveFBModes = {
       [1] = { mode = "On", value = 1 , overlay = "Using Fireblasts", tip = "Use Fireblast Charges.", highlight = 1, icon = br.player.spell.fireBlast},
       [2] = { mode = "Off", value = 2 , overlay = "Saving Fireblasts", tip = "Save Fireblast Charges.", highlight = 0, icon = br.player.spell.fireBlast}
    };
    CreateButton("SaveFB",3,1)
end

---------------
--- OPTIONS ---
---------------
local function createOptions()
    local optionTable

    local function rotationOptions()
        local section
        -- General Options
         section = br.ui:createSection(br.ui.window.profile, colorRed .. "Fire " .. ".:|:. General ".. "Ver " ..colorRed..versionNum.. " .:|:. ")
            -- APL
            br.ui:createDropdownWithout(section, "APL Mode", {"|cffFFFFFFSimC"}, 1, "|cffFFFFFFSet APL Mode to use.")
            -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS Testing",  1,  1,  60,  1,  "|cffFFFFFFSet to desired time for test in minuts. Min: 1 / Max: 60 / Interval: 5")
        br.ui:checkSectionState(section)
        -- Pre-Combat Options
        section = br.ui:createSection(br.ui.window.profile, "Pre-Combat")
            -- Auto Buff Arcane Intellect
            br.ui:createCheckbox(section,"Arcane Intellect", "Check to auto buff Arcane Intellect on party.")
            -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull",  5,  1,  10,  1,  "|cffFFFFFFSet to desired time to start Pre-Pull (DBM Required). Min: 1 / Max: 10 / Interval: 1")
        br.ui:checkSectionState(section)
        -- AoE Options
        section = br.ui:createSection(br.ui.window.profile, colorRed .. "AoE " .. ".:|:. " .. colorRed .. " Area of Effect")
            -- AoE Meteor
            br.ui:createSpinner(section,"Meteor Targets",  3,  1,  10,  1, "Min AoE Units")
            br.ui:createCheckbox(section, "Use Meteor outside ROP", "If Unchecked, will only use Meteor if ROP buff is up")
            -- Flamestrike
            br.ui:createSpinnerWithout(section,"FS Targets (Hot Streak)",  3,  1,  10,  1, "Min AoE Units")
            br.ui:createSpinnerWithout(section,"FS Targets (Flame Patch)",  3,  1,  10,  1, "Min AoE Units")
            -- Rune of Power
            br.ui:createSpinnerWithout(section,"RoP Targets",  3,  1,  10,  1, "Min AoE Units")
            -- Combustion (Firestarter)
            br.ui:createSpinnerWithout(section,"Combustion Targets",  3,  1,  10,  1, "Min AoE Units to use Combustion with Firestarter Talent")
        br.ui:checkSectionState(section)
        -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, colorRed .. "CDs " .. ".:|:. " ..colorRed .. " Cooldowns")
            -- Augment
            br.ui:createCheckbox(section,"Augment")
            -- Elixir
            br.ui:createDropdownWithout(section,"Elixir", {"Greater Flask of Endless Fathoms","Flask of Endless Fathoms","None"}, 1, "|cffFFFFFFSet Elixir to use.")
            -- Potion
            br.ui:createCheckbox(section,"Potion")
            -- Mirror Image
            br.ui:createCheckbox(section,"Mirror Image")
            -- Trinkets
            br.ui:createDropdownWithout(section, "Trinkets", {"|cff00FF001st Only","|cff00FF002nd Only","|cffFFFF00Both","|cffFF0000None"}, 1, "|cffFFFFFFSelect Trinket Usage.")
            -- Racial 
            br.ui:createCheckbox(section,"Racial")
        br.ui:checkSectionState(section)
        -- Defensive Option
        section = br.ui:createSection(br.ui.window.profile, colorRed .. "DEF" .. ".:|:. " ..colorRed .. " Defensive")
            -- Healthstone
            br.ui:createSpinner(section, "Pot/Stoned",  60,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
            -- Heirloom Neck
            br.ui:createSpinner(section, "Heirloom Neck",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.")
            -- Gift of The Naaru
            if br.player.race == "Draenei" then
                br.ui:createSpinner(section, "Gift of the Naaru",  50,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
            end
            -- Blast Wave
            br.ui:createSpinner(section, "Blast Wave",  30,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.")
            -- Blazing Barrier
            br.ui:createSpinner(section,"Blazing Barrier", 85, 0, 100, 5,   "|cffFFBB00Health Percentage to use at.")
            br.ui:createCheckbox(section, "Blazing Barrier OOC")
            -- Frost Nova
            br.ui:createSpinner(section, "Frost Nova",  50,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.")
            -- Ice Block
            br.ui:createSpinner(section, "Ice Block", 15, 0, 100, 5, "|cffFFBB00Health Percent to Cast At")
            -- Spellsteal
            br.ui:createDropdown(section,"Spellsteal", {"|cffFFFF00Selected Target","|cffFFBB00Auto"}, 1, "|ccfFFFFFFTarget to Cast On")
        br.ui:checkSectionState(section)
        -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "Interrupts")
            -- Couterspell
            br.ui:createCheckbox(section, "Counterspell")
            -- Interrupt Percentage
            br.ui:createSpinner(section, "Interrupt At",  0,  0,  95,  5,  "|cffFFFFFFCast Percent to Cast At")
        br.ui:checkSectionState(section)
        -- Toggle Key Options
        section = br.ui:createSection(br.ui.window.profile, "Toggle Keys")
            -- Single/Multi Toggle
            br.ui:createDropdown(section, "Rotation Mode", br.dropOptions.Toggle,  6)
            -- Cooldown Key Toggle
            br.ui:createDropdown(section, "Cooldown Mode", br.dropOptions.Toggle,  6)
            -- Defensive Key Toggle
            br.ui:createDropdown(section, "Defensive Mode", br.dropOptions.Toggle,  6)
            -- Interrupts Key Toggle
            br.ui:createDropdown(section, "Interrupt Mode", br.dropOptions.Toggle,  6)
            -- Pause Toggle
            br.ui:createDropdown(section, "Pause Mode", br.dropOptions.Toggle,  6)
        br.ui:checkSectionState(section)
    end
    optionTable = {{
        [1] = "Rotation Options",
        [2] = rotationOptions,
    }}
    return optionTable
end

--------------
--- Locals ---
--------------
-- BR API Locals
local buff
local cast
local cd
local charges
local conduit = {}
local debuff
local enemies
local equiped
local essence
local module
local spell
local talent
local traits
local unit
local units
local use
local ui

-- General Locals - Common Non-BR API Locals used in profiles
local haltProfile
local healPot
local profileStop

-- Profile Specific Locals - Any custom to profile locals
local combatTime
local deadtar, attacktar, hastar, playertar
local falling, swimming, flying, moving
local gcd
local gcdMax
local inCombat
local inInstance
local inRaid
local item
local mode     
local php
local power, powmax, powgen, powerDeficit
local pullTimer
local racial
local solo
local thp

local dBEnemies
local firestarterActive
local firestarterInactive
local hot_streak_spells_in_flight
local shifting_power_full_reduction

local actionList = {}
local var
local runeforge = {}



-----------------
--- Functions ---
-----------------
local doNotSteal = {
    [273432] = "Bound By Shadow(Uldir)",
    [269935] = "Bound By Shadow(KR)"
}
local function spellstealCheck(unit)
    local i = 1
    local buffName, _, _, _, duration, expirationTime, _, isStealable, _, spellId = UnitBuff(unit, i)
    while buffName do
        if doNotSteal[spellId] then
            return false
        elseif isStealable and (GetTime() - (expirationTime - duration)) > dispelDelay then
            return true
        end
        i = i + 1
        buffName, _, _, _, duration, expirationTime, _, isStealable, _, spellId = UnitBuff(unit, i)            
    end
    return false
end
local function meteor(unit)
    local combatRange = max(5, UnitCombatReach("player") + UnitCombatReach(unit))
    local px, py, pz = ObjectPosition("player")
    local x, y, z = GetPositionBetweenObjects(unit, "player", combatRange - 2)
    z = select(3, TraceLine(x, y, z + 5, x, y, z - 5, 0x110)) -- Raytrace correct z, Terrain and WMO hit
    if z ~= nil and TraceLine(px, py, pz + 2, x, y, z + 1, 0x100010) == nil and TraceLine(x, y, z + 4, x, y, z, 0x1) == nil then -- Check z and LoS, ignore terrain and m2 colissions and check no m2 on hook location
        CastSpellByName(GetSpellInfo(spell.meteor))
        br.addonDebug("Casting Meteor")
        ClickPosition(x, y, z)
        if wasMouseLooking then
            MouselookStart()
        end
    end
end
local function firestarterRemain(unit, pct)
    if not GetObjectExists(unit) then return -1 end
    if not string.find(unit,"0x") then unit = ObjectPointer(unit) end
    if getOptionCheck("Enhanced Time to Die") and getHP(unit) > pct and br.unitSetup.cache[unit] ~= nil then
        return br.unitSetup.cache[unit]:unitTtd(pct)
    end
    return -1
end

local function spellChecks(spell)
    --chesk if the spell is usable, i.e off CD or not casting. Unless using 
    --check if youre not moving
end

local function bool_to_number(value)
    return value == true and 1 or value == false and 0 or value == nil and 0
end

--------------------
--- Action Lists --- -- All Action List functions from SimC (or other rotation logic) here, some common ones provided
--------------------
-- Action List - Extra
actionList.Extra = function()

end -- End Action List - Extra

-- Action List - Defensive
actionList.Defensive = function()

end -- End Action List - Defensive

-- Action List - Interrrupt
actionList.Interrupt = function()

end -- End Action List - Interrupt

-- Action List - Cooldowns
actionList.Cooldown = function()

end -- End Action List - Cooldowns

-- Action List - precombat
actionList.precombat = function()

    -- # Executed before combat begins. Accepts non-harmful actions only.
    -- actions.precombat=flask

    -- actions.precombat+=/food

    -- actions.precombat+=/augmentation

    -- actions.precombat+=/arcane_intellect
  
    -- actions.precombat+=/mirror_image
    
    -- actions.precombat+=/pyroblast

end -- End Action List - precombat

-- Action List - active_talents
actionList.active_talents = function()

    -- actions.active_talents=living_bomb,if=active_enemies>1&buff.combustion.down&(variable.time_to_combustion>cooldown.living_bomb.duration|variable.time_to_combustion<=0|variable.disable_combustion)
    -- actions.active_talents+=/meteor,if=!variable.disable_combustion&variable.time_to_combustion<=0|(cooldown.meteor.duration<variable.time_to_combustion&!talent.rune_of_power)|talent.rune_of_power&buff.rune_of_power.up&variable.time_to_combustion>action.meteor.cooldown|fight_remains<variable.time_to_combustion|variable.disable_combustion
    -- actions.active_talents+=/dragons_breath,if=talent.alexstraszas_fury&(buff.combustion.down&!buff.hot_streak.react)

end -- End Action List - active_talents

-- Action List - combustion_cooldowns
actionList.combustion_cooldowns = function()

    -- actions.combustion_cooldowns=potion
    -- actions.combustion_cooldowns+=/blood_fury
    -- actions.combustion_cooldowns+=/berserking
    -- actions.combustion_cooldowns+=/fireblood
    -- actions.combustion_cooldowns+=/ancestral_call
    -- actions.combustion_cooldowns+=/use_items
    -- actions.combustion_cooldowns+=/use_item,use_off_gcd=1,effect_name=gladiators_badge,if=action.meteor.in_flight_remains<=0.5
    -- actions.combustion_cooldowns+=/time_warp,if=runeforge.temporal_warp&buff.exhaustion.up

end -- End Action List - combustion_cooldowns

-- Action List - combustion_phase
actionList.combustion_phase = function()

    -- actions.combustion_phase=lights_judgment,if=buff.combustion.down
    
    -- # Estimate how long Combustion will last thanks to Sun King's Blessing to determine how Fire Blasts should be used.
    -- actions.combustion_phase+=/variable,name=extended_combustion_remains,op=set,value=buff.combustion.remains+buff.combustion.duration*(cooldown.combustion.remains<buff.combustion.remains)
    
    -- # Adds the duration of the Sun King's Blessing Combustion to the end of the current Combustion if the cast would complete during this Combustion.
    -- actions.combustion_phase+=/variable,name=extended_combustion_remains,op=add,value=variable.skb_duration,if=buff.sun_kings_blessing_ready.up|variable.extended_combustion_remains>1.5*gcd.max*(buff.sun_kings_blessing.max_stack-buff.sun_kings_blessing.stack)
    -- actions.combustion_phase+=/bag_of_tricks,if=buff.combustion.down 
    -- actions.combustion_phase+=/living_bomb,if=active_enemies>1&buff.combustion.down
    if (cast.able.livingBomb() and not isUnitCasting("player")) and #enemies.yards10t > 1 and not buff.combust.exists() then
        if cast.livingBomb(units.dyn40) then ui.debug("Casting Living Bomb (Combust Phase)") return true end 
    end
    -- actions.combustion_phase+=/mirrors_of_torment,if=buff.combustion.down&buff.rune_of_power.down
    -- actions.combustion_phase+=/use_item,name=hyperthread_wristwraps,if=buff.combustion.up&action.fire_blast.charges=0&action.fire_blast.recharge_time>gcd.max
    -- actions.combustion_phase+=/blood_of_the_enemy
    -- actions.combustion_phase+=/memory_of_lucid_dreams
    -- actions.combustion_phase+=/worldvein_resonance
    
    -- # For Venthyr, use a Fire Blast charge during Mirrors of Torment cast to avoid capping charges if Infernal Cascade is not selected.
    -- actions.combustion_phase+=/fire_blast,use_while_casting=1,if=action.mirrors_of_torment.executing&full_recharge_time-action.mirrors_of_torment.execute_remains<4&!hot_streak_spells_in_flight&!buff.hot_streak.react&(buff.combustion.up|!conduit.infernal_cascade)
    print(bool_to_number(buff.heatingUp.react()) + hot_streak_spells_in_flight)
    -- # Without Infernal Cascade, just use Fire Blasts when they won't munch crits and when Firestorm is down.
    -- actions.combustion_phase+=/fire_blast,use_off_gcd=1,use_while_casting=1,if=!azerite.blaster_master.enabled&(active_enemies<=active_dot.ignite|!cooldown.phoenix_flames.ready)&!conduit.infernal_cascade&charges>=1&buff.combustion.up&!buff.firestorm.react&!buff.hot_streak.react&hot_streak_spells_in_flight+buff.heating_up.react<2
    if cast.able.fireBlast() and not traits.blasterMaster.active and (#enemies.yards10t <= debuff.ignite.count() or not cd.phoenixFlames.ready()) and not conduit.infernalCascade and charges.fireBlast.count() >=1 and buff.combustion.exists() and not buff.firestorm.react() and not buff.hotStreak.react() and hot_streak_spells_in_flight + bool_to_number(buff.heatingUp.react()) < 2 then --  did not implement 'hot_streak_spells_in_flight+buff.heating_up.react<2'
        if cast.fireBlast(units.dyn40) then ui.debug("Casting Fire Blast (Combust Phase)") return true end 
    end
    -- # With Infernal Cascade, Fire Blast use should be additionaly constrained so that it is not be used unless Infernal Cascade is about to expire or there are more than enough Fire Blasts to extend Infernal Cascade to the end of Combustion.
    -- actions.combustion_phase+=/fire_blast,use_off_gcd=1,use_while_casting=1,if=!azerite.blaster_master.enabled&(active_enemies<=active_dot.ignite|!cooldown.phoenix_flames.ready)&conduit.infernal_cascade&charges>=1&((action.fire_blast.charges_fractional+(variable.extended_combustion_remains-buff.infernal_cascade.duration)%cooldown.fire_blast.duration-variable.extended_combustion_remains%(buff.infernal_cascade.duration-gcd.max))>=0|variable.extended_combustion_remains<=buff.infernal_cascade.duration|buff.infernal_cascade.remains<gcd.max|cooldown.shifting_power.ready&active_enemies>=variable.combustion_shifting_power&covenant.night_fae)&buff.combustion.up&(!buff.firestorm.react|buff.infernal_cascade.remains<0.5)&!buff.hot_streak.react&hot_streak_spells_in_flight+buff.heating_up.react<2
    -- actions.combustion_phase+=/counterspell,if=runeforge.disciplinary_command&buff.disciplinary_command.down&buff.disciplinary_command_arcane.down&cooldown.buff_disciplinary_command.ready 
    -- actions.combustion_phase+=/arcane_explosion,if=runeforge.disciplinary_command&buff.disciplinary_command.down&buff.disciplinary_command_arcane.down&cooldown.buff_disciplinary_command.ready
    -- actions.combustion_phase+=/frostbolt,if=runeforge.disciplinary_command&buff.disciplinary_command.down&buff.disciplinary_command_frost.down
    
    -- actions.combustion_phase+=/call_action_list,name=active_talents
    
    -- actions.combustion_phase+=/combustion,use_off_gcd=1,use_while_casting=1,if=buff.combustion.down&(runeforge.disciplinary_command=buff.disciplinary_command.up)&(action.meteor.in_flight&action.meteor.in_flight_remains<=0.6|action.scorch.executing&action.scorch.execute_remains<0.6|action.fireball.executing&action.fireball.execute_remains<0.6|action.pyroblast.executing&action.pyroblast.execute_remains<0.6)
    if cast.able.combustion() and not buff.combustion.exists() and ((cast.inFlight.meteor() and cast.inFlightRemain.meteor() <= 0.6) or (cast.current.scorch() and cast.timeRemain() <= 0.6) or (cast.current.fireball() and cast.timeRemain() <= 0.6)  or (cast.current.pyroblast() and cast.timeRemain() < 0.6)) then
        if cast.combustion("player") then ui.debug("Casting Combustion (Combust Phase)") return true end 
    end
    -- # Other cooldowns that should be used with Combustion should only be used with an actual Combustion cast and not with a Sun King's Blessing proc.
    -- actions.combustion_phase+=/call_action_list,name=combustion_cooldowns,if=buff.combustion.last_expire<=action.combustion.last_used
    
    -- actions.combustion_phase+=/flamestrike,if=(buff.hot_streak.react|buff.firestorm.react)&active_enemies>=variable.combustion_flamestrike
    
    -- actions.combustion_phase+=/pyroblast,if=buff.sun_kings_blessing_ready.up&buff.sun_kings_blessing_ready.remains>cast_time
    -- actions.combustion_phase+=/pyroblast,if=buff.firestorm.react
    if (cast.able.pyroblast() and not isUnitCasting("player")) and buff.firestorm.react() then
        if cast.pyroblast(units.dyn40) then ui.debug("Casting Pyroblast 2 (Combust Phase)") return true end 
    end
    -- actions.combustion_phase+=/pyroblast,if=buff.pyroclasm.react&buff.pyroclasm.remains>cast_time&(buff.combustion.remains>cast_time|buff.combustion.down)&active_enemies<variable.combustion_flamestrike
    if (cast.able.pyroblast() and not isUnitCasting("player")) and buff.pyroclasm.react() and buff.pyroclasm.remains() > cast.time.pyroblast() and (buff.combustion.remains() > cast.time.pyroblast() or not buff.combustion.exists()) and #enemies.yards10t < var.combustion_flamestrike then
        if cast.pyroblast(units.dyn40) then ui.debug("Casting Pyroblast 3 (Combust Phase)") return true end 
    end
    -- actions.combustion_phase+=/pyroblast,if=buff.hot_streak.react&buff.combustion.up
    if (cast.able.pyroblast() and not isUnitCasting("player")) and buff.hotStreak.react() and buff.combustion.exists() then
        if cast.pyroblast(units.dyn40) then ui.debug("Casting Pyroblast 4 (Combust Phase)") return true end 
    end
    -- actions.combustion_phase+=/pyroblast,if=prev_gcd.1.scorch&buff.heating_up.react&active_enemies<variable.combustion_flamestrike
    if (cast.able.pyroblast() and not isUnitCasting("player")) and cast.last.scorch() and buff.heatingUp.react() and #enemies.yards10t < var.hot_streak_flamestrike then
        if cast.pyroblast(units.dyn40) then ui.debug("Casting Pyroblast 5 (Combust Phase)") return true end 
    end
    -- # Using Shifting Power during Combustion to restore Fire Blast and Phoenix Flame charges can be beneficial, but usually only on AoE.
    -- actions.combustion_phase+=/shifting_power,if=buff.combustion.up&!action.fire_blast.charges&active_enemies>=variable.combustion_shifting_power&action.phoenix_flames.full_recharge_time>full_reduction,interrupt_if=action.fire_blast.charges=action.fire_blast.max_charges
    if (cast.able.shiftingPower() and not isUnitCasting("player")) and buff.combustion.exists() and not charges.fireBlast.max() and #enemies.yards10t >= var.combustion_shifting_power and charges.phoenixFlames.timeTillFull() > 10 then
        if cast.shiftingPower(units.dyn40) then ui.debug("Casting Shifting Power (Combust Phase)") return true end 
    end
    -- actions.combustion_phase+=/phoenix_flames,if=buff.combustion.up&((action.fire_blast.charges<1&talent.pyroclasm&active_enemies=1)|!talent.pyroclasm|active_enemies>1)&buff.heating_up.react+hot_streak_spells_in_flight<2
    if cast.able.phoenixFlames() and buff.combustion.exists() and ((charges.fireBlast.count() < 1 and talent.pyroclasm and #enemies.yards10t == 1) or not talent.pyroclasm or #enemies.yards10t > 1) and bool_to_number(buff.heatingUp.react()) + hot_streak_spells_in_flight < 2 then 
        if cast.phoenixFlames("target") then ui.debug("Casting Phoenix Flames (Combust Phase)") return true end 
    end
    -- actions.combustion_phase+=/fireball,if=buff.combustion.down&cooldown.combustion.remains<cast_time&!conduit.flame_accretion&(debuff.mirrors_of_torment.down|!conduit.infernal_cascade)
    -- if cast.able.fireball() and not isUnitCasting("player" and not moving) and not buff.combustion.exists() and cd.combustion.remains() < cast.time.fireball() and not conduit.flameAccretion and (not debuff.mirrorsOfTorment.exists() or not conduit.infernalCascade) then
    --     if cast.fireball(units.dyn40) then ui.debug("Casting Fireball (Standard Rotation)") return true end 
    -- end
    -- actions.combustion_phase+=/scorch,if=buff.combustion.remains>cast_time&buff.combustion.up|buff.combustion.down&cooldown.combustion.remains<cast_time
    if (cast.able.scorch() and not isUnitCasting("player")) and buff.combustion.remains() > cast.time.scorch() and buff.combustion.exists() or not buff.combustion.exists() and cd.combustion.remains() < cast.time.scorch()  then
        if cast.scorch(units.dyn40) then ui.debug("Casting Scorch 1 (Combust Phase)") return true end 
    end
    -- actions.combustion_phase+=/living_bomb,if=buff.combustion.remains<gcd.max&active_enemies>1
    if (cast.able.livingBomb() and not isUnitCasting("player")) and buff.combust.remains() < gcdMax and #enemies.yards10t > 1 then
        if cast.livingBomb(units.dyn40) then ui.debug("Casting Living Bomb (Combust Phase)") return true end 
    end
    -- actions.combustion_phase+=/dragons_breath,if=buff.combustion.remains<gcd.max&buff.combustion.up
    -- actions.combustion_phase+=/scorch,if=target.health.pct<=30&talent.searing_touch
    if (cast.able.scorch() and not isUnitCasting("player")) and thp <= 30 and talent.searingTouch then
        if cast.scorch(units.dyn40) then ui.debug("Casting Scorch 2 (Combust Phase)") return true end 
    end
end -- End Action List - combustion_phase

-- Action List - rop_phase
actionList.rop_phase = function()

    -- actions.rop_phase=flamestrike,if=active_enemies>=variable.hot_streak_flamestrike&(buff.hot_streak.react|buff.firestorm.react)
    -- actions.rop_phase+=/pyroblast,if=buff.sun_kings_blessing_ready.up&buff.sun_kings_blessing_ready.remains>cast_time
    -- actions.rop_phase+=/pyroblast,if=buff.firestorm.react
    -- actions.rop_phase+=/pyroblast,if=buff.hot_streak.react
    -- # Use one Fire Blast early in RoP if you don't have either Heating Up or Hot Streak yet and either: (a) have more than two already, (b) have Alexstrasza's Fury ready to use, or (c) Searing Touch is active. Don't do this while hard casting Flametrikes or when Sun King's Blessing is ready.
    -- actions.rop_phase+=/fire_blast,use_off_gcd=1,use_while_casting=1,if=!variable.fire_blast_pooling&buff.sun_kings_blessing_ready.down&active_enemies<variable.hard_cast_flamestrike&!firestarter.active&(!buff.heating_up.react&!buff.hot_streak.react&!prev_off_gcd.fire_blast&(action.fire_blast.charges>=2|(talent.alexstraszas_fury&cooldown.dragons_breath.ready)|(talent.searing_touch&target.health.pct<=30)))
    -- # Use Fire Blast either during a Fireball/Pyroblast cast when Heating Up is active or during execute with Searing Touch.
    -- actions.rop_phase+=/fire_blast,use_off_gcd=1,use_while_casting=1,if=!variable.fire_blast_pooling&!firestarter.active&(((action.fireball.executing&(action.fireball.execute_remains<0.5|!runeforge.firestorm)|action.pyroblast.executing&(action.pyroblast.execute_remains<0.5|!runeforge.firestorm))&buff.heating_up.react)|(talent.searing_touch&target.health.pct<=30&(buff.heating_up.react&!action.scorch.executing|!buff.hot_streak.react&!buff.heating_up.react&action.scorch.executing&!hot_streak_spells_in_flight)))
    -- actions.rop_phase+=/call_action_list,name=active_talents
    -- actions.rop_phase+=/pyroblast,if=buff.pyroclasm.react&cast_time<buff.pyroclasm.remains&cast_time<buff.rune_of_power.remains
    -- actions.rop_phase+=/pyroblast,if=prev_gcd.1.scorch&buff.heating_up.react&talent.searing_touch&target.health.pct<=30&active_enemies<variable.hot_streak_flamestrike
    -- actions.rop_phase+=/phoenix_flames,if=!variable.phoenix_pooling&buff.heating_up.react&!buff.hot_streak.react&(active_dot.ignite<2|active_enemies>=variable.hard_cast_flamestrike|active_enemies>=variable.hot_streak_flamestrike)
    -- actions.rop_phase+=/scorch,if=target.health.pct<=30&talent.searing_touch
    -- actions.rop_phase+=/dragons_breath,if=active_enemies>2
    -- actions.rop_phase+=/arcane_explosion,if=active_enemies>=variable.arcane_explosion&mana.pct>=variable.arcane_explosion_mana
    -- actions.rop_phase+=/flamestrike,if=active_enemies>=variable.hard_cast_flamestrike
    -- actions.rop_phase+=/fireball

end -- End Action List - rop_phase

-- Action List - standard_rotation
actionList.standard_rotation = function()
    -- actions.standard_rotation=flamestrike,if=active_enemies>=variable.hot_streak_flamestrike&(buff.hot_streak.react|buff.firestorm.react)
    -- if cast.able.flamestrike() and #enemies.yards10t >= var.hot_streak_flamestrike and (buff.hotStreak.react() or buff.firestorm.react()) then
    --     if createCastFunction("best", false, 1, 8, spell.flamestrike, nil, true) then
    --         SpellStopTargeting()
    --         return true 
    --     end
    -- end
    -- actions.standard_rotation+=/pyroblast,if=buff.firestorm.react
    if (cast.able.pyroblast() and not isUnitCasting("player")) and buff.firestorm.react() then
        if cast.pyroblast(units.dyn40) then ui.debug("Casting Pyroblast 1 (Standard Rotation)") return true end 
    end
    -- actions.standard_rotation+=/pyroblast,if=buff.hot_streak.react&buff.hot_streak.remains<action.fireball.execute_time
    if (cast.able.pyroblast() and not isUnitCasting("player")) and buff.hotStreak.react() and buff.hotStreak.remains() < cast.time.fireball() then
        if cast.pyroblast(units.dyn40) then ui.debug("Casting Pyroblast 2 (Standard Rotation)") return true end 
    end
    -- actions.standard_rotation+=/pyroblast,if=buff.hot_streak.react&(prev_gcd.1.fireball|firestarter.active|action.pyroblast.in_flight)
    if (cast.able.pyroblast() and not isUnitCasting("player")) and buff.hotStreak.react() and (cast.last.fireball() or firestarterActive or cast.inFlight.pyroblast()) then
        if cast.pyroblast(units.dyn40) then ui.debug("Casting Pyroblast 3 (Standard Rotation)") return true end 
    end
    -- # Try to get SKB procs inside RoP phases or Combustion phases when possible.
    -- actions.standard_rotation+=/pyroblast,if=buff.sun_kings_blessing_ready.up&(cooldown.rune_of_power.remains+action.rune_of_power.execute_time+cast_time>buff.sun_kings_blessing_ready.remains|!talent.rune_of_power)&variable.time_to_combustion+cast_time>buff.sun_kings_blessing_ready.remains
    
    -- actions.standard_rotation+=/pyroblast,if=buff.hot_streak.react&target.health.pct<=30&talent.searing_touch
    if (cast.able.pyroblast() and not isUnitCasting("player")) and buff.hotStreak.react() and thp <= 30 and talent.searingTouch then
        if cast.pyroblast(units.dyn40) then ui.debug("Casting Pyroblast 5 (Standard Rotation)") return true end 
    end
    -- actions.standard_rotation+=/pyroblast,if=buff.pyroclasm.react&cast_time<buff.pyroclasm.remains
    if (cast.able.pyroblast() and not isUnitCasting("player") and not moving) and buff.pyroclasm.react() and cast.time.pyroblast() < buff.pyroclasm.remains() then
        if cast.pyroblast(units.dyn40) then ui.debug("Casting Pyroblast 6 (Standard Rotation)") return true end 
    end
    -- # During the standard rotation, only use Fire Blasts when they are not being pooled for RoP or Combustion. Use Fire Blast either during a Fireball/Pyroblast cast when Heating Up is active or during execute with Searing Touch.
    -- actions.standard_rotation+=/fire_blast,use_off_gcd=1,use_while_casting=1,if=!firestarter.active&!variable.fire_blast_pooling&(((action.fireball.executing&(action.fireball.execute_remains<0.5|!runeforge.firestorm)|action.pyroblast.executing&(action.pyroblast.execute_remains<0.5|!runeforge.firestorm))&buff.heating_up.react)|(talent.searing_touch&target.health.pct<=30&(buff.heating_up.react&!action.scorch.executing|!buff.hot_streak.react&!buff.heating_up.react&action.scorch.executing&!hot_streak_spells_in_flight)))
    if cast.able.fireBlast() and not firestarterActive and not var.fire_blast_pooling and (((cast.current.fireball() and (cast.timeRemain() < 0.5 or not runeforge.firestorm) or cast.current.pyroblast() and (cast.timeRemain() < 0.5 or not runeforge.firestorm)) and buff.heatingUp.react()) or (talent.searingTouch and thp <= 30 and (buff.heatingUp.react() and not cast.current.scorch() or not buff.hotStreak.react() and not buff.heatingUp.react() and cast.current.scorch() and not hot_streak_spells_in_flight))) then
        if cast.fireBlast(units.dyn40) then ui.debug("Casting Fire Blast (Standard Rotation)") return true end 
    end
    -- actions.standard_rotation+=/pyroblast,if=prev_gcd.1.scorch&buff.heating_up.react&talent.searing_touch&target.health.pct<=30&active_enemies<variable.hot_streak_flamestrike
    if (cast.able.pyroblast() and not isUnitCasting("player")) and cast.last.scorch() and buff.heatingUp.react() and talent.searingTouch and thp <= 30 and #enemies.yards10t < var.hot_streak_flamestrike then
        if cast.pyroblast(units.dyn40) then ui.debug("Casting Pyroblast 7 (Standard Rotation)") return true end 
    end
    -- actions.standard_rotation+=/phoenix_flames,if=!variable.phoenix_pooling&(!talent.from_the_ashes|active_enemies>1)&(active_dot.ignite<2|active_enemies>=variable.hard_cast_flamestrike|active_enemies>=variable.hot_streak_flamestrike)
    if (cast.able.phoenixFlames() and not isUnitCasting("player")) and not var.phoenix_pooling and ( not talent.fromTheAshes or #enemies.yards10t > 1) and (debuff.ignite.count() <2 or #enemies.yards10t > var.hard_cast_flamestrike or #enemies.yards10t >= var.hot_streak_flamestrike) then
        if cast.phoenixFlames(units.dyn40) then ui.debug("Casting Phoenix Flames (Standard Rotation)") return true end 
    end
    -- actions.standard_rotation+=/call_action_list,name=active_talents
    -- actions.standard_rotation+=/dragons_breath,if=active_enemies>1
    -- actions.standard_rotation+=/scorch,if=target.health.pct<=30&talent.searing_touch
    if (cast.able.scorch() and not isUnitCasting("player")) and thp <=30 and talent.searingTouch then
        if cast.scorch(units.dyn40) then ui.debug("Casting Scorch (Standard Rotation)") return true end 
    end
    -- # With enough targets, it is a gain to cast Flamestrike as filler instead of Fireball.
    -- actions.standard_rotation+=/arcane_explosion,if=active_enemies>=variable.arcane_explosion&mana.pct>=variable.arcane_explosion_mana
    if (cast.able.arcaneExplosion() and not isUnitCasting("player")) and #enemies.yards10t >= var.arcane_explosion and power >= var.arcane_explosion_mana then
        if cast.arcaneExplosion(units.dyn40) then ui.debug("Casting Arcane Explosion (Standard Rotation)") return true end 
    end
    -- actions.standard_rotation+=/flamestrike,if=active_enemies>=variable.hard_cast_flamestrike
    if (cast.able.flamestrike() and not isUnitCasting("player")) and #enemies.yards10t >= var.hard_cast_flamestrike then
        if cast.flamestrike(units.dyn40) then ui.debug("Casting Flamestrike (Standard Rotation)") return true end 
    end
    -- actions.standard_rotation+=/fireball
    if cast.able.fireball() and not isUnitCasting("player") and not moving then
        if cast.fireball(units.dyn40) then ui.debug("Casting Fireball (Standard Rotation)") return true end 
    end

end -- End Action List - standard_rotation

----------------
--- ROTATION ---
----------------
local function runRotation()
    UpdateToggle("Rotation",0.25)
    UpdateToggle("Cooldown",0.25)
    UpdateToggle("Defensive",0.25)
    UpdateToggle("Interrupt",0.25)
    UpdateToggle("Combustion",0.25)
    --------------
    --- Locals ---
    --------------
    buff                                          = br.player.buff
    cast                                          = br.player.cast
    combatTime                                    = getCombatTime()
    cd                                            = br.player.cd
    charges                                       = br.player.charges
    --conduit                                       = br.player.conduit
    deadtar, attacktar, hastar, playertar         = deadtar or UnitIsDeadOrGhost("target"), attacktar or UnitCanAttack("target", "player"), hastar or GetObjectExists("target"), UnitIsPlayer("target")
    debuff                                        = br.player.debuff
    enemies                                       = br.player.enemies
    equiped                                       = br.player.equiped
    essence                                       = br.player.essence
    falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
    gcd                                           = br.player.gcd
    gcdMax                                        = br.player.gcdMax
    inCombat                                      = br.player.inCombat
    inInstance                                    = br.player.instance=="party"
    inRaid                                        = br.player.instance=="raid"
    item                                          = br.player.items
    mode                                          = br.player.ui.mode    
    php                                           = br.player.health
    power, powmax, powgen, powerDeficit           = br.player.power.mana.amount(), br.player.power.mana.max(), br.player.power.mana.regen(), br.player.power.mana.deficit()
    pullTimer                                     = br.DBM:getPulltimer()
    racial                                        = br.player.getRacial()
    solo                                          = #br.friend == 1
    spell                                         = br.player.spell
    talent                                        = br.player.talent
    traits                                        = br.player.traits
    thp                                           = getHP("target")
    unit                                          = br.player.unit
    units                                         = br.player.units
    ui                                            = br.player.ui
    use                                           = br.player.use
    var                                           = br.player.variables

    units.get(6)
    units.get(8)
    units.get(10)
    units.get(30)
    units.get(40)
    enemies.get(8)
    enemies.get(10, "player", true)
    enemies.get(30)
    enemies.get(40)
    enemies.get(6,"target")
    enemies.get(8,"target")
    enemies.get(10,"target")
    enemies.get(30,"target")
    enemies.get(40,"target")

    if #enemies.yards6t > 0 then fSEnemies = #enemies.yards6t else fSEnemies = #enemies.yards40 end
    dBEnemies = getEnemies(units.dyn12, 6, true)
    firestarterActive = talent.firestarter and thp > 90
    firestarterInactive = thp < 90 or isDummy()

    shifting_power_full_reduction = 10
    

    hot_streak_spells_in_flight = bool_to_number(cast.last.scorch()) + bool_to_number(cast.inFlight.fireball()) + bool_to_number(cast.inFlight.pyroblast()) + bool_to_number(cast.last.phoenixFlames()) + bool_to_number(cast.last.fireBlast()) + bool_to_number(cast.last.fireBlast2())


    -- # If set to a non-zero value, the Combustion action and cooldowns that are constrained to only be used when Combustion is up will not be used during the simulation.
    -- actions.precombat+=/variable,name=disable_combustion,op=reset
    var.disable_combustion = false

    -- # This variable specifies the number of targets at which Hot Streak Flamestrikes outside of Combustion should be used.
    -- actions.precombat+=/variable,name=hot_streak_flamestrike,op=set,if=variable.hot_streak_flamestrike=0,value=2*talent.flame_patch+3*!talent.flame_patch
    --var.hot_streak_flamestrike = 5
    if talent.flamePatch then var.hot_streak_flamestrike = 2 * 1 + 99 * 0 elseif not talent.flamePatch then var.hot_streak_flamestrike =  2 * 0 + 99 * 1 end

    -- # This variable specifies the number of targets at which Hard Cast Flamestrikes outside of Combustion should be used as filler.
    -- actions.precombat+=/variable,name=hard_cast_flamestrike,op=set,if=variable.hard_cast_flamestrike=0,value=2*talent.flame_patch+3*!talent.flame_patch
    --var.hard_cast_flamestrike = 5
    if talent.flamePatch then var.hard_cast_flamestrike = 3 * 1 + 99 * 0 elseif not talent.flamePatch then var.hard_cast_flamestrike =  3 * 0 + 99 * 1 end

    -- # This variable specifies the number of targets at which Hot Streak Flamestrikes are used during Combustion.
    -- actions.precombat+=/variable,name=combustion_flamestrike,op=set,if=variable.combustion_flamestrike=0,value=3*talent.flame_patch+6*!talent.flame_patch
    var.combustion_flamestrike = 5

    -- # This variable specifies the number of targets at which Arcane Explosion outside of Combustion should be used.
    -- actions.precombat+=/variable,name=arcane_explosion,op=set,if=variable.arcane_explosion=0,value=99*talent.flame_patch+2*!talent.flame_patch
    var.arcane_explosion = 5

    -- # This variable specifies the percentage of mana below which Arcane Explosion will not be used.
    -- actions.precombat+=/variable,name=arcane_explosion_mana,default=40,op=reset
    var.arcane_explosion_mana = 40

    -- # With Kindling, Combustion's cooldown will be reduced by a random amount, but the number of crits starts very high after activating Combustion and slows down towards the end of Combustion's cooldown. When making decisions in the APL, Combustion's remaining cooldown is reduced by this fraction to account for Kindling.
    -- actions.precombat+=/variable,name=kindling_reduction,default=0.4,op=reset
    var.kindling_reduction = 0.4

    -- # The duration of a Sun King's Blessing Combustion.
    -- actions.precombat+=/variable,name=skb_duration,op=set,value=dbc.effect.828420.base_value
    var.skb_duration = 0

    -- actions.precombat+=/variable,name=combustion_on_use,op=set,value=equipped.macabre_sheet_music|equipped.manifesto_of_madness|equipped.gladiators_badge|equipped.gladiators_medallion|equipped.ignition_mages_fuse|equipped.tzanes_barkspines|equipped.azurethos_singed_plumage|equipped.ancient_knot_of_wisdom|equipped.shockbiters_fang|equipped.neural_synapse_enhancer|equipped.balefire_branch
    var.combustion_on_use = false

    -- actions.precombat+=/variable,name=on_use_cutoff,op=set,value=20*variable.combustion_on_use+5*equipped.macabre_sheet_music
    var.on_use_cutoff = 0

    -- actions+=/variable,name=time_to_combustion,op=set,value=talent.firestarter*firestarter.remains+(cooldown.combustion.remains*(1-variable.kindling_reduction*talent.kindling))*!cooldown.combustion.ready*buff.combustion.down
    var.time_to_combustion = bool_to_number(talent.firestarter) * firestarterRemain(units.dyn40, 90) + (cd.combustion.remains() * (1 - var.kindling_reduction * bool_to_number(talent.kindling))) * bool_to_number((not cd.combustion.ready())) * bool_to_number((not buff.combustion.exists()))
    -- # Make sure Combustion is delayed if needed based on the empyreal_ordnance_delay variable
    -- actions+=/variable,name=time_to_combustion,op=max,value=variable.empyreal_ordnance_delay-(cooldown.empyreal_ordnance.duration-cooldown.empyreal_ordnance.remains)*!cooldown.empyreal_ordnance.ready,if=equipped.empyreal_ordnance
    
    -- actions+=/variable,name=time_to_combustion,op=max,value=cooldown.gladiators_badge.remains,if=equipped.gladiators_badge
    
    -- actions+=/variable,name=time_to_combustion,op=max,value=buff.rune_of_power.remains,if=talent.rune_of_power&buff.combustion.down
    
    -- actions+=/variable,name=time_to_combustion,op=max,value=cooldown.rune_of_power.remains+buff.rune_of_power.duration,if=talent.rune_of_power&buff.combustion.down&cooldown.rune_of_power.remains+5<variable.time_to_combustion
           
    -- actions+=/variable,name=fire_blast_pooling,value=!variable.disable_combustion&variable.time_to_combustion<action.fire_blast.full_recharge_time-action.shifting_power.full_reduction*(cooldown.shifting_power.remains<variable.time_to_combustion)&variable.time_to_combustion<fight_remains|talent.rune_of_power&buff.rune_of_power.down&cooldown.rune_of_power.remains<action.fire_blast.full_recharge_time-action.shifting_power.full_reduction*(cooldown.shifting_power.remains<cooldown.rune_of_power.remains)&cooldown.rune_of_power.remains<fight_remains
    var.fire_blast_pooling = not var.disable_combustion and var.time_to_combustion < charges.fireBlast.timeTillFull() - shifting_power_full_reduction * bool_to_number(cd.shiftingPower.remains() < var.time_to_combustion) and var.time_to_combustion < unit.ttd(units.dyn40) or talent.runeOfPower and not buff.runeOfPower.exists() and cd.runeOfPower.remains() < charges.fireBlast.timeTillFull() - shifting_power_full_reduction * bool_to_number(cd.shiftingPower.remains() < cd.runeOfPower.remains()) and cd.runeOfPower.remains() < unit.ttd(units.dyn40)
    
    -- actions+=/variable,name=phoenix_pooling,value=!variable.disable_combustion&variable.time_to_combustion<action.phoenix_flames.full_recharge_time-action.shifting_power.full_reduction*(cooldown.shifting_power.remains<variable.time_to_combustion)&variable.time_to_combustion<fight_remains|runeforge.sun_kings_blessing
    var.phoenix_pooling = not var.disable_combustion and var.time_to_combustion < charges.phoenixFlames.timeTillFull() - shifting_power_full_reduction * bool_to_number(cd.shiftingPower.remains() < var.time_to_combustion) and var.time_to_combustion < unit.ttd(units.dyn40) or runeforge.sunKingsBlessing   

    -- todo: remove later
    runeforge.firestorm = false
    runeforge.sunKingsBlessing = false
    conduit.infernalCascade = false


    ---------------------
    --- Begin Profile ---
    ---------------------
    -- Profile Stop | Pause
    if not inCombat and not hastar and profileStop then
        profileStop = false
    elseif haltProfile then
        return true
    else
        ---------------------------------
        --- Out Of Combat - Rotations ---
        ---------------------------------
        -----------------------
        --- Extras Rotation ---
        -----------------------
        if actionList.Extra() then return true end
        -----------------
        --- Defensive ---
        -----------------
        if actionList.Defensive() then return true end
        ------------------
        --- Pre-Combat ---
        ------------------
        if actionList.precombat() then return true end
        -----------------------------
        --- In Combat - Rotations ---
        -----------------------------
        if inCombat and isValidUnit("target") and cd.global.remain() == 0 then
            ------------------------------
            --- In Combat - Interrupts ---
            ------------------------------
            if actionList.Interrupt() then return true end
            ---------------------------
            --- SimulationCraft APL ---
            ---------------------------
            if getOptionValue("APL Mode") == 1 then
                -- Start Attack

                
                -- actions+=/shifting_power,if=buff.combustion.down&variable.time_to_combustion>full_reduction&(cooldown.rune_of_power.remains>full_reduction|!talent.rune_of_power)
                -- actions+=/radiant_spark,if=(buff.combustion.down&buff.rune_of_power.down&(variable.time_to_combustion<execute_time|variable.time_to_combustion>cooldown.radiant_spark.duration))|(buff.rune_of_power.up&variable.time_to_combustion>30)
                -- actions+=/deathborne,if=buff.combustion.down&buff.rune_of_power.down&variable.time_to_combustion<execute_time
                -- actions+=/mirror_image,if=buff.combustion.down&debuff.radiant_spark_vulnerability.down
                
                -- actions+=/use_item,effect_name=gladiators_badge,if=variable.time_to_combustion>cooldown-5
                -- actions+=/use_item,name=empyreal_ordnance,if=variable.time_to_combustion<=variable.empyreal_ordnance_delay
                -- actions+=/use_item,name=soul_igniter,if=variable.time_to_combustion>=variable.on_use_cutoff
                -- actions+=/use_item,name=glyph_of_assimilation,if=variable.time_to_combustion>=variable.on_use_cutoff
                -- actions+=/use_item,name=macabre_sheet_music,if=variable.time_to_combustion<=5
                -- actions+=/use_item,name=dreadfire_vessel,if=variable.time_to_combustion>=variable.on_use_cutoff
                -- actions+=/use_item,name=azsharas_font_of_power,if=variable.time_to_combustion<=5+15*variable.font_double_on_use&variable.time_to_combustion>0&!variable.disable_combustion
                -- actions+=/guardian_of_azeroth,if=(variable.time_to_combustion<10|fight_remains<variable.time_to_combustion)&!variable.disable_combustion
                -- actions+=/concentrated_flame
                -- actions+=/reaping_flames
                -- actions+=/focused_azerite_beam
                -- actions+=/purifying_blast
                -- actions+=/ripple_in_space
                -- actions+=/the_unbound_force
                
                -- # Get the disciplinary_command buff up, unless combustion is soon.
                -- actions+=/counterspell,if=runeforge.disciplinary_command&cooldown.buff_disciplinary_command.ready&buff.disciplinary_command_arcane.down&variable.time_to_combustion>30&!buff.disciplinary_command.up
                -- actions+=/arcane_explosion,if=runeforge.disciplinary_command&cooldown.buff_disciplinary_command.ready&buff.disciplinary_command_arcane.down&variable.time_to_combustion>30&!buff.disciplinary_command.up
                -- actions+=/frostbolt,if=runeforge.disciplinary_command&cooldown.buff_disciplinary_command.ready&buff.disciplinary_command_frost.down&variable.time_to_combustion>30&!buff.disciplinary_command.up
                
                -- actions+=/call_action_list,name=combustion_phase,if=!variable.disable_combustion&variable.time_to_combustion<=0
                if not var.disable_combustion and var.time_to_combustion <=0 then
                    if actionList.combustion_phase() then return true end
                end    
                -- actions+=/rune_of_power,if=buff.rune_of_power.down&!buff.firestorm.react&(variable.time_to_combustion>=buff.rune_of_power.duration&variable.time_to_combustion>action.fire_blast.full_recharge_time|variable.time_to_combustion>fight_remains|variable.disable_combustion)
                
                -- actions+=/call_action_list,name=rop_phase,if=buff.rune_of_power.up&(variable.time_to_combustion>0|variable.disable_combustion)
                
                -- # When Hardcasting Flame Strike, Fire Blasts should be used to generate Hot Streaks and to extend Blaster Master.
                -- actions+=/fire_blast,use_off_gcd=1,use_while_casting=1,if=!variable.fire_blast_pooling&(variable.time_to_combustion>0|variable.disable_combustion)&active_enemies>=variable.hard_cast_flamestrike&!firestarter.active&!buff.hot_streak.react&(buff.heating_up.react&action.flamestrike.execute_remains<0.5|charges_fractional>=2)
                
                -- # During Firestarter, Fire Blasts are used similarly to during Combustion. Generally, they are used to generate Hot Streaks when crits will not be wasted and with Blaster Master, they should be spread out to maintain the Blaster Master buff.
                -- actions+=/fire_blast,use_off_gcd=1,use_while_casting=1,if=firestarter.active&charges>=1&!variable.fire_blast_pooling&(!action.fireball.executing&!action.pyroblast.in_flight&buff.heating_up.react|action.fireball.executing&!buff.hot_streak.react|action.pyroblast.in_flight&buff.heating_up.react&!buff.hot_streak.react)
                
                -- # Avoid capping Fire Blast charges while channeling Shifting Power
                -- actions+=/fire_blast,use_while_casting=1,if=action.shifting_power.executing&full_recharge_time<action.shifting_power.tick_reduction&buff.hot_streak.down
                
                -- actions+=/call_action_list,name=standard_rotation,if=(variable.time_to_combustion>0|variable.disable_combustion)&buff.rune_of_power.down
                if actionList.standard_rotation() then return true end
                -- actions+=/scorch
                if cast.able.scorch() and not isUnitCasting("player") then
                    if cast.scorch(units.dyn40) then ui.debug("Casting Scorch") return true end 
                end

            end -- End SimC APL
        end -- End In Combat Rotation
    end -- Pause
    return true
end -- End runRotation
local id = 63
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})