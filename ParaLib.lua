--[[
-ParacraftLibary-
Many useful lib:Vector,Blocks,etc.
by Hyt
]]--
ParaLib = {};
function main(entity)
    local script = blocks.getscript(19200,1,19200);
    script.ParaLib = ParaLib;
    ParaLib.SetBlocks = SetBlocks;
    ParaLib.Translate = Translate;
    cmd("/tip -notice -color #0000cc 【ParaLib】已载入");
end

--Set a box of blocks
function SetBlocks(x, y, z, rx, ry, rz, id, data, flag)
    id = id or 0;
    data = data or 0;
    flag = flag or 0;
    for i = x, x + rx do
        for j = y, y + ry do
            for k = z, z + rz do 
                BlockEngine:SetBlock(i, j, k, id, data, flag);
            end
        end
    end
end

--Translate (a box of) block(s)
function Translate(x, y, z, rx, ry, rz, tx, ty, tz)
    DoBlocks(x, y, z, rx, ry, rz,
        function(x,y,z,tx,ty,tz)
            cmd("/translate "..x.." "..y.." "..z.." to "..tx.." "..ty.." "..tz);
        end,
        tx,ty,tz);
end

--Do (a box of) block(s)
--parm1~3: some extra parameter.
function DoBlocks(x, y, z, rx, ry, rz, command, parm1, parm2, parm3)
    for i = x, x + rx do
        for j = y, y + ry do
            for k = z, z + rz do 
                command(i, j, k, parm1, parm2, parm3);
            end
        end
    end
end