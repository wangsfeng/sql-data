--ERAS����ҽ����������
select 
a.No_TreatList �����,PatName ����,InPCode סԺ��,E.SexName �Ա�,Age ����,
F.PatientTypeName ҽ������,TotalCosts סԺ�ܻ���,
SUM(CASE WHEN ClassOnInRcpt=11 THEN InMoney ELSE 0 END ) ��λ��,
SUM(CASE WHEN ClassOnInRcpt=16 THEN InMoney ELSE 0 END )  ���Ʒ�,
SUM(CASE WHEN ClassOnInRcpt=12 THEN InMoney ELSE 0 END ) ���������,
SUM(CASE WHEN ClassOnInRcpt IN(1,2,3) THEN InMoney ELSE 0 END ) ҩƷ��,
SUM(CASE WHEN ClassOnInRcpt=141 THEN InMoney ELSE 0 END ) һ�����Ʒ�,
SUM(CASE WHEN ClassOnInRcpt=13 THEN InMoney ELSE 0 END ) �����,
SUM(CASE WHEN ClassOnInRcpt=18 THEN InMoney ELSE 0 END ) �����,
SUM(CASE WHEN ClassOnInRcpt=26 THEN InMoney ELSE 0 END ) ������Ϸ�,
SUM(CASE WHEN ClassOnInRcpt=39 THEN InMoney ELSE 0 END ) ����
from AdmPatsVisit A WITH (NOLOCK)
JOIN  AdmFareItem C WITH (NOLOCK) ON A.No_TreatList=C.No_TreatList
join dictfare d WITH (NOLOCK) on  C.No_FareItem=d.No_FareItem--�����۱�
JOIN DictFareClass B WITH (NOLOCK) ON B.No_FareClass=D.ClassOnInRcpt
JOIN DictSex E  WITH (NOLOCK) ON Sex=No_Sex
JOIN DictPatientType F WITH (NOLOCK) ON F.No_PatientType=PatientType
where 
PatName IN (SELECT * FROM W1)
and AdmissionDate>='2017-08-01' and AdmissionDate<'2018-01-01'
GROUP BY a.No_TreatList,PatName,InPCode,E.SexName ,Age,F.PatientTypeName,TotalCosts 