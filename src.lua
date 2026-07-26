local ezlib = {}

local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")

function ezlib:NewWindow(winName)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 1000000
    ScreenGui.Parent = gethui and gethui() or game:GetService("CoreGui")

    local Frame = Instance.new("Frame")
    Frame.Position = UDim2.new(0.3754863739013672, 0, 0.2808988690376282, 0)
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.Size = UDim2.new(0, 384, 0, 351)
    Frame.BorderSizePixel = 0
    Frame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Frame.Parent = ScreenGui

    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TopBar.Size = UDim2.new(0, 384, 0, 36)
    TopBar.BorderSizePixel = 0
    TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TopBar.Parent = Frame

    do
        local dragging, dragStart, startPos
        TopBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = Frame.Position
            end
        end)
        uis.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        uis.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
    end

    local header = Instance.new("TextLabel")
    header.TextWrapped = true
    header.Name = "header"
    header.TextColor3 = Color3.fromRGB(255, 255, 255)
    header.BorderColor3 = Color3.fromRGB(0, 0, 0)
    header.Text = "EzUI"
    header.Size = UDim2.new(0, 204, 0, 15)
    header.Position = UDim2.new(0.035999998450279236, 0, 0.5, 0)
    header.AnchorPoint = Vector2.new(0, 0.5)
    header.BorderSizePixel = 0
    header.BackgroundTransparency = 1
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.TextScaled = true
    header.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    header.TextSize = 14
    header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    header.Parent = TopBar

    local Tabs = Instance.new("Frame")
    Tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Tabs.Name = "Tabs"
    Tabs.BackgroundTransparency = 0.5
    Tabs.Position = UDim2.new(0.0338541679084301, 0, 0.14245013892650604, 0)
    Tabs.SelectionGroup = true
    Tabs.Size = UDim2.new(0, 122, 0, 287)
    Tabs.BorderSizePixel = 0
    Tabs.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Tabs.Parent = Frame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = Tabs

    local Sections = Instance.new("Frame")
    Sections.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Sections.AnchorPoint = Vector2.new(1, 0)
    Sections.Name = "Sections"
    Sections.BackgroundTransparency = 0.5
    Sections.Position = UDim2.new(0.9659999012947083, 0, 0.14200003445148468, 0)
    Sections.SelectionGroup = true
    Sections.Size = UDim2.new(0, 225, 0, 287)
    Sections.BorderSizePixel = 0
    Sections.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Sections.Parent = Frame

    local tabz = {}
    local curTab = nil

    function tabz:NewTab(tabName)
        local TabElement = Instance.new("ImageButton")
        TabElement.ImageColor3 = Color3.fromRGB(24, 24, 24)
        TabElement.Name = tabName
        TabElement.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabElement.Size = UDim2.new(0, 122, 0, 38)
        TabElement.BorderSizePixel = 0
        TabElement.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        TabElement.Parent = Tabs

        local Togged = Instance.new("Frame")
        Togged.Name = "Togged"
        Togged.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Togged.Size = UDim2.new(0, 4, 0, 38)
        Togged.BorderSizePixel = 0
        Togged.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Togged.Parent = TabElement
        Togged.Visible = false

        local Title = Instance.new("TextLabel")
        Title.TextWrapped = true
        Title.Name = "Title"
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Title.Text = tabName
        Title.Size = UDim2.new(0, 97, 0, 15)
        Title.Position = UDim2.new(0.12616416811943054, 0, 0.5, 0)
        Title.AnchorPoint = Vector2.new(0, 0.5)
        Title.BorderSizePixel = 0
        Title.BackgroundTransparency = 1
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.TextScaled = true
        Title.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        Title.TextSize = 14
        Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Title.Parent = TabElement

        local SectionElement = Instance.new("ScrollingFrame")
        SectionElement.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
        SectionElement.Active = true
        SectionElement.AutomaticCanvasSize = Enum.AutomaticSize.Y
        SectionElement.ScrollBarThickness = 0
        SectionElement.Name = tabName
        SectionElement.Size = UDim2.new(0, 225, 0, 287)
        SectionElement.BackgroundTransparency = 1
        SectionElement.Position = UDim2.new(0, 0, 3.1899907071419875e-07, 0)
        SectionElement.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SectionElement.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SectionElement.BorderSizePixel = 0
        SectionElement.CanvasSize = UDim2.new(0, 0, 0, 0)
        SectionElement.Parent = Sections

        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Parent = SectionElement

        TabElement.MouseButton1Click:Connect(function()
            if curTab then
                Tabs[curTab].Togged.Visible = false
                Sections[curTab].Visible = false
            end

            SectionElement.Visible = true
            Togged.Visible = true

            curTab = tabName
        end)

        local elementz = {}

        function elementz:Label(txt)
            local LabelElement = Instance.new("Frame")
            LabelElement.BackgroundTransparency = 1
            LabelElement.Name = "LabelElement"
            LabelElement.BorderColor3 = Color3.fromRGB(0, 0, 0)
            LabelElement.Size = UDim2.new(0, 225, 0, 26)
            LabelElement.BorderSizePixel = 0
            LabelElement.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelElement.Parent = SectionElement

            local lbl = Instance.new("TextLabel")
            lbl.TextWrapped = true
            lbl.Name = "lbl"
            lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            lbl.BorderColor3 = Color3.fromRGB(0, 0, 0)
            lbl.Text = txt
            lbl.Size = UDim2.new(0, 107, 0, 15)
            lbl.Position = UDim2.new(0.08171983808279037, 0, 0.5, 0)
            lbl.AnchorPoint = Vector2.new(0, 0.5)
            lbl.BorderSizePixel = 0
            lbl.BackgroundTransparency = 1
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.TextScaled = true
            lbl.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            lbl.TextSize = 14
            lbl.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            lbl.Parent = LabelElement
        end

        function elementz:Button(txt, cb)
            local ButtonElement = Instance.new("ImageButton")
            ButtonElement.ImageColor3 = Color3.fromRGB(24, 24, 24)
            ButtonElement.Name = "ButtonElement"
            ButtonElement.Position = UDim2.new(0, 0, 0.09059233218431473, 0)
            ButtonElement.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ButtonElement.Size = UDim2.new(0, 225, 0, 38)
            ButtonElement.BorderSizePixel = 0
            ButtonElement.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            ButtonElement.Parent = SectionElement

            local lbl = Instance.new("TextLabel")
            lbl.TextWrapped = true
            lbl.Name = "lbl"
            lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            lbl.BorderColor3 = Color3.fromRGB(0, 0, 0)
            lbl.Text = txt
            lbl.Size = UDim2.new(0, 151, 0, 15)
            lbl.Position = UDim2.new(0.055053167045116425, 0, 0.5, 0)
            lbl.AnchorPoint = Vector2.new(0, 0.5)
            lbl.BorderSizePixel = 0
            lbl.BackgroundTransparency = 1
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.TextScaled = true
            lbl.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            lbl.TextSize = 14
            lbl.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            lbl.Parent = ButtonElement

            ButtonElement.MouseButton1Click:Connect(function()
                cb()
            end)
        end

        function elementz:Toggle(txt, cb)
            local ToggleElement = Instance.new("ImageButton")
            ToggleElement.ImageColor3 = Color3.fromRGB(24, 24, 24)
            ToggleElement.Name = "ToggleElement"
            ToggleElement.Position = UDim2.new(0, 0, 0.09059233218431473, 0)
            ToggleElement.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ToggleElement.Size = UDim2.new(0, 225, 0, 38)
            ToggleElement.BorderSizePixel = 0
            ToggleElement.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            ToggleElement.Parent = SectionElement

            local lbl = Instance.new("TextLabel")
            lbl.TextWrapped = true
            lbl.Name = "lbl"
            lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            lbl.BorderColor3 = Color3.fromRGB(0, 0, 0)
            lbl.Text = txt
            lbl.Size = UDim2.new(0, 151, 0, 15)
            lbl.Position = UDim2.new(0.055053167045116425, 0, 0.5, 0)
            lbl.AnchorPoint = Vector2.new(0, 0.5)
            lbl.BorderSizePixel = 0
            lbl.BackgroundTransparency = 1
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.TextScaled = true
            lbl.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            lbl.TextSize = 14
            lbl.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            lbl.Parent = ToggleElement

            local istog = Instance.new("Frame")
            istog.AnchorPoint = Vector2.new(0.5, 0.5)
            istog.Name = "istog"
            istog.Position = UDim2.new(0.9290000200271606, 0, 0.5, 0)
            istog.BorderColor3 = Color3.fromRGB(0, 0, 0)
            istog.Size = UDim2.new(0, 12, 0, 12)
            istog.BorderSizePixel = 0
            istog.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            istog.Parent = ToggleElement

            local tog = false

            ToggleElement.MouseButton1Click:Connect(function()
                tog = not tog
                istog.BackgroundColor3 = tog and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255,0,0)
                cb(tog)
            end)
        end

        return elementz
    end

    return tabz
end

return ezlib
