--ERAS病例医保费用数据
select 
a.No_TreatList 就诊号,PatName 姓名,InPCode 住院号,E.SexName 性别,Age 年龄,
F.PatientTypeName 医保类型,TotalCosts 住院总花费,
SUM(CASE WHEN ClassOnInRcpt=11 THEN InMoney ELSE 0 END ) 床位费,
SUM(CASE WHEN ClassOnInRcpt=16 THEN InMoney ELSE 0 END )  治疗费,
SUM(CASE WHEN ClassOnInRcpt=12 THEN InMoney ELSE 0 END ) 手术麻醉费,
SUM(CASE WHEN ClassOnInRcpt IN(1,2,3) THEN InMoney ELSE 0 END ) 药品费,
SUM(CASE WHEN ClassOnInRcpt=141 THEN InMoney ELSE 0 END ) 一般诊疗费,
SUM(CASE WHEN ClassOnInRcpt=13 THEN InMoney ELSE 0 END ) 检验费,
SUM(CASE WHEN ClassOnInRcpt=18 THEN InMoney ELSE 0 END ) 护理费,
SUM(CASE WHEN ClassOnInRcpt=26 THEN InMoney ELSE 0 END ) 特殊材料费,
SUM(CASE WHEN ClassOnInRcpt=39 THEN InMoney ELSE 0 END ) 其他
from AdmPatsVisit A WITH (NOLOCK)
JOIN  AdmFareItem C WITH (NOLOCK) ON A.No_TreatList=C.No_TreatList
join dictfare d WITH (NOLOCK) on  C.No_FareItem=d.No_FareItem--关联价表
JOIN DictFareClass B WITH (NOLOCK) ON B.No_FareClass=D.ClassOnInRcpt
JOIN DictSex E  WITH (NOLOCK) ON Sex=No_Sex
JOIN DictPatientType F WITH (NOLOCK) ON F.No_PatientType=PatientType
where 
PatName IN (SELECT * FROM W1)
and AdmissionDate>='2017-08-01' and AdmissionDate<'2018-01-01'
GROUP BY a.No_TreatList,PatName,InPCode,E.SexName ,Age,F.PatientTypeName,TotalCosts 