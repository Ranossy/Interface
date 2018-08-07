--����Buff����
s_tBuffFunc = {}

--�ж϶����Ƿ��ڸ���״̬
--����(��Ҫ�жϵĶ���)
--����ֵ:���ش��ڸ�״̬�µ�BUFF���ݣ������ڸ�״̬����nil
--[[
    ����    s_tBuffFunc.BaoFa()
    ����    s_tBuffFunc.JianLiao()
    ����    s_tBuffFunc.JinLiao()
    �޵�    s_tBuffFunc.WuDi()
    ��Ĭ    s_tBuffFunc.ChenMo()
    ���    s_tBuffFunc.MianKong()
    ����    s_tBuffFunc.JianShang()
    ����    s_tBuffFunc.JianSu()
    ѣ��    s_tBuffFunc.XuanYun()
    ����    s_tBuffFunc.SuoZu()
    ����    s_tBuffFunc.DingShen()
    ����    s_tBuffFunc.ShanBi()
    ���Ṧ  s_tBuffFunc.FengQingGong()
    �����  s_tBuffFunc.MianFengNei()
    ����    s_tBuffFunc.MianTui()
--]]

--�����жϷ糵����
--����:��Ҫ�жϵĽ�ɫ
--����ֵ���������жϵĽ�ɫ10���������ַ糵����1��10�����ж����糵����������2��û�з���false
s_tBuffFunc.FengChe = function ( tar )
    local npc = s_util.GetNpc(57739, 30)
    local me = GetClientPlayer()
    if npc and IsEnemy(me.dwID, npc.dwID) and s_util.GetDistance(tar, npc) <=10 then
        return 1
    end
    for i,v in ipairs(GetAllPlayer()) do		--����
        local  bPrepare,dwSkillId = GetSkillOTActionState(v)
        if IsEnemy(me.dwID, v.dwID) and (dwSkillId ==1645 or dwSkillId ==16381) then
            local dis = s_util.GetDistance(tar, v)
            if dis <=10 then return 2 end
        end
    end
    return false
end

--����ı�������
--��������ת��������(-128~128) ���޷���ֵ
--ת��������Ҫ2S�������ֹ����ת��
s_tBuffFunc.ChFace = function ( ang )
    local player = GetClientPlayer() 
	local rd = ((player.nFaceDirection+ang)%256)*math.pi/128
	local finX = (128)*math.cos(rd)+player.nX
	local finY = (128)*math.sin(rd)+player.nY
	if not s_util.GetTimer("ChangeFace") or s_util.GetTimer("ChangeFace") > 2000 then
		s_util.SetTimer("ChangeFace")
		s_util.TurnTo(finX, finY)
	end
end

--����
s_tBuffFunc.BaoFa = function ( tar )
    local Buff = s_util.GetBuffInfo(tar)
    local IsBuff = Buff[200--[[�����]]] or Buff[2719--[[���]]] or Buff[2757--[[��������]]] or Buff[538--[[��������]]] or Buff[1378--[[��ˮ]]] or Buff[3468--[[��������]]] or Buff[3859--[[����Ӱ]]] or Buff[2726--[[����]]] or Buff[5994--[[������]]] or Buff[2779--[[Ԩ]]] or Buff[1728--[[ݺ��]]] or Buff[3316--[[����]]] or Buff[2543--[[�����׼�]]] or Buff[9906--[[��ľ����]]] or Buff[11456--[[���]]] or Buff[11216--[[�ؼ�]]]
    return IsBuff
end

--����
s_tBuffFunc.JianLiao = function ( tar )
    local Buff = s_util.GetBuffInfo(tar)
    local IsBuff = Buff[2774--[[����]]] or Buff[3195--[[������]]] or Buff[3538--[[����]]] or Buff[574--[[����]]] or Buff[576--[[��ӽ�ɳ]]] or Buff[2496--[[����ݲ�]]] or Buff[2502--[[Ы��]]] or Buff[4030--[[�½�]]] or Buff[6155--[[��������]]] or Buff[8487--[[�ܻ�]]] or Buff[9514--[[����]]] or Buff[11199--[[�̳�]]]
    return IsBuff
end

--����
s_tBuffFunc.JinLiao = function ( tar )
    local Buff = s_util.GetBuffInfo(tar)
    local IsBuff = Buff[9175--[[Ϣ��]]] or Buff[6223--[[���]]]
    return IsBuff
end

