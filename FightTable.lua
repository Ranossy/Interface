--ս�����ܺ����������ǵ�ǰ���ڹ�ID






--�����衢MT



s_tFightFunc = {}
s_tFightFunc[10224] = {}		--�����
s_tFightFunc[10081] = {}		--���ľ�
s_tFightFunc[10003] = {}		--�׽
s_tFightFunc[10021] = {}		--������		
s_tFightFunc[10242] = {}		--��Ӱ
s_tFightFunc[10243] = {}		--����	
s_tFightFunc[10389] = {}		--������	
s_tFightFunc[10390] = {}		--��ɽ
s_tFightFunc[10464] = {}		--�Ե�
s_tFightFunc[10447] = {}		--Ī��
s_tFightFunc[10448] = {}		--��֪		
s_tFightFunc[10175] = {}		--����		
s_tFightFunc[10026] = {}		--��Ѫս��		
s_tFightFunc[10014] = {}		--��ϼ��		
s_tFightFunc[10015] = {}		--̫�齣��		
s_tFightFunc[10225] = {}		--���޹��
s_tFightFunc[10145] = {}		--ɽ�ӽ���		
s_tFightFunc[10144] = {}		--��ˮ��		
s_tFightFunc[10268] = {}		--Ц����	


--�Ե�
s_tFightFunc[10464][1] = function()
	local player = GetClientPlayer()
	if not player then return end

	local target, targetClass = s_util.GetTarget(player)
	if not target then return end

	local MyBuff = s_util.GetBuffInfo(player)

		if s_util.CastSkill(16169, false) then return end
	if s_util.CastSkill(16621, false) then return end
	if s_util.CastSkill(16085, false) then return end
		if s_util.CastSkill(16027, false) then return end
end
--�Ե��ߵ���
s_tFightFunc[10464][2] = function()
	--��ȡ�Լ���Player����û�еĻ�˵����û������Ϸ��ֱ�ӷ���
	local player = GetClientPlayer()
	if not player then return end

	--�����ǰ���ɲ��ǰԵ������������Ϣ
	if player.dwForceID ~= FORCE_TYPE.BA_DAO then
		s_util.OutputTip("��ǰ���ɲ��ǰԵ���������޷���ȷ���С�", 1)
		return
	end

	--��ǰѪ����ֵ
	local myhp = player.nCurrentLife / player.nMaxLife

	--��ȡ��ǰĿ��,δ��սûĿ��ֱ�ӷ���,ս����ûĿ��ѡ������ж�NPC,��������
	local target, targetClass = s_util.GetTarget(player)							
	if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then return end
	if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
		local MinDistance = 20		--��С����
		local MindwID = 0		    --���NPC��ID
		for i,v in ipairs(GetAllNpc()) do		--��������NPC
			if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nLevel>0 then  --����ǵжԣ����Ҿ����С
				MinDistance = s_util.GetDistance(v, player)                             
				MindwID = v.dwID                                                                  --�滻�����ID
			end
		end
		if MindwID == 0 then 
			return --û�еж�NPC�򷵻�
		else	
			SetTarget(TARGET.NPC, MindwID)  --�趨Ŀ��Ϊ����ĵж�NPC                
		end
	end
	if target then s_util.TurnTo(target.nX,target.nY) end

	--���Ŀ��������ֱ�ӷ���
	if target.nMoveState == MOVE_STATE.ON_DEATH then return end

	--��ȡ�Լ���buff��
	local MyBuff = s_util.GetBuffInfo(player)

	--��ȡĿ���buff��
	local TargetBuff = s_util.GetBuffInfo(target)
	local mTargetBuff = s_util.GetBuffInfo(target,true)

	--��ȡ�Լ���Ŀ��ľ���
	local dis = s_util.GetDistance(player, target)
	--��ȡ������Ϣ
	local warnmsg = s_util.GetWarnMsg()

	--DPSҰ�˹��ϻ�����
	local laohu=s_util.GetNpc(36688,40)
	if laohu then SetTarget(TARGET.NPC, laohu.dwID) s_util.TurnTo(laohu.nX,laohu.nY) end

	--����������Χ׷��
	if dis > 3.5 then
	s_util.TurnTo(target.nX, target.nY) MoveForwardStart()
	else
	MoveForwardStop() s_util.TurnTo(target.nX, target.nY)
	end

	--�ر���BOSS��������
	local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)		--���� �Ƿ��ڶ���, ����ID���ȼ���ʣ��ʱ��(��)����������
	if dwSkillId == 9241 and nLeftTime > 0.5 then if s_util.CastSkill(9007,false,true) then return end end        --�������

	--�ر���BOSS���ߴ���
	if TargetBuff[7929] then if s_util.UseItem(5,21534) then return end end

	--�ر�����Ȧ�ش̴���
	local xianjing = 0		--��������
	for i,v in ipairs(GetAllNpc()) do		--��������NPC
		if  v.dwTemplateID==36780 and s_util.GetDistance(v, player) < 3.5 then  --3.5�����л�Ȧ
			xianjing = 1                                                                
		end
		if  v.dwTemplateID==36774 and s_util.GetDistance(v, player) < 3.5 then  --3.5�����еش�
			xianjing = 1                                                                
		end
	end
	if xianjing ==1 then
		s_util.TurnTo(target.nX, target.nY) StrafeLeftStart()
	else
		StrafeLeftStop() s_util.TurnTo(target.nX, target.nY) 
	end

	--DPS OT��ҡ
	if target.dwTemplateID==36680 and s_util.GetTarget(target).dwID== player.dwID then
		s_util.CastSkill(9002,false,true)
		if(MyBuff[208]) then Jump() end
		return
	end
		
	--��Ŀ�����������
	if (not TargetBuff[11447] or TargetBuff[11447].dwSkillSrcID ~= player.dwID) and s_util.GetSkillCD(17057) <= 0 then		--���Ŀ��û��������buff���߲����ҵģ���������ȴ
		if player.nPoseState ~= POSE_TYPE.DOUBLE_BLADE then		--�����������������̬
			s_util.CastSkill(16166, false)						--ʩ����������
			return
		end
		s_util.CastSkill(17057,false)							--�ͷ� ������
		return
	end


	--�����������������̬
	if player.nPoseState == POSE_TYPE.DOUBLE_BLADE then
		if s_util.GetSkillCD(16621) <= 0 and player.nCurrentSunEnergy >= 10  then					--��������Ұ��ȴ�ˣ��������ڵ���10
			s_util.CastSkill(16169, false)						--ʩ��ѩ������
		end
		--if player.nCurrentRage > 25 and dis < 6 then
		--	s_util.CastSkill(16168, false)						--ʩ����������
		--end
		--����3��+����
		if s_util.CastSkill(16870,false) then return end
		if MyBuff[11156] then 
			if s_util.CastSkill(34,false) then return end
		end
		if s_util.CastSkill(16871,false) then return end
		if s_util.CastSkill(16872,false) then return end
		if  MyBuff[11156] and MyBuff[11156].nStackNum > 1 and player.nCurrentRage > 28 then
			s_util.CastSkill(16168, false)						--ʩ����������
		end
	end


	--���������������̬
	if player.nPoseState == POSE_TYPE.BROADSWORD then
		if MyBuff[11322] and MyBuff[11322].nLeftTime < 0.7 then s_util.CastSkill(18976,false,true) end
		if dis > 8 then  s_util.CastSkill(16166, false) return end --�е�׷��
		--���ȷż����Ұ
		if s_util.GetSkillCD(16621) <= 0 and player.nCurrentSunEnergy >= 10 then					--��������Ұ��ȴ�ˣ��������ڵ���10
			--�л���ѩ��������̬
			s_util.CastSkill(16169, false,true)
			return
		end
		if player.nCurrentRage < 5 then  s_util.CastSkill(16166, false,true) return end --û���е�

		--���߷���
		if s_util.CastSkill(16629, false) then return end

			--�Ͻ���ӡ 7��
		if s_util.CastSkill(19344, false) then return end

		if player.nCurrentSunEnergy > 20 then s_util.CastSkill(16169, false) return end

		--�Ƹ����� cw��Ч���Դ�
		--if MyBuff[xxx] then
		--	if s_util.CastSkill(16602, false) then return end
		--end

		--��������321��
		if s_util.CastSkill(17079, false) then return end
		if s_util.CastSkill(17078, false) then return end
		if s_util.CastSkill(16601, false) then return end
	end


	--�����ѩ��������̬ 
	if player.nPoseState == POSE_TYPE.SHEATH_KNIFE then
		--����ѩ��������̬������������
		if player.nCurrentSunEnergy < 5 then				--�������С��5��
			s_util.CastSkill(16166, false)					--ʩ����������
			return
		end

		--�����Ұ
		if s_util.CastSkill(16621, false,true) then return end


		--�е���������
		if s_util.GetSkillCD(19344) <= 0 then		--
			s_util.CastSkill(16168, false,true)			--ʩ����������
			return
		end

		--��Х����
		if s_util.CastSkill(16027,false) then return end	--ʩ�ŵ�Х����
		--��ն����
		if s_util.CastSkill(16085, false) then return end
	end
