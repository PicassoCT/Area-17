local armLeft = piece('armLeft');
local armRight = piece('armRight');
local footLeft = piece('footLeft');
local footRIght = piece('footRIght');
local handLeft = piece('handLeft');
local handRight = piece('handRight');
local head = piece('head');
local legLeft = piece('legLeft');
local legRight = piece('legRight');
local thighLeft = piece('thighLeft');
local thighRight = piece('thighRight');
local torso = piece('torso');

local Animations = {};

local scriptEnv = {
	armLeft = armLeft,
	armRight = armRight,
	footLeft = footLeft,
	footRIght = footRIght,
	handLeft = handLeft,
	handRight = handRight,
	head = head,
	legLeft = legLeft,
	legRight = legRight,
	thighLeft = thighLeft,
	thighRight = thighRight,
	torso = torso,
	x_axis = x_axis,
	y_axis = y_axis,
	z_axis = z_axis,
}

Animations['stop'] = VFS.Include("Scripts/animations/human_stop.lua", scriptEnv);
Animations['walk'] = VFS.Include("Scripts/animations/human_walk.lua", scriptEnv);

local SIG_WALK = tonumber("00001",2);

function constructSkeleton(unit, piece, offset)
    if (offset == nil) then
        offset = {0,0,0};
    end

    local bones = {};
    local info = Spring.GetUnitPieceInfo(unit,piece);

    for i=1,3 do
        info.offset[i] = offset[i]+info.offset[i];
    end 

    bones[piece] = info.offset;
    local map = Spring.GetUnitPieceMap(unit);
    local children = info.children;

    if (children) then
        for i, childName in pairs(children) do
            local childId = map[childName];
            local childBones = constructSkeleton(unit, childId, info.offset);
            for cid, cinfo in pairs(childBones) do
                bones[cid] = cinfo;
            end
        end
    end        
    return bones;
end

function script.Create()
    local map = Spring.GetUnitPieceMap(unitID);
    local offsets = constructSkeleton(unitID,map.Scene, {0,0,0});
    
    for a,anim in pairs(Animations) do
        for i,keyframe in pairs(anim) do
            local commands = keyframe.commands;
            for k,command in pairs(commands) do
                -- commands are described in (c)ommand,(p)iece,(a)xis,(t)arget,(s)peed format
                -- the t attribute needs to be adjusted for move commands from blender's absolute values
                if (command.c == "move") then
                    local adjusted =  command.t - (offsets[command.p][command.a]);
                    Animations[a][i]['commands'][k].t = command.t - (offsets[command.p][command.a]);
                end
            end
        end
    end
    PlayAnimation('stop');
end
            
local animCmd = {['turn']=Turn,['move']=Move};
function PlayAnimation(animname)
    local anim = Animations[animname];
    for i = 1, #anim do
        local commands = anim[i].commands;
        for j = 1,#commands do
            local cmd = commands[j];
            animCmd[cmd.c](cmd.p,cmd.a,cmd.t,cmd.s);
        end
        if(i < #anim) then
            local t = anim[i+1]['time'] - anim[i]['time'];
            Sleep(t*33); -- sleep works on milliseconds
        end
    end
end

local function Walk()
	Signal(SIG_WALK)
	SetSignalMask(SIG_WALK)
	PlayAnimation("walk", true);
	while true do
		PlayAnimation("walk", false);
	end
end

local function Stop()
	Signal(SIG_WALK)
	SetSignalMask(SIG_WALK)
	PlayAnimation("stop",true)
end

function script.StartMoving()
	Signal(SIG_WALK);
	StartThread(Walk);
end

function script.StopMoving()
	Signal(SIG_WALK);
	StartThread(Stop);
end

function script.Killed(recentDamage, maxHealth)
	return 0
end