--�޵� ȱ��ƽɳ״̬
s_tBuffFunc.WuDi = function ( tar )
    local Buff = s_util.GetBuffInfo(tar)
    local IsBuff = Buff[377--[[��ɽ��]]] or Buff[961--[[̫��]]] or Buff[772--[[����]]] or Buff[3425--[[����]]] or Buff[360--[[��]]] or Buff[6182--[[ڤ��]]] or Buff[9934--[[�Ϸ�����]]] or Buff[11151--[[ɢ��ϼ]]] or Buff[682--[[������ŭ]]] or Buff[4871--[[��������]]] or Buff[3224--[[����]]] or Buff[2795--[[�޺�����]]] or Buff[8303--[[����]]] 
    return IsBuff
end

--��Ĭ
s_tBuffFunc.ChenMo = function ( tar )
    local Buff = s_util.GetBuffInfo(tar)
    local IsBuff = Buff[726--[[���ɾ���]]] or Buff[692--[[��Ĭ]]] or Buff[712--[[��������]]] or Buff[4053--[[��η����]]] or Buff[8450--[[����]]] or Buff[9378--[[����]]] or Buff[10283--[[����]]] or Buff[11171--[[����]]] or Buff[445--[[����ʽ]]] or Buff[690--[[����ͨ��]]] or Buff[2182--[[���Զ���]]] or Buff[2838--[[�������]]] or Buff[3227--[[÷����]]] or Buff[2807--[[����]]] or Buff[2490--[[�Х����]]] or Buff[585--[[����ָ]]] or Buff[9214--[[������Х]]]
    return IsBuff
end

--���
s_tBuffFunc.MianKong = function ( tar )
    local Buff = s_util.GetBuffInfo(tar)
    local IsBuff = Buff[411--[[��¥��Ӱ]]] or Buff[1186--[[�۹�]]] or Buff[2847--[[����]]] or Buff[855--[[����]]] or Buff[2756--[[������]]] or Buff[2781--[[תǬ��]]] or Buff[3279--[[����֮��]]] or Buff[1856--[[����]]] or Buff[1676--[[��Ȫ��Ծ]]] or Buff[1686--[[��Ȫ����]]] or Buff[2840--[[�Ƴ��]]] or Buff[2544--[[�����׼�]]] or Buff[3822--[[�̵��׼�]]] or Buff[4245--[[ʥ��]]] or Buff[4421--[[���]]] or Buff[4468--[[��Ȼ]]] or Buff[6373--[[��Ԩ]]] or Buff[6361--[[�ɽ�]]] or Buff[6314--[[����]]] or Buff[6292--[[������]]] or Buff[6247--[[���Ĺ�]]] or Buff[6192--[[������]]] or Buff[6131--[[����]]] or Buff[5995--[[Ц���]]] or Buff[6459--[[������]]] or Buff[6015--[[��Ծ��Ԩ]]] or Buff[6369--[[������]]] or Buff[6087--[[�������]]] or Buff[5754--[[����]]] or Buff[5950--[[�Ƴ��׼�]]] or Buff[3275--[[������Ⱥ]]] or Buff[8247--[[�޾�]]] or Buff[8265--[[��ǽ]]] or Buff[8293--[[ǧ��]]] or Buff[8458--[[ˮ���޼�]]] or Buff[8449--[[�ٻ�]]] or Buff[8483--[[����]]] or Buff[8716--[[����]]] or Buff[9059--[[���]]] or Buff[9068--[[����]]] or Buff[9999--[[����]]] or Buff[6284--[[ʥ������]]] or Buff[677--[[ȵ̤֦]]] or Buff[9855--[[����]]] or Buff[9342--[[ʯ����]]] or Buff[9294--[[��Ӱ]]] or Buff[9848--[[̽÷]]] or Buff[10245--[[����Χ]]] or Buff[11361--[[����]]] or Buff[11385--[[��������]]] or Buff[11319--[[��Ԩ����]]] or Buff[374--[[��̫��]]] or Buff[1903--[[Х��]]]
    return IsBuff
end