end
--�Ե�ն�׺�
s_tFightFunc[10464][3] = function()
	--��ʼ��
	if not g_MacroVars.State_16027 then
		g_MacroVars.State_16027 = 0				--��Х����3�α�־
		g_MacroVars.State_11334 = 0				--����buff��־
	end

	--��ȡ�Լ���Player����û�еĻ�˵����û������Ϸ��ֱ�ӷ���
	local player = GetClientPlayer()
	if not player then return end

	--Alt��ǿ�Ʒ���
	if IsAltKeyDown() then return end

	--�����ǰ���ɲ��ǰԵ������������Ϣ
	if player.dwForceID ~= FORCE_TYPE.BA_DAO then
		s_util.OutputTip(target.nX)
		return
	end

	--��ǰѪ����ֵ
	local hpRatio = player.nCurrentLife / player.nMaxLife

	--��ȡ��ǰĿ��,δ��սûĿ��ֱ�ӷ���,ս����ûĿ��ѡ������ж�NPC,��������
	local target, targetClass = s_util.GetTarget(player)							
	if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then return end
	if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
		local MinDistance = 20		--��С����
		local MindwID = 0		    --���NPC��ID
		for i,v in ipairs(GetAllNpc()) do		--��������NPC
			if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nMaxLife>1000 then  --����ǵжԣ����Ҿ����С
				MinDistance = s_util.GetDistance(v, player)                             
				MindwID = v.dwID                                                                  --�滻�����ID
			end
		end
		if MindwID == 0 then 
			return --û�еж�NPC�򷵻�
		else	
			SetTarget(TARGET.NPC, MindwID)  --�趨Ŀ��Ϊ����ĵж�NPC                
		end
	end
	if target then s_util.TurnTo(target.nX,target.nY) end

	--���Ŀ��������ֱ�ӷ���
	if target.nMoveState == MOVE_STATE.ON_DEATH then return end

	--��ȡ�Լ���buff��
	local MyBuff = s_util.GetBuffInfo(player)

	--��ȡĿ���buff��
	local TargetBuff = s_util.GetBuffInfo(target)

	--��ȡ�Լ���Ŀ��ľ���
	local distance = s_util.GetDistance(player, target)

	if distance > 3.5 then
	s_util.TurnTo(target.nX, target.nY) MoveForwardStart()
	else
	MoveForwardStop() s_util.TurnTo(target.nX, target.nY)
	end

	--�ر���BOSS��������
	local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)		--���� �Ƿ��ڶ���, ����ID���ȼ���ʣ��ʱ��(��)����������
	if dwSkillId == 9241 and nLeftTime > 0.5 then if s_util.CastSkill(9007,false,true) then return end end        --�������

	--�ر���BOSS���ߴ���
	if TargetBuffAll[7929] then if s_util.UseItem(5,21534) then return end end

	--��Ŀ�����������
	if (not TargetBuff[11447] or TargetBuff[11447].dwSkillSrcID ~= player.dwID) and s_util.GetSkillCD(17057) <= 0 then		--���Ŀ��û��������buff���߲����ҵģ���������ȴ
		if player.nPoseState ~= POSE_TYPE.DOUBLE_BLADE then		--�����������������̬
			s_util.CastSkill(16166, false)						--ʩ����������
			return
		end
		s_util.CastSkill(17057,false)							--�ͷ� ������
		return
	end

	--�����������������̬
	if player.nPoseState == POSE_TYPE.DOUBLE_BLADE then
		--�����������ѩ����������������������
		if MyBuff[11456]  then 
			s_util.CastSkill(16169, false)						--ʩ��ѩ������
			g_MacroVars.State_16027 = 0							--����̬�����õ�x3��־Ϊ0
		else
			s_util.CastSkill(16168, false)						--ʩ����������
		end
		return
	end

	--���������������̬
	if player.nPoseState == POSE_TYPE.BROADSWORD then
		--���ȷż����Ұ
		if s_util.GetSkillCD(16621) <= 0 and player.nCurrentSunEnergy >= 10 then					--��������Ұ��ȴ�ˣ��������ڵ���10
			--��������
			if target.nMaxLife > 300000 then
				if s_util.CastSkill(16454, false) then return end
			end
			--�л���ѩ��������̬
			s_util.CastSkill(16169, false)
			g_MacroVars.State_16027 = 0
			return
		end

		--���߷���
		if s_util.CastSkill(16629, false) then return end

		--�Ƹ�����
		--if s_util.CastSkill(16602, false) then return end

		--�Ͻ���ӡ �н�ֱ
		if s_util.CastSkill(16627, false) then return end

		--��������321��
		if s_util.CastSkill(17079, false) then return end
		if s_util.CastSkill(17078, false) then return end
		if s_util.CastSkill(16601, false) then return end
	end

	--�����ѩ��������̬  ��� + �� + ��x3 + ��
	if player.nPoseState == POSE_TYPE.SHEATH_KNIFE then
		--����ѩ��������̬��������������һ�������������ﵽ�����ǻ���Ҫ���Ǹ����������
		if player.nCurrentSunEnergy < 5 then				--�������С��5��
			s_util.CastSkill(16168, false)					--ʩ����������
			return
		end

		--�����Ұ
		if s_util.CastSkill(16621, false) then return end

		--��������ε�Х����������buff��ûͬ��������
		local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(player)		--��ȡ�ҵĶ�������
		if dwSkillId == 16027 and nLeftTime < 0.5 and MyBuff[11334] and MyBuff[11334].nStackNum == 2 then			--����ڶ�����Х������ʣ��ʱ��С��0.5��, ������2�㺬��
			g_MacroVars.State_11334 = 1				--���ú���buff��־Ϊ1���͵����Ѿ���3�㺬����
		end

		--���÷Ź����ε�Х��־
		if MyBuff[11334] and MyBuff[11334].nStackNum > 2 then		--����к��磬���Һ����������2
			g_MacroVars.State_16027 = 1							--����״̬����Ϊ1����ʾ�Ѿ��ù����ε�Х
		end

		--��ն����
		if g_MacroVars.State_11334 == 1 or not MyBuff[11334] or MyBuff[11334].nStackNum > 2 then  	--�Ź�3�ε�Х������û�к��磬���ߺ����������2
			if s_util.CastSkill(16085, false) then				--ʩ����ն����
				g_MacroVars.State_11334 = 0
				return
			end
		end

		--�е���������
		if s_util.GetSkillCD(16085) > 0 and g_MacroVars.State_16027 == 1 then		--�����ն������CD�������ù����ε�Х
			s_util.CastSkill(16168, false)					--ʩ����������
			return
		end

		--��Х����
		if not MyBuff[11334] or MyBuff[11334].nStackNum < 3 then		--û�к���buff�����ߺ������С��3
			s_util.CastSkill(16027,false)								--ʩ�ŵ�Х����
		end
	end
