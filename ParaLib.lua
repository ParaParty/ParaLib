--[[
-ParacraftLibary-
Many useful lib:Vector,Blocks,etc.
by Hyt
]]--
ParaLib = {};
function main(entity)
    script = blocks.getscript(19200,1,19200);
    script.ParaLib = ParaLib;
end

--get a vector
function ParaLib:getVector(x,y,z)
    local result = {};
    result.x = x;
    result.y = y;
    result.z = z;
    return result;
end

--set a group of block
function ParaLib:setBlocks(pos,range,id,data,flag)
    for i = pos.x, pos.x+range.rx do
        for j = pos.y, pos.y+range.ry do
            for k = pos.z, pos.z+range.rz do
                BlockEngine.SetBlock(i,j,k,id,data,flag);
            end
        end
    end
end

SBlock = {position = {}};--to check
--create a smart block
function ParaLib:createSBlock(x,y,z)
    local newBlock ={};
    setmetatable(newBlock, SBlock);
    newBlock.position = ParaLib.getVector(x,y,z);
end

--移动
function SBlock:Translate(x,y,z)
    
end