--����
s_tBuffFunc.JianShang = function ( tar )
    local Buff = s_util.GetBuffInfo(tar)
    local IsBuff = Buff[367--[[����ɽ]]] or Buff[384--[[תǬ��]]] or Buff[399--[[�����]]] or Buff[122--[[���໤��]]] or Buff[3068--[[����]]] or Buff[1802--[[����]]] or Buff[684--[[��صͰ�]]] or Buff[4439--[[̰ħ��]]] or Buff[6315--[[����]]] or Buff[2077--[[����]]] or Buff[6240--[[��ˮ��]]] or Buff[5996--[[Ц���]]] or Buff[5810--[[�Ի�]]] or Buff[6200--[[��Х����]]] or Buff[6636--[[ʥ��֯��]]] or Buff[6262--[[����]]] or Buff[2849--[[��Ϸˮ]]] or Buff[3315--[[����]]] or Buff[8279--[[�ܱ�]]] or Buff[8300--[[��ǽ]]]or Buff[8427--[[�ٻ�]]] or Buff[8291--[[�ܻ�]]] or Buff[8495--[[����]]] or Buff[2983--[[����]]] or Buff[10014--[[����]]] or Buff[10051--[[��ˮ��Ӱ]]] or Buff[10107--[[��˷�]]] or Buff[9334--[[÷����Ū]]] or Buff[11344--[[�Ƹ�����]]] or Buff[6264--[[���໤��]]] 
    return IsBuff
end

--����
s_tBuffFunc.JianSu = function ( tar )
    local Buff = s_util.GetBuffInfo(tar)
    local IsBuff = Buff[733--[[̫��]]] or Buff[4928--[[����]]] or Buff[549--[[��]]] or Buff[450--[[��һ]]] or Buff[523--[[����]]] or Buff[2274--[[����]]] or Buff[560--[[��̫��]]] or Buff[563--[[����ʽ]]] or Buff[584--[[����ָ]]] or Buff[1553--[[�������]]] or Buff[1720--[[����]]] or Buff[2297--[[ǧ˿]]] or Buff[3484--[[����]]] or Buff[3226--[[����޼]]] or Buff[4054--[[ҵ���︿]]] or Buff[6275--[[���賤��]]] or Buff[6259--[[ѩ����]]] or Buff[6191--[[ҵ��]]] or Buff[6162--[[ɽ��]]] or Buff[6130--[[���]]] or Buff[6078--[[�����滨��]]] or Buff[3466--[[���]]] or Buff[4435--[[��ҹ����]]] or Buff[8299--[[��ǽ]]] or Buff[8398--[[����]]] or Buff[8492--[[����]]] or Buff[9170--[[����]]] or Buff[10001--[[����]]] or Buff[9507--[[������]]] or Buff[9217--[[������]]] or Buff[11168--[[����]]] or Buff[11245--[[����]]] or Buff[6072--[[�������]]]
    return IsBuff
end

--ѣ��
s_tBuffFunc.XuanYun = function ( tar )
    local Buff = s_util.GetBuffInfo(tar)
    local IsBuff = Buff[415--[[ѣ��]]] or Buff[533--[[��ä]]] or Buff[567--[[���̽Կ�]]] or Buff[572--[[��ʨ�Ӻ�]]] 
    or Buff[548--[[ͻ]]] or Buff[2275--[[�ϻ��]]] or Buff[740--[[��ע]]] or Buff[1721--[[����]]] or Buff[1904--[[�׹��ɽ]]] or Buff[1927--[[����]]] or Buff[2489--[[Ы������]]] or Buff[2780--[[��������]]] or Buff[3223--[[������]]] or Buff[727--[[��]]] or Buff[1938--[[����ƾ�]]] or Buff[4029--[[�ս�]]] or Buff[4875--[[��ħ]]] or Buff[6276--[[�ùⲽ]]] or Buff[6128--[[����]]] or Buff[6107--[[���]]] or Buff[5876--[[�ƻ�]]] or Buff[6365--[[������ħ��]]] or Buff[6380--[[����ң]]] or Buff[2755--[[����]]] or Buff[1902--[[Σ¥]]] or Buff[2877--[[��Ӱ]]] or Buff[4438--[[��ҹ����]]] or Buff[8329--[[����]]] or Buff[8455--[[����]]] or Buff[8570--[[����]]] or Buff[11453--[[�ù�]]]
    return IsBuff
end

--����
s_tBuffFunc.SuoZu = function ( tar )
    local Buff = s_util.GetBuffInfo(tar)
    local IsBuff = Buff[1937--[[���Ż���]]] or Buff[679--[[Ӱ��]]] or Buff[706--[[ֹˮ]]] or Buff[4038--[[����]]] or Buff[2289--[[�巽�о�]]] or Buff[2492--[[��������]]] or Buff[2547--[[�����׼�]]] or Buff[1931--[[�¹�����]]] or Buff[6364--[[��]]] or Buff[4758--[[����]]] or Buff[5809--[[̫��]]] or Buff[5764--[[����]]] or Buff[5694--[[̫��ָ]]] or Buff[5793--[[���]]] or Buff[4436--[[��ҹ����]]] or Buff[3359--[[��צ]]] or Buff[8251--[[����]]] or Buff[8327--[[�Ͻ�]]] or Buff[3216--[[���Ĵ̹�]]] or Buff[9569--[[������]]] or Buff[9730--[[����ع��]]] or Buff[10282--[[����]]]
    return IsBuff
