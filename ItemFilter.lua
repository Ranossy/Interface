--������Ʒ�Ĺ��˺���������һ����������Ʒ���󣬷���true��Ҫ���ۣ�����false������
s_tSellFilter = {}

--�������������Ʒ���˺���
s_tSellFilter[1] = function(item)
	--������ܳ���, ����
	if not item.bCanTrade then return false end

	--��ɫ��Ʒ���������̵���Զ�����
	if item.nQuality == 0 then return false end

	--�����װ������
	if item.nGenre == ITEM_GENRE.EQUIPMENT then return true end

	--����ǲ���, ��
	if item.nGenre == ITEM_GENRE.MATERIAL then return true end

	--�����Ķ�����
	return false
end
