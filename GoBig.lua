-- Make your character bigger or smaller, by Shalzuth --

canIncrease = true 
canDecrease = true 
size = 1
function OnLoad()
	print("<font color = '#00FFFF' >Go Big by Shalzuth</font>")
    Menu = scriptConfig('GoBig', 'Go Big')
    Menu:addParam('Increase', 'Increase Size', SCRIPT_PARAM_ONKEYDOWN, false, 0x6B)
    Menu:addParam('Decrease', 'Decrease Size', SCRIPT_PARAM_ONKEYDOWN, false, 0x6D)
end
function OnTick()
    if Menu.Increase then
        if canIncrease then
            canIncrease = false
            size = size + 0.1
            ChangeSize(size, _G.Packet.lastSequenceNumber + 1)
        end
    else
        canIncrease = true
    end
    if Menu.Decrease then
        if canDecrease then
            canDecrease = false
            size = size - 0.1
            ChangeSize(size, _G.Packet.lastSequenceNumber + 1)
        end
    else
        canDecrease = true
    end
end
function ChangeSize(size, seqNum)
    p = CLoLPacket(0xC3)
    p:Encode4(0)
    p:Encode4(seqNum)
    p:Encode1(0x1)
    p:Encode1(0x8)
    p:EncodeF(myHero.networkID)
    p:Encode4(0x800)
    p:Encode1(0x4)
    p:EncodeF(size)
    p.dwArg1 = 0
    p.dwArg2 = 0
    RecvPacket(p)
end