end

--����
s_tBuffFunc.DingShen = function ( tar )
    local Buff = s_util.GetBuffInfo(tar)
    local IsBuff = Buff[998--[[̫��ָ]]] or Buff[678--[[��������]]] or Buff[686--[[��������]]] or Buff[554--[[�������]]] or Buff[556--[[���ǹ���]]] or Buff[675--[[ܽ�ز���]]] or Buff[737--[[���]]] or Buff[1229--[[����]]] or Buff[1247--[[ͬ��]]] or Buff[4451--[[����]]] or Buff[1857--[[����]]] or Buff[1936--[[筴�����]]] or Buff[2555--[[˿ǣ]]] or Buff[6317--[[����]]] or Buff[6108--[[�������]]] or Buff[6091--[[��Ӱ]]] or Buff[2311--[[�ù�]]] or Buff[4437--[[��ҹ����]]] or Buff[6082--[[�������]]]
    return IsBuff
end

--����
s_tBuffFunc.ShanBi = function ( tar )
    local Buff = s_util.GetBuffInfo(tar)
    local IsBuff = Buff[3214--[[��������]]] or Buff[2065--[[������]]] or Buff[5668--[[�紵��]]] or Buff[6434--[[����ң]]] or Buff[6299--[[�������]]] or Buff[6174--[[����]]]
    return IsBuff
end

--���Ṧ
s_tBuffFunc.FengQingGong = function ( tar )
    local Buff = s_util.GetBuffInfo(tar)
    local IsBuff = Buff[562--[[������]]] or Buff[562--[[ǧ˿����]]] or Buff[562--[[�Ի�]]] or Buff[562--[[��]]] or Buff[562--[[��Ӱ]]] or Buff[562--[[����]]] or Buff[1939--[[�ƾ�]]] or Buff[6074--[[����·]]] or Buff[4497--[[����]]] or Buff[535--[[�벽��]]] or Buff[562--[[����]]] or Buff[10246--[[��Χ]]] or Buff[562--[[����]]]
    return IsBuff
end

--�����
s_tBuffFunc.MianFengNei = function ( tar )
    local Buff = s_util.GetBuffInfo(tar)
    local IsBuff = Buff[6350--[[�ٷ�]]] or Buff[6414--[[�ùⲽ]]] or Buff[8864] or Buff[5777] or Buff[377--[[��ɽ��]]] or Buff[9934--[[�Ϸ�����]]] or Buff[6256] or Buff[8458--[[ˮ���޼�]]] or Buff[1186--[[�۹�]]] or Buff[4439--[[̰ħ��]]] or Buff[6279] or Buff[4245--[[ʥ��]]] or Buff[9999--[[����]]] or Buff[9342--[[ʯ����]]] or Buff[9509] or Buff[9506] or Buff[9693] or Buff[10173] or Buff[5789] or Buff[10618]
    return IsBuff
end

--����
s_tBuffFunc.MianTui = function ( tar )
    local Buff = s_util.GetBuffInfo(tar)
    local IsBuff = Buff[8247--[[�޾�]]] or Buff[8864] or Buff[2756--[[������]]] or Buff[10245--[[����Χ]]] or Buff[377--[[��ɽ��]]] or Buff[9934--[[�Ϸ�����]]] or Buff[6213] or Buff[1903--[[Х��]]] or Buff[1856--[[����]]] or Buff[1686--[[��Ȫ����]]] or Buff[10130] or Buff[3425--[[����]]] or Buff[4439--[[̰ħ��]]] or Buff[6279] or Buff[4245--[[ʥ��]]] or Buff[5754--[[����]]] or Buff[5995--[[Ц���]]] or Buff[8265--[[��ǽ]]] or Buff[8303--[[����]]] or Buff[8483--[[����]]] or Buff[9509] or Buff[9693] or Buff[10173] or Buff[11151--[[ɢ��ϼ]]] or Buff[11336] or Buff[11361--[[����]]] or Buff[11385--[[��������]]] or Buff[11319--[[��Ԩ����]]] or Buff[11322] or Buff[11335] or Buff[11310] or Buff[1186--[[�۹�]]] or Buff[10258] or Buff[11077] or Buff[11148] or Buff[11149] or Buff[5994--[[������]]] or Buff[5996--[[Ц���]]] or Buff[8458--[[ˮ���޼�]]] or Buff[1802--[[����]]]
    return IsBuff
end