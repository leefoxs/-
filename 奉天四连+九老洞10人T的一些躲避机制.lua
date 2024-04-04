





--变量
local v = {}


--自动打断（打断判断一般都非常简单）
function daduan()

    --10人九老洞老三
    if map("九老洞") then
        v["老三"] = npc("名字:岑伤", "距离<40")
        if v["老三"] ~= 0 then
            --判断读条开始释放技能，因为会被推，所以这里是先突，其他职业因情况而定
            if xcasting("泉映千山·单峰",v["老三"]) and xcastprog(v["老三"]) > 0.01 then
                cast("突")
                cast("崩")
            end
        end 
    end
    --10人白帝老六
    if map("白帝江关") then
        v["老六"] = npc("名字:宫威", "距离<40")
        if v["老六"] ~= 0 then
            if xcasting("螺旋重锤",v["老六"]) and xcastprog(v["老六"]) > 0.01 then
                cast("崩")
            end
        end 
    end

    --10人达摩猿飞（需要自己二段跳，可以尝试自己写一个，二段跳）
    if map("达摩洞") then
        v["老四"] = npc("名字:猿飞", "距离<40")
        if v["老四"] ~= 0 then
            if xcasting("疾影腿",v["老四"]) and xcastprog(v["老四"]) > 0.01 then
                cast("崩")
            end
        end
    end

end


--副本规避
function guibi()

    -- 九老洞
    if map("九老洞") then
        v["老四"] = npc("名字:鬼筹", "距离<40")
        v["老六"] = npc("名字:暗梦仙体的幻影", "距离<40")
        -- 天震逆退
        if v["老四"] ~= 0 then
            --判断是否读条天震逆退 并且 读条超过70%
            if xcasting("天震逆退", v["老四"]) and xcastprog(v["老四"]) > 0.7 then
                fcast("后撤")
            end
        end
        -- 迦楼罗规避判断幻影出现
        if v["老六"] ~= 0 then
            --当自身有凝视buff
            if buff("凝视") then
                --如上
                if xcasting("迦楼罗连闪·挑飞", v["老六"]) then
                    fcast("后撤")
                end
            end
        end
    end

    --白帝（目前是t的躲避机制）
    if map("白帝江关") then
        v["老四"] = npc("名字:姜集苦", "距离<40")
        v["老五"] = npc("模板ID:103368", "距离<40")
        --白帝的推T需要后跳或者其他机制躲避
        --这里是通过判断读条进行后跳操作
        --明教可以选择开土豆，苍云可以立盾墙（这样就不需要判断读条进度，直接进行判断技能释放时，判断是否已经变土豆，若没有使用土豆技能，当有土豆buff时，不去二次使用防止取消土豆，苍云如上）
        if v["老四"] ~= 0 then
            if xcasting("清魔剑",v["老四"]) and xcastprog(v["老四"]) > 0.88 then
                fcast("后撤")
            end
        end
        --白帝老五的后跳通过xcasting监测不到，所以使用OnPrepare，当监测到对应技能开启一个计时器，利用计时器判断读条进度，然后释放后跳
        if v["老五"] ~= 0 then
            --空的计时器默认是888888 所以要刨除掉
            if gettimer("baidi") > 1.9 and gettimer("baidi") ~= 888888 then
                cast("后撤")
                --完成动作则清除计时器
                deltimer("baidi")
            end
        end
    end

    --达摩（目前是t的躲避机制）
    if map("达摩洞") then
        v["老四"] = npc("名字:猿飞", "距离<40")
        --如上，以策t技能举例当发现读条先手定军，然后判断读条位置后跳
        if v["老四"] ~= 0 then
            if xcasting("劲风腿",v["老四"]) then
                cast("定军")
            end
            if xcasting("劲风腿",v["老四"]) and xcastprog(v["老四"]) > 0.8 then
                fcast("后撤")
            end
        end
    end

    --雷域（目前是t的躲避机制）
    if map("雷域大泽") then
        v["老五"] = npc("模板ID:106626", "距离<40")
        --和白帝老五一样，如上
        if v["老五"] ~= 0 then
            if gettimer("leiyu") > 1.58 and gettimer("leiyu") ~= 888888 then
                cast("后撤")
                deltimer("leiyu")
            end
        end
    end

end



--当任意角色读条时被调用
function OnPrepare(CasterID, SkillName, SkillID, SkillLevel, TargetType, TargetID, PosY, PosZ, Frame, StartFrame, FrameCount)

    --当在白帝江关地图时
    if map("白帝江关") then
        --发现读条技能枪挑九鼎
        if SkillName == "枪挑九鼎" then
            --清空计时器
            deltimer("baidi")
            --重新开始计时
            settimer("baidi")
        end
    end

    --如上
    if map("雷域大泽") then
        if SkillName == "迦楼罗连闪·挑飞" then
            deltimer("leiyu")
            settimer("leiyu")
        end
    end

end