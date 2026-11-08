-- chat message interpretation

local _, addonData = ...
local L = LibStub("AceLocale-3.0"):GetLocale("SteaSummonForever")
local gossip = addonData.gossip
local debug = addonData.debug
local settings = addonData.settings
local summon = addonData.summon
local raid = addonData.raid

local chat = {
  init = function(_)
    debug:registerCategory("chat")
  end,

  callback = function (_, event, msg, servername, ...)
    local me = addonData.util:playerFullName()

    if SteaDEBUG and SteaDEBUG.diag then -- record raw chat author formats
      SteaDEBUG.diag.authors[event] = servername
    end

    -- don't want randos adding themselves
    local player, server = strsplit("-", servername)
    if event == "CHAT_MSG_SAY" and player ~= me then
      return
    end
    -- modern clients send authors as Name-Realm even on the home realm;
    -- keep the full name only for genuinely foreign realms so comparisons
    -- against UnitName("player") and roster names still match
    local _, myrealm = UnitFullName("player")
    if server and server ~= "" and server ~= myrealm then
        player = servername
    end

    db("chat", "testing chat for keywords")

    if player == me then
      if msg and msg:find("!SS") == 1 then
        local _, cmd, args = strsplit(" ", msg)
        if cmd == nil then cmd = "list" end
        if args == nil then args = "" end
        cmd = string.lower(cmd)

        db("chat","Received command : " .. cmd .. " " .. args)
        if cmd == L["list"] then
          local waitlist = summon:getWaiting()
          cprint(L["Summon waiting list"])
          count = 0

          for _,waiting in pairs(waitlist) do
            local pats = {["%%name"] = waiting[1], ["%%number"] = waiting[2]}
            local s = L["%name waiting: %number seconds"]
            s = tstring(s, pats)
            cprint(s)
            count = count + 1
          end

          local pats = {["%%count"] = count}
          local s = L["%count waiting"]
          s = tstring(s, pats)
          cprint(s)

        end

        if cmd == L["debug"] then
          if args == L["on"] then settings:debug(true)
          elseif args == L["off"] then settings:debug(false)
          else settings:debug(not settings:debug())
          end

          local offon = L["off"]
          if settings:debug() then offon = L["on"] end
          cprint("Debugging: ", offon)
        end

        if cmd == L["add"] then
          -- add someone to list
          if args ~= "" then
            gossip:add(args, true )
          end
        end
      end
    end

    if msg then
      if string.sub(msg, 1,1) == "-" and settings:findSummonWord(string.sub(msg, 2)) then
        name, server = strsplit("-", servername)
        gossip:arrived(name, true)
      elseif settings:findSummonWord(msg) then
        -- someone wants a summon
        name, server = strsplit("-", servername)
        db("chat","adding ", name, "to summon list")

        -- IsInGroup takes a category constant, not a player: classic clients
        -- ignored the bad argument (truthy), modern clients return false.
        -- What we actually want: is the requester in my group?
        if UnitInParty(player) or UnitInRaid(player) or (player == me and settings:debug()) then
          gossip:add(player, event == "CHAT_MSG_WHISPER" )
        end
      elseif event == "CHAT_MSG_WHISPER" then
        if raid:isInvTrigger(msg) then
          raid:whisperedTrigger(player)
        else
          addonData.alt:whispered(player, msg)
        end
      end
    end
  end,

  raid = function(self, msg, player)
    if IsInRaid() then
      self:sendChat(msg, "RAID", "RAID", player)
    else
      self:sendChat(msg, "PARTY", "PARTY", player)
    end
  end,

  say = function(self, msg, player)
    self:sendChat(msg, "SAY", "SAY", player)
  end,

  whisper = function(self, msg, player)
    self:sendChat(msg, "WHISPER", player, player)
  end,

  sendChat = function(_, msg, channel, channel2, to)
    db("chat", "sendChat ", msg, " ", channel, " ", to)
    if msg ~= nil and msg ~= "" then
      -- substitute variables in message
      local trigphrase = SteaSummonSave.summonWords[1]
      if trigphrase == nil then
        trigphrase = ""
      end

      local patterns = {["%%p"] = to,
                        ["%%l"] = GetMinimapZoneText(),
                        ["%%z"] = GetZoneText(),
                        ["%%t"] = trigphrase
      }
      msg = tstring(msg, patterns)
      msg = "[SteaSummon] " .. msg
      -- argument 3 is the language id: classic clients tolerated a channel
      -- name there, modern clients validate the number. nil = default
      -- language; the target only applies to whispers
      SendChatMessage(msg, channel, nil, channel == "WHISPER" and to or nil)
    end
  end
}

addonData.chat = chat
