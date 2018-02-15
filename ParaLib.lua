--[[
-ParacraftLibary-
Many useful lib:Vector,Blocks,etc.
by Hyt
]]--
ParaLib = {SBlockList = {}};
ParaLib.__index = ParaLib;
function main(entity)
    script = blocks.getscript(19200,1,19200);
    script.ParaLib = ParaLib;
    cmd("/tip -color #0000ff 【ParaLib】 已载入");
end

--VectorLib
Vector = {x = 0, y = 0, z = 0,
    __add = function(v1,v2)
        local result = NewVector(0,0,0);
        result.x = v1.x + v2.x;
        result.y = v1.y + v2.y;
        result.z = v1.z + v2.z;
        return result;
    end,
    __sub = function(v1,v2)
        local result = NewVector(0,0,0);
        result.x = v1.x - v2.x;
        result.y = v1.y - v2.y;
        result.z = v1.z - v2.z;
        return result;
    end
}
Vector.__index = Vector;
function Vector:Multiply(num)
    self.x  = self.x * num;
    self.y  = self.y * num;
    self.z  = self.z * num;
end

--turn the vector into string
function Vector:ToString()
    return self.x.." "..self.y.." "..self.z;
end
--turn the vectot into parm
function Vector:ToParm()
    return self.x, self.y, self.z;
end
--Newvector
function ParaLib:NewVector(x,y,z)
    local result = {};
    setmetatable(result,Vector);
    result.x = x;
    result.y = y;
    result.z = z;
    return result;
end

--set a group of block
function ParaLib:SetBlocks(pos,range,id,data,flag)
    for i = pos.x, pos.x + range.rx do
        for j = pos.y, pos.y + range.ry do
            for k = pos.z, pos.z + range.rz do
                BlockEngine.SetBlock(i,j,k,id,data,flag);
            end
        end
    end
end

SBlock = {Position = {0, 0, 0}, Id = 0, Data = 0};
SBlock.__index = SBlock;
--create a smart block
function ParaLib:CreateSBlock(x,y,z)
    local newBlock = {__index = SBlock};
    --初始化一堆信息
    newBlock.Position = ParaLib.NewVector(x,y,z);
    --注册到表里
    table.insert( ParaLib.SBlockList,newBlock);
    return newBlock;
end

--获取Id
function SBlock:GetId()
    return BlockEngine:GetBlockId(self.Position:ToParm());
end

--获取Data
function SBlock:GetData()
    return BlockEngine:GetBlockData(self.Position:ToParm());
end

--Move a Block relatively
function SBlock:SimpleMoveRelative(x,y,z,newData)
    cmd("/translate ~ ~ ~ to "..ParaLib:NewVector(x,y,z):ToString());
    self.Position = self.Position + NewVector(x,y,z);
    if not newData then
        BlockEngine:SetBlockData(self.Position:ToParm(),newData,0);
    end
end

--Move a Block absolately
function SBlock:SimpleMoveAbsolate(x,y,z,newData)
    self:SimpleMoveRelative(ParaLib:NewVector( x,y,z) - self.Position,newData);
end

SBlockGroup = {};
SBlockGroup.__index = SBlockGroup;
--Move all SBlock in the group
function SBlockGroup:SimpleMoveGroupRelative(to)

end