end


--���� ��Ӱ
s_tFightFunc[10242][1] = function()
	--��ȡ�Լ���Ҷ���
	local player = GetClientPlayer()
	if not player then return end
	
	--��ȡĿ�����
	local target, targetClass = s_util.GetTarget(player)
	if not target then return end
	--��ȡ�Լ���Ŀ��ľ���
	local distance = s_util.GetDistance(player, target)
	--��ȡ�Լ���buff��
	local MyBuff = s_util.GetBuffInfo(player)
    if s_util.CastSkill(3960, false) then return end
	
	if s_util.CastSkill(3962, false) then return end
	if s_util.CastSkill(3963, false) then return end
	if s_util.CastSkill(3967, false) then return end
	if s_util.CastSkill(3959, false) then return end
	if s_util.CastSkill(3979, false) then return end
end

s_tFightFunc[10242][2] = function()
		
	--��ͷ������������Ȼ�ȡ�Լ��Ķ���û�еĻ�˵����û������Ϸ��ֱ�ӷ���
	local player = GetClientPlayer()
	if not player then return end

	--Alt��ǿ�Ʒ���
	if IsAltKeyDown() then return end
	--��ǰѪ����ֵ
	local hpRatio = player.nCurrentLife / player.nMaxLife

	--��ȡ��ǰĿ��,δ��սûĿ��ֱ�ӷ���,ս����ûĿ��ѡ������ж�NPC,��������
	local target, targetClass = s_util.GetTarget(player)							
	if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then return end 
	if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
	local MinDistance = 20			--��С����
	local MindwID = 0		    --���NPC��ID
	for i,v in ipairs(GetAllNpc()) do		--��������NPC
		if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nLevel>0 then	--����ǵжԣ����Ҿ����С
			MinDistance = s_util.GetDistance(v, player)                             
			MindwID = v.dwID                                                                    --�滻�����ID
			end
		end
	if MindwID == 0 then 
		return --û�еж�NPC�򷵻�
	else	
		SetTarget(TARGET.NPC, MindwID)  --�趨Ŀ��Ϊ����ĵж�NPC                
	end
	end
	if target then s_util.TurnTo(target.nX,target.nY) end  --��������

	--���Ŀ��������ֱ�ӷ���
	if target.nMoveState == MOVE_STATE.ON_DEATH then return end

	--�ж�Ŀ�����������û�������������ж϶����ļ���ID����Ӧ����(��ϡ�ӭ����ˡ�����ȵ�)
	local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)		--���� �Ƿ��ڶ���, ����ID���ȼ���ʣ��ʱ��(��)����������

	--��ȡ�Լ��Ķ�������
	local bPrepareMe, dwSkillIdMe, dwLevelMe, nLeftTimeMe, nActionStateMe =  GetSkillOTActionState(player)	

	--��ȡ�Լ���buff��
	local MyBuff = s_util.GetBuffInfo(player)

	--��ȡ�Լ���Ŀ����ɵ�buff��
	local TargetBuff = s_util.GetBuffInfo(target, true)

	--��ȡĿ��ȫ����buff��
	local TargetBuffAll = s_util.GetBuffInfo(target)

	--��ȡ�Լ���Ŀ��ľ���
	local distance = s_util.GetDistance(player, target)

	--��ȡ������Ϣ
	local warnmsg = s_util.GetWarnMsg()

	--DPSҰ�˹��ϻ�����
	local laohu=s_util.GetNpc(36688,40)
	if laohu then SetTarget(TARGET.NPC, laohu.dwID) s_util.TurnTo(laohu.nX,laohu.nY) end

	if distance > 3.5 then
	s_util.TurnTo(target.nX, target.nY) MoveForwardStart()
	else
	MoveForwardStop() s_util.TurnTo(target.nX, target.nY)
	end

	--�ر�����Ȧ�ش̴���
	local xianjing = 0		--��������
	for i,v in ipairs(GetAllNpc()) do		--��������NPC
		if  v.dwTemplateID==36780 and s_util.GetDistance(v, player) < 3.5 then  --3.5�����л�Ȧ
			xianjing = 1                                                                
		end
		if  v.dwTemplateID==36774 and s_util.GetDistance(v, player) < 3.5 then  --3.5�����еش�
			xianjing = 1                                                                
		end
	end
	if xianjing ==1 then
		s_util.TurnTo(target.nX, target.nY) StrafeLeftStart()
	else
		StrafeLeftStop() s_util.TurnTo(target.nX, target.nY) 
	end

	--�ر���BOSS��������
	local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)		--���� �Ƿ��ڶ���, ����ID���ȼ���ʣ��ʱ��(��)����������
	if dwSkillId == 9241 and nLeftTime > 0.5 then if s_util.CastSkill(9007,false,true) then return end end       --�������

	--�ر���BOSS����
	if TargetBuffAll[7929] then if s_util.UseItem(5,21534) then return end end

		--�ر�����Ȧ�ش̴���
		local xianjing = 0		--��������
		for i,v in ipairs(GetAllNpc()) do		--��������NPC
		if  v.dwTemplateID==36780 and s_util.GetDistance(v, player) < 3.5 then  --3.5�����л�Ȧ
			xianjing = 1                                                                
			end
		if  v.dwTemplateID==36774 and s_util.GetDistance(v, player) < 3.5 then  --3.5�����еش�
			xianjing = 1                                                                
			end
		end
		if xianjing ==1 then
			s_util.TurnTo(target.nX, target.nY) StrafeLeftStart()
		else
			StrafeLeftStop() s_util.TurnTo(target.nX, target.nY) 
		end

	--DPS OT��ҡ
	if target.dwTemplateID==36680 and s_util.GetTarget(target).dwID== player.dwID then
		s_util.CastSkill(9002,false,true)
		if(MyBuff[208]) then Jump() end
		return
	end

	--����������
	local CurrentSun=player.nCurrentSunEnergy/100
	local CurrentMoon=player.nCurrentMoonEnergy/100

	--��Ŀ�����>8��ʹ�����⣬����CDʹ�ûùⲽ
	if distance > 8 then if s_util.CastSkill(3977,false) then return end end --����
	if distance > 8 then if s_util.CastSkill(3970,false) then return end end --�ù�

	--������û��ͬ�ԣ�������
	if player.nSunPowerValue > 0 and (not MyBuff[4937] or MyBuff[4937] and MyBuff[4937].nLevel ~= 2)   then
		if s_util.CastSkill(3969,true) then return end
	end

	--��60���մ�
	if CurrentSun > 59 and CurrentSun <=79 then if s_util.CastSkill(18626,true) then return end end

	--��ħ
	if s_util.CastSkill(3967,false) then return end

	--��0 ��0,�����֣���80 ��40��������
	if (CurrentMoon <= 19 and CurrentSun <= 19 ) or (CurrentSun >79 and CurrentSun <=99 and CurrentMoon >39 and CurrentMoon <=59 ) then 
		if s_util.CastSkill(3959,false) then return end
	end
	--��0 ��20 ����ӯ�У�������
	if CurrentSun <= 19 and CurrentMoon >19 and CurrentMoon <=39 and MyBuff[12487] then 
		if s_util.CastSkill(3959,false) then return end
	end

	--��0 ��40 �ҷ���ӯ�У���ն
	if  CurrentSun <= 19 and CurrentMoon >39 and CurrentMoon <=59 and not MyBuff[12487] then
		if  s_util.CastSkill(3963,false)  then return end 
	end
	--��20 ��20 �ҷ���ӯ�У���ն
	if CurrentSun >19 and CurrentSun <=39 and CurrentMoon >19 and CurrentMoon <=39 and not MyBuff[12487] then 
		if  s_util.CastSkill(3963,false)  then return end 
	end

	--��0 ��20 �ҷ���ӯ�У�������
	if CurrentSun <= 18 and CurrentMoon >19 and CurrentMoon <=39 and not MyBuff[12487] then 
		if  s_util.CastSkill(3962,false)  then return end 
	end
	--��60 ��60 �ҷ���ӯ�У�������
	if CurrentSun >59 and CurrentSun <=79 and CurrentMoon >59 and CurrentMoon <=79 and not MyBuff[12487] then
	if  s_util.CastSkill(3962,false)  then return end 
	end

	--��60 ��20����ҹ
	if  CurrentSun >59 and CurrentSun <=79 and CurrentMoon >19 and CurrentMoon <=39 then
		if s_util.CastSkill(3979,false) then return end
	end
	--��40 ��40����ҹ
	if  CurrentSun >39 and CurrentSun <=59 and CurrentMoon >39 and CurrentMoon <=59 then
		if s_util.CastSkill(3979,false) then return end
	end

	--��80 ��60����ն
	if CurrentSun >79 and CurrentSun <=99 and CurrentMoon >59 and CurrentMoon <=79 then if s_util.CastSkill(3960,false) then return end end 

	--���겹����
	if CurrentSun < 100 and CurrentMoon < 100 and player.nSunPowerValue <= 0 and player.nMoonPowerValue <= 0 then
	if s_util.CastSkill(3959,false) then return end
	end
