## PVE

### 装备选择

```
头：T2
项链：火圈
肩膀：暗影惩戒 29暗伤
披风：暗影惩戒 21暗伤
衣服：波动或虚空
手腕：T1
手套：恶魔布
腰带：耳语或燃魔
腿：T2
鞋：马勒基
戒指：法术能量
饰品：短暂+石楠
武器 ：碧空+暗影惩戒火石
魔杖：stsm
```

## PVP

技巧
第一次魅惑暗影箭>死缠>灼热之痛>暗影灼烧>接第二次魅惑。

等 10 秒，手雷打断第二次魅惑>暗影箭>第三次魅惑

第三个暗影箭和第二个灼烧

有潮汐可以第四个暗影箭。

https://bbs.nga.cn/read.php?&tid=19483032

### 装备

T0：潮汐护符
T1：竞技场大师饰物、侏儒隐身装置、末日颅骨
T2: 冰暗反射、 天地双鬼 侏儒作战小鸡、奥金幼龙、秒表、短暂
不推荐：地精投网、徽章



## 工程冲级

```
1-30[劣质火药]
30-60[一把螺栓]
60-61[扳手]
61-65[铜管]
65-85[铜质调节器 ]
85-105[活动假人 ]
105-125[青铜管 ]
125-145[烈性火药 ]
145-150[高速青铜齿轮 ]
150-160[青铜框架 ]
161-175[自爆绵羊]
175-185[实心炸药 ]
185-200[铁皮手雷 ]
200-215[不牢固的扳机 ]
215-235[秘银外壳 ]
235-250[高爆炸弹 ]
251-260[致密炸药粉 ]
260-285[世界图纸：瑟银零件 ]
285-300[世界图纸：瑟银弹 ]
```

### 宏

#showtooltip 恶魔牺牲
/施放 牺牲
/施放 恶魔支配
/施放 召唤虚空行者

#showtooltip 恶魔牺牲
/施放 恶魔牺牲
/施放 牺牲

#showtooltip [nomod:shift]恐惧术;恐惧嚎叫
/petattack [@战栗图腾][@图腾]
/施放 [mod:shift]恐惧嚎叫
/施放 [@mouseover,harm,combat][@target,harm,nodead] 恐惧术
/stopmacro [noharm]
/p 正在恐惧，注意打战栗图腾 [%t]
/脚本 if(GetRaidTargetInex("target")~=3)then SetRaidTarget("target",3);end

#showtooltip
/equip 地精火箭靴
/castsequence reset=300 地精火箭靴,迅捷药水

#showtooltip 召唤地狱战马
/施放 [btn:2]机械松鼠笼
/equipslot [mounted] 13 灵巧秒表;
/equipslot [mounted] 14 天选者印记;
/dismount [mounted];
/equipslot [nomounted] 13 棍子上的胡萝卜;
/施放 [nomounted]召唤地狱战马;
/施放 [nocombat,pet:魅魔]次级隐形术
/施放 [nocombat,pet:小鬼]相位变换

/run SendChatMessage("法爷", "WHISPER", nil, GetUnitName("PLAYERTARGET"));SendChatMessage(" 法爷您行行好,三天三夜没喝水了", "WHISPER", nil,GetUnitName("PLAYERTARGET"));
/乞求
