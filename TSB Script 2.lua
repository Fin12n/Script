local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("LHUB", "Synapse")
local Tab = Window:NewTab("AutoTP")
---------------------------------------------------
local Section = Tab:NewSection("Select Player")
---------------------------------------------------
plr = {}
for i,v in pairs(workspace.Live:GetChildren()) do
    table.insert(plr,v.Name)
end
local dropplayer = Section:NewDropdown("Sel Player", "DropdownInf", plr, function(tplr)
    tp = tplr
end)
Section:NewButton("Refresh Players", "Refreshes Dropdown", function()
    dropplayer:Refresh(plr)
  end)
Section:NewToggle("TP", "ToggleInfo", function(state)
    if state then
        pcall(function()
        _G.AutoTP = true
        while _G.AutoTP do wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[tp].Character.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
        end
    end)
    else
        _G.AutoTP = false
    end
end)

-----------------------------------------------------
local Section = Tab:NewSection("AutoFIGHT")

Section:NewToggle("AUTOHIT", "ToggleInfo", function(state)
    if state then
        pcall(function()
        _G.AutoTP = true
        while _G.AutoTP do wait()
            local args = {
                [1] = {
                    ["Goal"] = "LeftClick"
                }
            }
            
            game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args))
        end
    end)
    else
        _G.AutoTP = false
    end
end)
-----------------------------------------------------
Section:NewToggle("AUTOSKILL", "ToggleInfo", function(state)
    if state then
        _G.AutoTP = true
        while _G.AutoTP do wait()
            -- Script generated by SimpleSpy - credits to exx#9394

local args = {
    [1] = {
        ["Goal"] = "KeyRelease",
        ["Key"] = Enum.KeyCode.One
    }
}

game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args))
-- Script generated by SimpleSpy - credits to exx#9394
wait(1)
local args = {
    [1] = {
        ["Goal"] = "KeyPress",
        ["Key"] = Enum.KeyCode.Two
    }
}

game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args))
-- Script generated by SimpleSpy - credits to exx#9394
wait(1)
local args = {
    [1] = {
        ["Goal"] = "KeyPress",
        ["Key"] = Enum.KeyCode.Three
    }
}

game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args))
-- Script generated by SimpleSpy - credits to exx#9394
wait(1)
local args = {
    [1] = {
        ["Goal"] = "KeyPress",
        ["Key"] = Enum.KeyCode.Four
    }
}

game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args))
        end
    else
        _G.AutoTP = false
    end
end)