end


--���� ����
s_tFightFunc[10243][1] = function()
	--��ȡ�Լ���Ҷ���
	local player = GetClientPlayer()
	if not player then return end
	
	--��ȡĿ�����
	local target, targetClass = s_util.GetTarget(player)
	if not target then return end
	--��ȡ�Լ���Ŀ��ľ���
	local distance = s_util.GetDistance(player, target)
	--��ȡ�Լ���buff��
	local MyBuff = s_util.GetBuffInfo(player)
    if s_util.CastSkill(3960, false) then return end
	
	if s_util.CastSkill(3962, false) then return end
	if s_util.CastSkill(3963, false) then return end
	if s_util.CastSkill(3967, false) then return end
	if s_util.CastSkill(3959, false) then return end
	if s_util.CastSkill(3979, false) then return end
end

s_tFightFunc[10243][2] = function()
		
	local player = GetClientPlayer()
	if not player then return end

	--Alt��ǿ�Ʒ���
	if IsAltKeyDown() then return end

	--��ǰѪ����ֵ
	local hpRatio = player.nCurrentLife / player.nMaxLife
	local lowLifePartner,teamAvgLife,memberCount = s_util.GetTeamMember()
	local phpRatio=lowLifePartner.nCurrentLife/ lowLifePartner.nMaxLife
	--��Ѫ�����ٵĶ��ѹ�����
	if phpRatio<0.4 and s_util.GetSkillCD(3969) <=0 then 
	SetTarget(TARGET.PLAYER,lowLifePartner.dwID) 
	s_util.CastSkill(3969,false)
	return
	end

	--��ȡ��ǰĿ��,δ��սûĿ��ֱ�ӷ���,ս����ûĿ��ѡ������ж�NPC,��������
	local target, targetClass = s_util.GetTarget(player)							
	if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then return end
	if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
	local MinDistance = 20		--��С����
	local MindwID = 0		    --���NPC��ID
	for i,v in ipairs(GetAllNpc()) do		--��������NPC
		if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nLevel>0 then  --����ǵжԣ����Ҿ����С
			MinDistance = s_util.GetDistance(v, player)                             
			MindwID = v.dwID                                                                  --�滻�����ID
			end
		end
	if MindwID == 0 then 
		return --û�еж�NPC�򷵻�
	else	
		SetTarget(TARGET.NPC, MindwID)  --�趨Ŀ��Ϊ����ĵж�NPC                
	end
	end
	if target then s_util.TurnTo(target.nX,target.nY) end

	--���Ŀ��������ֱ�ӷ���
	if target.nMoveState == MOVE_STATE.ON_DEATH then return end

	--�ж�Ŀ�����������û�������������ж϶����ļ���ID����Ӧ����(��ϡ�ӭ����ˡ�����ȵ�)
	local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)

	--��ȡ�Լ���buff��
	local MyBuff = s_util.GetBuffInfo(player)

	--��ȡ�Լ���Ŀ����ɵ�buff��
	local TargetBuff = s_util.GetBuffInfo(target, true)

	--��ȡĿ��ȫ����buff��
	local TargetBuffAll = s_util.GetBuffInfo(target)

	--��ȡ�Լ���Ŀ��ľ���
	local distance = s_util.GetDistance(player, target)

	--��ȡ������Ϣ
	local warnmsg = s_util.GetWarnMsg()

	if distance > 3.5 then
	s_util.TurnTo(target.nX, target.nY) MoveForwardStart()
	else
	MoveForwardStop() s_util.TurnTo(target.nX, target.nY)
	end

	local CurrentSun=player.nCurrentSunEnergy/100
	local CurrentMoon=player.nCurrentMoonEnergy/100

	--��ȡ�ҵĶ�������
	local bPrepareMe, dwSkillIdMe, dwLevelMe, nLeftTimeMe, nActionStateMe =  GetSkillOTActionState(player)	



	--����Լ��ڶ���ֱ�ӷ��أ������ϳ�ʥ��
	if bPrepareMe then return end --����û�ã������Լ�ͣ������

	--ȡ���Լ����ϵ�����в����buff
	if MyBuff[4487] then s_util.CancelBuff(4487) end  --���̼���
	if MyBuff[917] then s_util.CancelBuff(917) end    --��ʦ��
	if MyBuff[8422] then s_util.CancelBuff(8422) end  --���ƶ�ǽ
	if MyBuff[926] then s_util.CancelBuff(926) end    --�����
	if MyBuff[4101] then s_util.CancelBuff(4101) end  --�����Ǽ��

	--�ر���BOSS����
	if TargetBuffAll[7929] then if s_util.UseItem(5,21534) then return end end --��ɢ�޵�

	--�ر���BOSS��������
	local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)		--���� �Ƿ��ڶ���, ����ID���ȼ���ʣ��ʱ��(��)����������
	--if dwSkillId == 9241 and nLeftTime > 0.5 then if s_util.CastSkill(9007,false,true) then return end end      --�������

		--�ر�����Ȧ�ش̴���
		local xianjing = 0		--��������
		for i,v in ipairs(GetAllNpc()) do		--��������NPC
		if  v.dwTemplateID==36780 and s_util.GetDistance(v, player) < 3.5 then  --3.5�����л�Ȧ
			xianjing = 1                                                                
			end
		end
		if xianjing ==1 then
			s_util.TurnTo(target.nX, target.nY) StrafeLeftStart()
		else
			StrafeLeftStop() s_util.TurnTo(target.nX, target.nY) 
		end
		
	--OT������
	if s_util.GetTarget(target).dwID~= player.dwID	then if s_util.CastSkill(3971,false) then return end end

	--�ȱ�Ը
	if s_util.CastSkill(3982,false) then return end

	--����
	if hpRatio < 0.4 then if s_util.CastSkill(3969,true) then return end end


	--Ŀ�����Ѫ������30W ���ֳ�ʥ��
	if s_util.GetSkillCD(3985) <=0 and target.nMaxLife>300000 then if s_util.CastSkill(3971,false) then return end end
	if target.nMaxLife>300000 then  if s_util.CastSkill(3985,false) then return end end

	--����ǰʹ���Ļ�̾
	if player.nSunPowerValue > 0 or player.nMoonPowerValue > 0 or MyBuff[9909] and MyBuff[9909].nLeftTime < 12.97 and player.nCurrentSunEnergy > player.nCurrentMoonEnergy then
		if s_util.CastSkill(14922,false) then return end
	end

	--����F�л�Ϊ��ħѭ��
	if IsKeyDown("F") then 
	--��ħ
	if s_util.CastSkill(3967,false) then return end
	end

	--������
	if s_util.CastSkill(3966,false) then return end

	--����ն������ѭ���ϳ�
	if CurrentMoon >= CurrentSun and CurrentMoon < 61  then
		if  s_util.CastSkill(3960,false)  then return end
	end

	-- ����ն������>����ʱ�ͷ�
	if CurrentSun > CurrentMoon and CurrentSun < 61 then
		if  s_util.CastSkill(3963,false)  then return end
	end

	-- ������ڵ��������Ҳ�����ʱ�������
	if CurrentSun >= CurrentMoon and CurrentSun < 100 then
		if  s_util.CastSkill(3962,false)  then return end
	end

	--������������Ҳ�����ʱ��������
	if CurrentSun < CurrentMoon and CurrentMoon < 100 then
	if s_util.CastSkill(3959,false) then return end
	end
