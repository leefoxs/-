





--����
local v = {}


--�Զ���ϣ�����ж�һ�㶼�ǳ��򵥣�
function daduan()

    --10�˾��϶�����
    if map("���϶�") then
        v["����"] = npc("����:���", "����<40")
        if v["����"] ~= 0 then
            --�ж϶�����ʼ�ͷż��ܣ���Ϊ�ᱻ�ƣ�������������ͻ������ְҵ���������
            if xcasting("Ȫӳǧɽ������",v["����"]) and xcastprog(v["����"]) > 0.01 then
                cast("ͻ")
                cast("��")
            end
        end 
    end
    --10�˰׵�����
    if map("�׵۽���") then
        v["����"] = npc("����:����", "����<40")
        if v["����"] ~= 0 then
            if xcasting("�����ش�",v["����"]) and xcastprog(v["����"]) > 0.01 then
                cast("��")
            end
        end 
    end

    --10�˴�ĦԳ�ɣ���Ҫ�Լ������������Գ����Լ�дһ������������
    if map("��Ħ��") then
        v["����"] = npc("����:Գ��", "����<40")
        if v["����"] ~= 0 then
            if xcasting("��Ӱ��",v["����"]) and xcastprog(v["����"]) > 0.01 then
                cast("��")
            end
        end
    end

end


--�������
function guibi()

    -- ���϶�
    if map("���϶�") then
        v["����"] = npc("����:���", "����<40")
        v["����"] = npc("����:��������Ļ�Ӱ", "����<40")
        -- ��������
        if v["����"] ~= 0 then
            --�ж��Ƿ������������ ���� ��������70%
            if xcasting("��������", v["����"]) and xcastprog(v["����"]) > 0.7 then
                fcast("��")
            end
        end
        -- ��¥�޹���жϻ�Ӱ����
        if v["����"] ~= 0 then
            --������������buff
            if buff("����") then
                --����
                if xcasting("��¥������������", v["����"]) then
                    fcast("��")
                end
            end
        end
    end

    --�׵ۣ�Ŀǰ��t�Ķ�ܻ��ƣ�
    if map("�׵۽���") then
        v["����"] = npc("����:������", "����<40")
        v["����"] = npc("ģ��ID:103368", "����<40")
        --�׵۵���T��Ҫ���������������ƶ��
        --������ͨ���ж϶������к�������
        --���̿���ѡ�����������ƿ�������ǽ�������Ͳ���Ҫ�ж϶������ȣ�ֱ�ӽ����жϼ����ͷ�ʱ���ж��Ƿ��Ѿ�����������û��ʹ���������ܣ���������buffʱ����ȥ����ʹ�÷�ֹȡ���������������ϣ�
        if v["����"] ~= 0 then
            if xcasting("��ħ��",v["����"]) and xcastprog(v["����"]) > 0.88 then
                fcast("��")
            end
        end
        --�׵�����ĺ���ͨ��xcasting��ⲻ��������ʹ��OnPrepare������⵽��Ӧ���ܿ���һ����ʱ�������ü�ʱ���ж϶������ȣ�Ȼ���ͷź���
        if v["����"] ~= 0 then
            --�յļ�ʱ��Ĭ����888888 ����Ҫ�ٳ���
            if gettimer("baidi") > 1.9 and gettimer("baidi") ~= 888888 then
                cast("��")
                --��ɶ����������ʱ��
                deltimer("baidi")
            end
        end
    end

    --��Ħ��Ŀǰ��t�Ķ�ܻ��ƣ�
    if map("��Ħ��") then
        v["����"] = npc("����:Գ��", "����<40")
        --���ϣ��Բ�t���ܾ��������ֶ������ֶ�����Ȼ���ж϶���λ�ú���
        if v["����"] ~= 0 then
            if xcasting("������",v["����"]) then
                cast("����")
            end
            if xcasting("������",v["����"]) and xcastprog(v["����"]) > 0.8 then
                fcast("��")
            end
        end
    end

    --����Ŀǰ��t�Ķ�ܻ��ƣ�
    if map("�������") then
        v["����"] = npc("ģ��ID:106626", "����<40")
        --�Ͱ׵�����һ��������
        if v["����"] ~= 0 then
            if gettimer("leiyu") > 1.58 and gettimer("leiyu") ~= 888888 then
                cast("��")
                deltimer("leiyu")
            end
        end
    end

end



--�������ɫ����ʱ������
function OnPrepare(CasterID, SkillName, SkillID, SkillLevel, TargetType, TargetID, PosY, PosZ, Frame, StartFrame, FrameCount)

    --���ڰ׵۽��ص�ͼʱ
    if map("�׵۽���") then
        --���ֶ�������ǹ���Ŷ�
        if SkillName == "ǹ���Ŷ�" then
            --��ռ�ʱ��
            deltimer("baidi")
            --���¿�ʼ��ʱ
            settimer("baidi")
        end
    end

    --����
    if map("�������") then
        if SkillName == "��¥������������" then
            deltimer("leiyu")
            settimer("leiyu")
        end
    end

end