end


--Ī��
s_tFightFunc[10447][1] = function()
	local player = GetClientPlayer()
	if not player then return end

	local target, targetClass = s_util.GetTarget(player)
	if not target then return end

	local MyBuff = s_util.GetBuffInfo(player)
	if s_util.CastSkill(14230, false) then return end  --�е�������ѩ����
	if s_util.CastSkill(14082, false) then return end  --��Ӱ��
	if s_util.CastSkill(14081, false) then return end  --��Ӱ��˫
	if s_util.CastSkill(14083, false) then return end  --���Ӱ��
	if s_util.CastSkill(14452, false) then return end  --����
	if s_util.CastSkill(14449, false) then return end  --����
	if s_util.CastSkill(14299, false) then return end  --���Զ���
	if s_util.CastSkill(14068, false) then return end  --���Զ���
	if s_util.CastSkill(14066, false) then return end  --���Զ���
	if s_util.CastSkill(14065, false) then return end  --���Զ���
end

s_tFightFunc[10447][2] = function()

	--��ȡ�Լ���Player����û�еĻ�˵����û������Ϸ��ֱ�ӷ���
	local player = GetClientPlayer()
	if not player then return end

	--��ǰѪ����ֵ
	local hpRatio = player.nCurrentLife / player.nMaxLife
	local mymana =player.nCurrentMana / player.nMaxMana

	--��ȡ��ǰĿ��,δ��սûĿ��ֱ�ӷ���,ս����ûĿ��ѡ������ж�NPC,��������
	local target, targetClass = s_util.GetTarget(player)							
	if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then return end
	if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
		local MinDistance = 20		--��С����
		local MindwID = 0		    --���NPC��ID
		for i,v in ipairs(GetAllNpc()) do		--��������NPC
			if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nLevel>0 then  --����ǵжԣ����Ҿ����С
			MinDistance = s_util.GetDistance(v, player)                             
			MindwID = v.dwID                                                                  --�滻�����ID
			end
		end
		if MindwID == 0 then 
			return --û�еж�NPC�򷵻�
		else	
			SetTarget(TARGET.NPC, MindwID)  --�趨Ŀ��Ϊ����ĵж�NPC                
		end
	end

	if target then s_util.TurnTo(target.nX,target.nY) end

	--���Ŀ��������ֱ�ӷ���
	if target.nMoveState == MOVE_STATE.ON_DEATH then return end

	--��ȡ�Լ���buff��
	local MyBuff = s_util.GetBuffInfo(player)

	--��ȡ�Լ���Ŀ����ɵ�buff��
	local TargetBuff = s_util.GetBuffInfo(target, true)

	--��ȡĿ��ȫ����buff��
	local TargetBuffAll = s_util.GetBuffInfo(target)

	--��ȡ�Լ���Ŀ��ľ���
	local distance = s_util.GetDistance(player, target)

	--��ȡ������Ϣ
	local warnmsg = s_util.GetWarnMsg()

	--DPSҰ�˹��ϻ�����
	local laohu=s_util.GetNpc(36688,40)
	if laohu then SetTarget(TARGET.NPC, laohu.dwID) s_util.TurnTo(laohu.nX,laohu.nY) end

	if distance > 15 then
	s_util.TurnTo(target.nX, target.nY) MoveForwardStart()
	else
	MoveForwardStop() s_util.TurnTo(target.nX, target.nY)
	end

	--�ر�����Ȧ�ش̴���
	local xianjing = 0		--��������
	for i,v in ipairs(GetAllNpc()) do		--��������NPC
		if  v.dwTemplateID==36780 and s_util.GetDistance(v, player) < 3.5 then  --3.5�����л�Ȧ
			xianjing = 1                                                                
		end
		if  v.dwTemplateID==36774 and s_util.GetDistance(v, player) < 3.5 then  --3.5�����еش�
			xianjing = 1                                                                
		end
	end
	if xianjing ==1 then
		s_util.TurnTo(target.nX, target.nY) StrafeLeftStart()
	else
		StrafeLeftStop() s_util.TurnTo(target.nX, target.nY) 
	end

	--��ȡ�Լ�Ӱ������
	local ShadowNumber = s_util.GetShadow()

	--�ر���BOSS��������
	local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)		--���� �Ƿ��ڶ���, ����ID���ȼ���ʣ��ʱ��(��)����������
	if dwSkillId == 9241 and nLeftTime > 0.5 then if s_util.CastSkill(9007,false,true) then return end end        --�������

	--�ر���BOSS����
	if TargetBuffAll[7929] then if s_util.UseItem(5,21534) then return end end

		--�ر�����Ȧ�ش̴���
		local xianjing = 0		--��������
		for i,v in ipairs(GetAllNpc()) do		--��������NPC
		if  v.dwTemplateID==36780 and s_util.GetDistance(v, player) < 3.5 then  --3.5�����л�Ȧ
			xianjing = 1                                                                
			end
		if  v.dwTemplateID==36774 and s_util.GetDistance(v, player) < 3.5 then  --3.5�����еش�
			xianjing = 1                                                                
			end
		end
		if xianjing ==1 then
			s_util.TurnTo(target.nX, target.nY) StrafeLeftStart()
		else
			StrafeLeftStop() s_util.TurnTo(target.nX, target.nY) 
		end

	--DPS OT��ҡ
	if target.dwTemplateID==36680 and s_util.GetTarget(target).dwID== player.dwID then
		s_util.CastSkill(9002,false,true)
		if(MyBuff[208]) then Jump() end
		return
	end

	--��ʼ��DOTˢ�±�־
	if not g_MacroVars.State_14064 then
		g_MacroVars.State_14064 = 0				--DOTˢ�±�־
	end		

	--�����н�ʱ���Լ����գ�С�Ĵ�ս������ν����10�˻���25�˸������ע�͵�
	if not MyBuff[9284] and target.nMaxLife < 300000 then if s_util.CastSkill(14083, false) then return end end  --���Ӱ��
	if MyBuff[9506] then if s_util.CastSkill(14452, false) then return end end --����
	if MyBuff[9506] and distance < 4 then if s_util.CastSkill(14449, false) then return end end --����

	if player.nPoseState ~= POSE_TYPE.YANGCUNBAIXUE then		--�������������ѩ����
		s_util.CastSkill(14070, false)						--�л�������ѩ
		return
	end

	--��Ӱ�����粻��CD��Ŀ�����Ѫ��>40Wʱ����Ӱ
	if s_util.GetSkillCN(14082) > 2 and s_util.GetSkillCD(14067) <=0 and target.nMaxLife > 300000 then
		if s_util.CastSkill(14081, false) then return end
	end

	--��Ӱ��˫buffС��1S���ù�Ӱ
	if MyBuff[9284] and MyBuff[9284].nLeftTime < 1 then
		if s_util.CastSkill(14162, false) then return end
	end	

	--�ͷ�������ѩ(���ȣ�
	if s_util.CastSkill(14230, false, true) then return end

	--��ȡ�ҵĶ�������
	local bPrepareMe, dwSkillIdMe, dwLevelMe, nLeftTimeMe, nActionStateMe =  GetSkillOTActionState(player)

	--�����̡���ˢ���ӳ��ظ���������
	--������ڶ���
	if  dwSkillIdMe == 14064 and nLeftTimeMe < 0.5 then  
		g_MacroVars.State_14064 = 1 	--����ˢ��DOT��־
	end

	--�ж�ˢ���ҳ��ܴ������ڵ���2���ͷ���
	if  g_MacroVars.State_14064 == 1 and s_util.GetSkillCN(14068) >= 2 then
		if s_util.CastSkill(14068, false)  then 
			g_MacroVars.State_14064 = 0
			return 
		end   --�ͷ���
	end

	--Ŀ���̻�ǳ���ʱ��С��4S��û��ˢ��DOT��־������
	if (TargetBuff[9357] and TargetBuff[9357].nLeftTime < 4 and g_MacroVars.State_14064 == 0) or (TargetBuff[9361] and TargetBuff[9361].nLeftTime < 4 and g_MacroVars.State_14064 == 0) then
		if s_util.CastSkill(14064, false) then				--ʩ�Ź�ˢ��DOT
				g_MacroVars.State_14064 = 1             --����ˢ��DOT��־
				return
		end
	end

	--���Ӱ�Ӳ������ҳ��ܴ���0�ҹ�ӰCD>50S�Ҳ��ڶ����ͷ�Ӱ��
	if ShadowNumber < 6 and s_util.GetSkillCN(14082) > 0 and s_util.GetSkillCD(14081) > 50 and not bPrepareMe then
		if s_util.CastSkill(14082, false) then return end
	end
	--Ŀ�����Ѫ��С��40W���Է�Ӱ��
	if ShadowNumber < 6 and target.nMaxLife < 300000  and not bPrepareMe and s_util.GetSkillCN(14082) > 0 then
		if s_util.CastSkill(14082, false) then return end
	end
	--��������7Ӱ��
	if ShadowNumber==6 and  s_util.GetSkillCN(14082) > 2 then
		if s_util.CastSkill(15040,true) then return end
		end
	--û����Ӱ��
	if mymana <= 0.3 and ShadowNumber>1 then 
		s_util.CastSkill(15040,true) 
		return 
	end

	--���̣�DOT��
	if not TargetBuff[9357] then
		if s_util.CastSkill(14065, false) then return end  
	end

	--���ǣ�DOT��
	if not TargetBuff[9361] then
		if  s_util.CastSkill(14066, false) then return end  
	end

	--û���趬buff�����趬����2���ͷ���
	if  not MyBuff[9353] or (MyBuff[9353] and MyBuff[9353].nLevel ==2 )then
		if s_util.CastSkill(14068, false)  then return end   --�ͷ���
	end

	--�趬buff1��ʱ��Ҫ2��������ϲ��ͷ��𣬱�֤����ʱ��
	if  MyBuff[9353] and MyBuff[9353].nLevel ==1 and s_util.GetSkillCN(14068) >= 2 then
		if s_util.CastSkill(14068, false)  then return end   --�ͷ���
	end

	--��3���趬�Ҳ��ٹ�Ӱ�У�����
	if MyBuff[9353] and MyBuff[9353].nLevel > 2 and not MyBuff[9284] then
		if s_util.CastSkill(14067, false)  then return end  --������
	end

	--�������
	if s_util.CastSkill(14064, false) then return end
end

--������
s_tFightFunc[10389][2] = function()
	--��ȡ�Լ���Player����û�еĻ�˵����û������Ϸ��ֱ�ӷ���
	local player = GetClientPlayer()
	if not player then return end

	--��ǰѪ����ֵ
	local hpRatio = player.nCurrentLife / player.nMaxLife

	--��ȡ��ǰĿ��,δ��սûĿ��ֱ�ӷ���,ս����ûĿ��ѡ������ж�NPC,��������
	local target, targetClass = s_util.GetTarget(player)							
	if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then return end
	if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
		local MinDistance = 20		--��С����
		local MindwID = 0		    --���NPC��ID
		for i,v in ipairs(GetAllNpc()) do		--��������NPC
			if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nLevel>0 then  --����ǵжԣ����Ҿ����С
				MinDistance = s_util.GetDistance(v, player)                             
				MindwID = v.dwID                                                                  --�滻�����ID
			end
		end
		if MindwID == 0 then 
			return --û�еж�NPC�򷵻�
		else	
			SetTarget(TARGET.NPC, MindwID)  --�趨Ŀ��Ϊ����ĵж�NPC                
		end
	end
	if target then s_util.TurnTo(target.nX,target.nY) end

	--���Ŀ��������ֱ�ӷ���
	if target.nMoveState == MOVE_STATE.ON_DEATH then return end

	--��ȡ�Լ���buff��
	local MyBuff = s_util.GetBuffInfo(player)

	--��ȡĿ���buff��
	local TargetBuff = s_util.GetBuffInfo(target)
	local mTargetBuff = s_util.GetBuffInfo(target,true)

	--��ȡ�Լ���Ŀ��ľ���
	local dis = s_util.GetDistance(player, target)

	--����������Χ׷��
	if dis > 3.5 then
		s_util.TurnTo(target.nX, target.nY) MoveForwardStart()
	else
		MoveForwardStop() s_util.TurnTo(target.nX, target.nY)
	end

	--�ر���BOSS��������
	local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)		--���� �Ƿ��ڶ���, ����ID���ȼ���ʣ��ʱ��(��)����������
	if dwSkillId == 9241 and nLeftTime > 0.5 then if s_util.CastSkill(9007,false,true) then return end end        --�������

	--�ر���BOSS���ߴ���
	if TargetBuff[7929] then if s_util.UseItem(5,21534) then return end end

	--�ر�����Ȧ�ش̴���
	local xianjing = 0		--��������
	for i,v in ipairs(GetAllNpc()) do		--��������NPC
		if  v.dwTemplateID==36780 and s_util.GetDistance(v, player) < 3.5 then  --3.5�����л�Ȧ
			xianjing = 1                                                                
		end
		if  v.dwTemplateID==36774 and s_util.GetDistance(v, player) < 3.5 then  --3.5�����еش�
			xianjing = 1                                                                
		end
	end
	if xianjing ==1 then
		s_util.TurnTo(target.nX, target.nY) StrafeLeftStart()
	else
		StrafeLeftStop() s_util.TurnTo(target.nX, target.nY) 
	end
	--���Ѫ��С��20���ͷŶܱ�
	if hpRatio < 0.20 and s_util.CastSkill(13070, false) then return end
	--�����̬�����
	if player.nPoseState == 2 then
		--ʩ�Ŷܵ�
		if player.nCurrentRage > 105 then
			if s_util.CastSkill(13391, false) then return end
		end
	
		--ʩ�Ŷܷ�
		if MyBuff[8448] and MyBuff[8448].nLeftTime > 8 and s_util.GetSkillCN(13050) > 0 then
			if s_util.CastSkill(13050, false) then return end
		end
		--ʩ�Ŷ�ѹ
		if player.nCurrentRage < 100 then
			if s_util.CastSkill(13045, false) then return end
		end
		--ʩ�Ŷܵ���4321��
		if s_util.CastSkill(13119, false) then return end
		if s_util.CastSkill(13060, false) then return end
		if s_util.CastSkill(13059, false) then return end
		if s_util.CastSkill(13044, false) then return end
	end

	--�����̬���浶
	if player.nPoseState == 1 then
		--�л���̬
		if s_util.CastSkill(13051, false) then return end
	end
end

--��ɽ
s_tFightFunc[10390][2] = function()
	--��ȡ�Լ���Player����û�еĻ�˵����û������Ϸ��ֱ�ӷ���
	local player = GetClientPlayer()
	if not player then return end
	--��ǰѪ����ֵ
	local hpRatio = player.nCurrentLife / player.nMaxLife
	--��ȡ��ǰĿ��,δ��սûĿ��ֱ�ӷ���,ս����ûĿ��ѡ������ж�NPC,��������
	local target, targetClass = s_util.GetTarget(player)		
	if not player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) )then return end
	if player.bFightState and (not target or not IsEnemy(player.dwID, target.dwID) ) then  
		local MinDistance = 20		--��С����
		local MindwID = 0		    --���NPC��ID
		for i,v in ipairs(GetAllNpc()) do		--��������NPC
			if IsEnemy(player.dwID, v.dwID) and s_util.GetDistance(v, player) < MinDistance and v.nLevel>0 then  --����ǵжԣ����Ҿ����С
				MinDistance = s_util.GetDistance(v, player)                             
				MindwID = v.dwID                                                                  --�滻�����ID
			end
		end
		if MindwID == 0 then 
			return --û�еж�NPC�򷵻�
		else	
			SetTarget(TARGET.NPC, MindwID)  --�趨Ŀ��Ϊ����ĵж�NPC                
		end
	end
	if target then s_util.TurnTo(target.nX,target.nY) end
	--���Ŀ��������ֱ�ӷ���
	if target.nMoveState == MOVE_STATE.ON_DEATH then return end
	--��ȡ�Լ���buff��
	local MyBuff = s_util.GetBuffInfo(player)
	--��ȡĿ���buff��
	local TargetBuff = s_util.GetBuffInfo(target)
	local mTargetBuff = s_util.GetBuffInfo(target,true)
	--��ȡĿ�굱ǰѪ����ֵ
	local thpRatio = target.nCurrentLife / target.nMaxLife
	--��ȡ�Լ���Ŀ��ľ���
	local distance = s_util.GetDistance(player, target)
	--��ȡ������Ϣ
	local warnmsg = s_util.GetWarnMsg()
	--��ʼ��Ѫŭ����
	if not g_MacroVars.State_13040 then
		g_MacroVars.State_13040 = 0				
	end
	--DPSҰ�˹��ϻ�����
	local laohu=s_util.GetNpc(36688,40)
	if laohu then SetTarget(TARGET.NPC, laohu.dwID) s_util.TurnTo(laohu.nX,laohu.nY) end
	--����������Χ׷��
	if distance > 3.5 then
	s_util.TurnTo(target.nX, target.nY) MoveForwardStart()
	else
	MoveForwardStop() s_util.TurnTo(target.nX, target.nY)
	end

	--�ر���BOSS��������
	local bPrepare, dwSkillId, dwLevel, nLeftTime, nActionState =  GetSkillOTActionState(target)		--���� �Ƿ��ڶ���, ����ID���ȼ���ʣ��ʱ��(��)����������
	if dwSkillId == 9241 and nLeftTime > 0.5 then if s_util.CastSkill(9007,false,true) then return end end        --�������

	--�ر���BOSS���ߴ���
	if TargetBuff[7929] then if s_util.UseItem(5,21534) then return end end

	--�ر�����Ȧ�ش̴���
	local xianjing = 0		--��������
	for i,v in ipairs(GetAllNpc()) do		--��������NPC
		if  v.dwTemplateID==36780 and s_util.GetDistance(v, player) < 3.5 then  --3.5�����л�Ȧ
			xianjing = 1                                                                
		end
		if  v.dwTemplateID==36774 and s_util.GetDistance(v, player) < 3.5 then  --3.5�����еش�
			xianjing = 1                                                                
		end
	end
	if xianjing ==1 then
		s_util.TurnTo(target.nX, target.nY) StrafeLeftStart()
	else
		StrafeLeftStop() s_util.TurnTo(target.nX, target.nY) 
	end

	--DPS OT��ҡ
	if target.dwTemplateID==36680 and s_util.GetTarget(target).dwID== player.dwID then
		s_util.CastSkill(9002,false,true)
		if(MyBuff[208]) then Jump() end
		return
	end
	--��ս��״̬
	if not player.bFightState then
	if not MyBuff[3853] and s_util.GetItemCD(8,5147,true) <1 and Strength >3 then
	if s_util.UseEquip(8,5147) then end
	end
	
	--���û��B��׹buff,����B��׹����CD<1,,����Ŀ����BOSSʹ��B��׹���� 
	if not MyBuff[3853] and s_util.GetItemCD(8,5147,true) <1 and Strength >3 then
	  if s_util.UseItem(8,5147) then end
	end
	 
	--���û��C��׹buff,����C��׹����CD<1,,����Ŀ����BOSS�л���C��׹
	if not MyBuff[6360] and s_util.GetItemCD(8,19078,true) <1 and Strength >3 then
	  if s_util.UseEquip(8,19078) then end 
	end 
	
	--���û��C��׹buff,����C��׹����CD<1,,����Ŀ����BOSSʹ��C��׹����  
	if not MyBuff[6360] and s_util.GetItemCD(8,19078,true) <1 and Strength >3 then
	  if s_util.UseItem(8,19078) then end
	end	
  
	--�����B��׹buff��C��׹buff,����B��׹����cd>1����C��׹����cd>1,�л���A��׹
	 if ( MyBuff[6360] and MyBuff[3853] ) or ( s_util.GetItemCD(8,19078,true) >1 and s_util.GetItemCD(8,5147,true) >1 ) then
	  if s_util.UseEquip(8,22831) then end
	end
	
	--�ͷ�����Ѫŭ
	if not MyBuff[8385] or MyBuff[8385].nStackNum < 2 then
	  if s_util.CastSkill(13040, false) then return end
	end
	
  --��ս��״̬����
  end	
	  
  --����ս��״̬
  if player.bFightState then
  
  --���Ѫ��С��30���ͷŶܱ�
  if hpRatio < 0.30 and s_util.CastSkill(13070, false) then return end
  
  --����Ѫŭ�ͷ�����	
  --local xuenu33 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 3
  local xuenu3 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 3  --���û��Ѫŭbuff����Ѫŭ���ô���=3��
  local xuenu2 = not MyBuff[8385] and s_util.GetSkillCN(13040) == 2  --���û��Ѫŭbuff����Ѫŭ���ô���=2��	
  local xuenu1 = not MyBuff[8385]                                    --���û��Ѫŭbuff
  
  --���û��Ѫŭbuff,����Ѫŭ���ô���=3��,�ͷ�Ѫŭ���ұ��Ϊ3
	  if xuenu3 then 
	  if s_util.CastSkill(13040, false) then 
	  g_MacroVars.State_13040 = 3 return end 
	  elseif 
  --���û��Ѫŭbuff������Ѫŭ���ô���=2��,�ͷ�Ѫŭ���ұ��Ϊ2
	  xuenu2 then 
	  if s_util.CastSkill(13040, false) then 
	  g_MacroVars.State_13040 = 2 return end 
	  elseif 
  --���û��Ѫŭbuff,�ͷ�Ѫŭ���ұ��Ϊ1
	  xuenu1 then 
	  if s_util.CastSkill(13040, false) then return end
  end
  
  --���Ѫŭ���Ϊ3���ٴ��ͷ�Ѫŭ����ձ��
	  if g_MacroVars.State_13040 == 3 then 
	  if s_util.CastSkill(13040, false) then
	  g_MacroVars.State_13040 = 0 return end
	  end
	  
  --���Ѫŭ���Ϊ2���ٴ��ͷ�Ѫŭ����ձ��
	  if g_MacroVars.State_13040 == 2 then 
	  if s_util.CastSkill(13040, false) then
	  g_MacroVars.State_13040 = 0 return end
	  end
	  
	--�����̬�����
	if player.nPoseState == 2 then
	
	  --���ŭ��<30,����Ŀ������Ѫbuff,������Ѫ����=1,������Ѫʱ��>15,û��buff����,ʩ�Ŷ�ѹ
	  if player.nCurrentRage<= 30 or TargetBuff[8249] and TargetBuff[8249].nStackNum == 1 and TargetBuff[8249].nLeftTime > 15 and not MyBuff[8738] then
	  if s_util.CastSkill(13045, false) then return end
	  end
	
	  --���Ŀ������Ѫbuff, �ܻ���ʹ�ô�������0, ʩ�Ŷܻ�
	  if TargetBuff[8249] and s_util.GetSkillCN(13047) > 0 then 
	  if s_util.CastSkill(13047, false) then return end
	  end
  
	  --2��������Ѫ�ܷ��ж�
	  if not TargetBuff[8249] and player.nCurrentRage>= 40 or  --���Ŀ��û����Ѫbuff,��������ŭ��>25,����
	  TargetBuff[8249] and TargetBuff[8249].nStackNum == 1 and s_util.GetSkillCN(13047) < 1 or
	  s_util.GetSkillCN(13047) < 1 and player.nCurrentRage>= 40 and TargetBuff[8249] and TargetBuff[8249].nStackNum >= 2 or
	  TargetBuff[8249] and TargetBuff[8249].nLeftTime < 2 then
	  if s_util.CastSkill(13050, false) then return end  
	  end
	  
	  --���ŭ��С��40,���Ҷ�ѹCD>1,���Ҷܻ������Ϊ3,�ͷŶ���
	  if player.nCurrentRage<= 40 and s_util.GetSkillCD(13045) > 1 and s_util.GetSkillCN(13047) < 1 then
	  if s_util.CastSkill(13046, false) then return end
	  end
	  
	  --�ܵ���4321��
	  if s_util.CastSkill(13119, false) then return end
	  if s_util.CastSkill(13060, false) then return end
	  if s_util.CastSkill(13059, false) then return end
	  if s_util.CastSkill(13044, false) then return end
	  
	  --�����̬����
	  end
	  
	--�����̬���浶
	if player.nPoseState == 1 then		
  
	  --Ŀ����Ѫʱ��>18������Ѫ����>1,ʩ������
	  if TargetBuff[8249] and TargetBuff[8249].nStackNum > 1 and TargetBuff[8249].nLeftTime > 18 then
		  if s_util.CastSkill(13053, false) then return end
	  end
	  
	  --���Ŀ��û����Ѫbuff,������Ѫ����<3,������Ѫʱ��<4,�ͷ�ն��
	  if not TargetBuff[8249] or TargetBuff[8249].nStackNum < 3 or TargetBuff[8249].nLeftTime < 4 then
		  if s_util.CastSkill(13054, false) then return end 
	  end	
	  
	  --��1����Ѫ���������ܻ���ʹ�ô���>2,���Ҷܷɿ�ʹ�ô���>0,����ն��CD>1,����Ŀ������Ѫbuff,������Ѫ����=1,������Ѫʱ��>15,ʩ�Ŷܻ�
	  if  s_util.GetSkillCN(13047) > 2 and s_util.GetSkillCN(13050) > 0 and s_util.GetSkillCD(13054) > 1 and TargetBuff[8249] and TargetBuff[8249].nStackNum == 1 and TargetBuff[8249].nLeftTime > 15 then
		  if s_util.CastSkill(13051, false) then
		  g_MacroVars.State_13047 =0 return end
	  end
	  
	  --��2����Ѫ���������ܻ���ʹ�ô���>2,���Ҷܷɿ�ʹ�ô���>0,����ն��CD>1,��������CD>1,����Ŀ������Ѫbuff,������Ѫ����=2,ʩ�Ŷܻ�
	  if  s_util.GetSkillCN(13047) > 2 and s_util.GetSkillCN(13050) > 0 and s_util.GetSkillCD(13054) > 1 and s_util.GetSkillCD(13053) > 1 and TargetBuff[8249] and TargetBuff[8249].nStackNum == 2 then
		  if s_util.CastSkill(13051, false) then
		  g_MacroVars.State_13047 =0 return end
	  end	
	  
	  --��3����Ѫ���1������ܻ���ʹ�ô���>2,���Ҷܷɿ�ʹ�ô���>0,����ն��CD>1,��������CD>1,����Ŀ������Ѫbuff,������Ѫ����=3,������Ѫʱ��<7,ʩ�Ŷܻ�
	  if  s_util.GetSkillCN(13047) > 2 and s_util.GetSkillCN(13050) > 0 and s_util.GetSkillCD(13054) > 1 and s_util.GetSkillCD(13053) > 1 and TargetBuff[8249] and TargetBuff[8249].nStackNum == 3 and TargetBuff[8249].nLeftTime < 7 then
		  if s_util.CastSkill(13051, false) then
		  g_MacroVars.State_13047 =0 return end
	  end	
	  
	  --��3����Ѫ���2�����ŭ��<=4,���߶ܷɿ�ʹ�ô���>0,��������CD>1,����ն��CD>1,����Ŀ������Ѫbuff,������Ѫ����=3,ʩ�Ŷܻ�
	  if player.nCurrentRage<=4 then 
		 if s_util.CastSkill(13051, false) then
		 g_MacroVars.State_13047 =0 return end
	  end
	  
	  --�ٵ�
	  if s_util.CastSkill(13052, false) then return end
	  
  --�浶��̬����	
	end
	
  --ս��״̬����  
  end	
	
end