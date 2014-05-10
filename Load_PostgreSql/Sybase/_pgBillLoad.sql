create table dba._pgBillLoad
(Id integer not null default autoincrement,
BillNumber TVarCharMedium not null,
FromId Integer not null,
ToId Integer not null,
PRIMARY KEY (BillNumber, FromId, ToId));


-- delete from dba._pgBillLoad ;
insert into dba._pgBillLoad (BillNumber, FromId, ToId)

select '167323' as InvNumber, 4690 as FromId, 0 as ToId
union select '166058' as InvNumber, 4690 as FromId, 0 as ToId
union select '167339' as InvNumber, 4690 as FromId, 0 as ToId
union select '166291' as InvNumber, 4690 as FromId, 0 as ToId
union select '165792' as InvNumber, 4690 as FromId, 0 as ToId
union select '165789' as InvNumber, 4690 as FromId, 0 as ToId
union select '165420' as InvNumber, 4690 as FromId, 0 as ToId
union select '164891' as InvNumber, 4690 as FromId, 0 as ToId
union select '166306' as InvNumber, 4690 as FromId, 0 as ToId
union select '165787' as InvNumber, 4690 as FromId, 0 as ToId
union select '165421' as InvNumber, 4690 as FromId, 0 as ToId
union select '165775' as InvNumber, 4690 as FromId, 0 as ToId
union select '165424' as InvNumber, 4690 as FromId, 0 as ToId
union select '166459' as InvNumber, 4690 as FromId, 0 as ToId
union select '166050' as InvNumber, 4690 as FromId, 0 as ToId
union select '165234' as InvNumber, 4690 as FromId, 0 as ToId
union select '166065' as InvNumber, 4690 as FromId, 0 as ToId
union select '165621' as InvNumber, 4690 as FromId, 0 as ToId
union select '165423' as InvNumber, 4690 as FromId, 0 as ToId

union select '167340' as InvNumber, 4690 as FromId, 0 as ToId
union select '166889' as InvNumber, 4690 as FromId, 0 as ToId
union select '166490' as InvNumber, 4690 as FromId, 0 as ToId
union select '167037' as InvNumber, 4690 as FromId, 0 as ToId
union select '166461' as InvNumber, 4690 as FromId, 0 as ToId
union select '165799' as InvNumber, 4690 as FromId, 0 as ToId
union select '165644' as InvNumber, 4690 as FromId, 0 as ToId
union select '165451' as InvNumber, 4690 as FromId, 0 as ToId
union select '165791' as InvNumber, 4690 as FromId, 0 as ToId
union select '165430' as InvNumber, 4690 as FromId, 0 as ToId
union select '164892' as InvNumber, 4690 as FromId, 0 as ToId
union select '166498' as InvNumber, 4690 as FromId, 0 as ToId
union select '165796' as InvNumber, 4690 as FromId, 0 as ToId
union select '165649' as InvNumber, 4690 as FromId, 0 as ToId
union select '166464' as InvNumber, 4690 as FromId, 0 as ToId
union select '166275' as InvNumber, 4690 as FromId, 0 as ToId
union select '165772' as InvNumber, 4690 as FromId, 0 as ToId
union select '166063' as InvNumber, 4690 as FromId, 0 as ToId
union select '165790' as InvNumber, 4690 as FromId, 0 as ToId
union select '165425' as InvNumber, 4690 as FromId, 0 as ToId
union select '167527' as InvNumber, 4690 as FromId, 0 as ToId
union select '166460' as InvNumber, 4690 as FromId, 0 as ToId


select '157431' as InvNumber, 4690 as FromId, 0 as ToId
union select '157431' as InvNumber, 4690 as FromId, 0 as ToId
union select '157431' as InvNumber, 4690 as FromId, 0 as ToId
union select '157431' as InvNumber, 4690 as FromId, 0 as ToId
union select '157431' as InvNumber, 4690 as FromId, 0 as ToId
union select '157431' as InvNumber, 4690 as FromId, 0 as ToId
union select '157431' as InvNumber, 4690 as FromId, 0 as ToId
union select '154799' as InvNumber, 4690 as FromId, 0 as ToId
union select '154803' as InvNumber, 4690 as FromId, 0 as ToId
union select '154791' as InvNumber, 4690 as FromId, 0 as ToId
union select '154791' as InvNumber, 4690 as FromId, 0 as ToId
union select '154793' as InvNumber, 4690 as FromId, 0 as ToId
union select '159528' as InvNumber, 4690 as FromId, 0 as ToId
union select '159528' as InvNumber, 4690 as FromId, 0 as ToId
union select '159528' as InvNumber, 4690 as FromId, 0 as ToId
union select '159528' as InvNumber, 4690 as FromId, 0 as ToId
union select '159528' as InvNumber, 4690 as FromId, 0 as ToId
union select '159528' as InvNumber, 4690 as FromId, 0 as ToId
union select '159528' as InvNumber, 4690 as FromId, 0 as ToId
union select '159528' as InvNumber, 4690 as FromId, 0 as ToId
union select '159528' as InvNumber, 4690 as FromId, 0 as ToId
union select '159205' as InvNumber, 4690 as FromId, 0 as ToId
union select '159500' as InvNumber, 4690 as FromId, 0 as ToId
union select '159500' as InvNumber, 4690 as FromId, 0 as ToId
union select '159124' as InvNumber, 4690 as FromId, 0 as ToId
union select '159793' as InvNumber, 4690 as FromId, 0 as ToId
union select '159359' as InvNumber, 4690 as FromId, 0 as ToId
union select '159359' as InvNumber, 4690 as FromId, 0 as ToId
union select '159359' as InvNumber, 4690 as FromId, 0 as ToId
union select '159124' as InvNumber, 4690 as FromId, 0 as ToId
union select '159359' as InvNumber, 4690 as FromId, 0 as ToId
union select '159124' as InvNumber, 4690 as FromId, 0 as ToId
union select '159793' as InvNumber, 4690 as FromId, 0 as ToId
union select '159124' as InvNumber, 4690 as FromId, 0 as ToId
union select '159124' as InvNumber, 4690 as FromId, 0 as ToId
union select '159359' as InvNumber, 4690 as FromId, 0 as ToId
union select '159359' as InvNumber, 4690 as FromId, 0 as ToId
union select '159124' as InvNumber, 4690 as FromId, 0 as ToId
union select '159793' as InvNumber, 4690 as FromId, 0 as ToId
union select '159359' as InvNumber, 4690 as FromId, 0 as ToId
union select '159793' as InvNumber, 4690 as FromId, 0 as ToId
union select '159124' as InvNumber, 4690 as FromId, 0 as ToId
union select '159359' as InvNumber, 4690 as FromId, 0 as ToId
union select '159601' as InvNumber, 4690 as FromId, 0 as ToId
union select '159601' as InvNumber, 4690 as FromId, 0 as ToId
union select '159601' as InvNumber, 4690 as FromId, 0 as ToId
union select '159601' as InvNumber, 4690 as FromId, 0 as ToId
union select '159601' as InvNumber, 4690 as FromId, 0 as ToId
union select '159601' as InvNumber, 4690 as FromId, 0 as ToId
union select '159601' as InvNumber, 4690 as FromId, 0 as ToId
union select '159601' as InvNumber, 4690 as FromId, 0 as ToId
union select '159280' as InvNumber, 4690 as FromId, 0 as ToId
union select '159280' as InvNumber, 4690 as FromId, 0 as ToId
union select '159280' as InvNumber, 4690 as FromId, 0 as ToId
union select '04-300000165' as InvNumber, 4690 as FromId, 0 as ToId
union select '04-300000165' as InvNumber, 4690 as FromId, 0 as ToId
union select '156933' as InvNumber, 4690 as FromId, 0 as ToId
union select '158245' as InvNumber, 4690 as FromId, 0 as ToId
union select '158633' as InvNumber, 4690 as FromId, 0 as ToId
union select '154834' as InvNumber, 4690 as FromId, 0 as ToId
union select '159502' as InvNumber, 4690 as FromId, 0 as ToId
union select '156531' as InvNumber, 4690 as FromId, 0 as ToId
union select '156531' as InvNumber, 4690 as FromId, 0 as ToId
union select '159502' as InvNumber, 4690 as FromId, 0 as ToId
union select '159502' as InvNumber, 4690 as FromId, 0 as ToId
union select '155525' as InvNumber, 4690 as FromId, 0 as ToId
union select '159122' as InvNumber, 4690 as FromId, 0 as ToId
union select '159122' as InvNumber, 4690 as FromId, 0 as ToId
union select '159361' as InvNumber, 4690 as FromId, 0 as ToId
union select '157735' as InvNumber, 4690 as FromId, 0 as ToId
union select '159792' as InvNumber, 4690 as FromId, 0 as ToId
union select '158508' as InvNumber, 4690 as FromId, 0 as ToId
union select '159122' as InvNumber, 4690 as FromId, 0 as ToId
union select '155962' as InvNumber, 4690 as FromId, 0 as ToId
union select '159361' as InvNumber, 4690 as FromId, 0 as ToId
union select '159122' as InvNumber, 4690 as FromId, 0 as ToId
union select '159361' as InvNumber, 4690 as FromId, 0 as ToId
union select '159792' as InvNumber, 4690 as FromId, 0 as ToId
union select '159122' as InvNumber, 4690 as FromId, 0 as ToId
union select '159361' as InvNumber, 4690 as FromId, 0 as ToId
union select '159792' as InvNumber, 4690 as FromId, 0 as ToId
union select '159361' as InvNumber, 4690 as FromId, 0 as ToId
union select '159122' as InvNumber, 4690 as FromId, 0 as ToId
union select '159122' as InvNumber, 4690 as FromId, 0 as ToId
union select '159792' as InvNumber, 4690 as FromId, 0 as ToId
union select '156456' as InvNumber, 4690 as FromId, 0 as ToId
union select '159602' as InvNumber, 4690 as FromId, 0 as ToId
union select '159602' as InvNumber, 4690 as FromId, 0 as ToId
union select '159602' as InvNumber, 4690 as FromId, 0 as ToId
union select '155173' as InvNumber, 4690 as FromId, 0 as ToId
union select '159602' as InvNumber, 4690 as FromId, 0 as ToId
union select '158312' as InvNumber, 4690 as FromId, 0 as ToId
union select '159028' as InvNumber, 4690 as FromId, 0 as ToId
union select '159602' as InvNumber, 4690 as FromId, 0 as ToId
union select '157833' as InvNumber, 4690 as FromId, 0 as ToId
union select '155772' as InvNumber, 4690 as FromId, 0 as ToId
union select '159602' as InvNumber, 4690 as FromId, 0 as ToId
union select '159279' as InvNumber, 4690 as FromId, 0 as ToId
union select '158420' as InvNumber, 4690 as FromId, 0 as ToId
union select '155874' as InvNumber, 4690 as FromId, 0 as ToId
union select '159279' as InvNumber, 4690 as FromId, 0 as ToId
union select '158829' as InvNumber, 4690 as FromId, 0 as ToId
union select '159279' as InvNumber, 4690 as FromId, 0 as ToId
union select '04-300000293' as InvNumber, 4690 as FromId, 0 as ToId
union select '04-300000293' as InvNumber, 4690 as FromId, 0 as ToId
union select '04-300000293' as InvNumber, 4690 as FromId, 0 as ToId
union select '04-300000293' as InvNumber, 4690 as FromId, 0 as ToId
union select '04-300000293' as InvNumber, 4690 as FromId, 0 as ToId
union select '04-300000293' as InvNumber, 4690 as FromId, 0 as ToId
union select '04-300000293' as InvNumber, 4690 as FromId, 0 as ToId
union select '04-300000293' as InvNumber, 4690 as FromId, 0 as ToId
union select '04-300000293' as InvNumber, 4690 as FromId, 0 as ToId
union select '04-300000293' as InvNumber, 4690 as FromId, 0 as ToId
union select '156935' as InvNumber, 4690 as FromId, 0 as ToId
union select '156935' as InvNumber, 4690 as FromId, 0 as ToId
union select '154848' as InvNumber, 4690 as FromId, 0 as ToId
union select '156366' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '157637' as InvNumber, 4690 as FromId, 0 as ToId
union select '155208' as InvNumber, 4690 as FromId, 0 as ToId
union select '159937' as InvNumber, 4690 as FromId, 0 as ToId
union select '159934' as InvNumber, 4690 as FromId, 0 as ToId
union select '159937' as InvNumber, 4690 as FromId, 0 as ToId
union select '159934' as InvNumber, 4690 as FromId, 0 as ToId
union select '159937' as InvNumber, 4690 as FromId, 0 as ToId
union select '159937' as InvNumber, 4690 as FromId, 0 as ToId
union select '159937' as InvNumber, 4690 as FromId, 0 as ToId
union select '159937' as InvNumber, 4690 as FromId, 0 as ToId
union select '159934' as InvNumber, 4690 as FromId, 0 as ToId
union select '159937' as InvNumber, 4690 as FromId, 0 as ToId
union select '159937' as InvNumber, 4690 as FromId, 0 as ToId
union select '159934' as InvNumber, 4690 as FromId, 0 as ToId
union select '159937' as InvNumber, 4690 as FromId, 0 as ToId
union select '159934' as InvNumber, 4690 as FromId, 0 as ToId
union select '159937' as InvNumber, 4690 as FromId, 0 as ToId
union select '159937' as InvNumber, 4690 as FromId, 0 as ToId
union select '159937' as InvNumber, 4690 as FromId, 0 as ToId
union select '159934' as InvNumber, 4690 as FromId, 0 as ToId
union select '159937' as InvNumber, 4690 as FromId, 0 as ToId
union select '159937' as InvNumber, 4690 as FromId, 0 as ToId
union select '159934' as InvNumber, 4690 as FromId, 0 as ToId
union select '159934' as InvNumber, 4690 as FromId, 0 as ToId
union select '159937' as InvNumber, 4690 as FromId, 0 as ToId
union select '159934' as InvNumber, 4690 as FromId, 0 as ToId
union select '159937' as InvNumber, 4690 as FromId, 0 as ToId
union select '159937' as InvNumber, 4690 as FromId, 0 as ToId
union select '159937' as InvNumber, 4690 as FromId, 0 as ToId
union select '159937' as InvNumber, 4690 as FromId, 0 as ToId
union select '30' as InvNumber, 4690 as FromId, 0 as ToId
union select '28' as InvNumber, 4690 as FromId, 0 as ToId
union select '30' as InvNumber, 4690 as FromId, 0 as ToId
union select '30' as InvNumber, 4690 as FromId, 0 as ToId
union select '28' as InvNumber, 4690 as FromId, 0 as ToId
union select '30' as InvNumber, 4690 as FromId, 0 as ToId
union select '28' as InvNumber, 4690 as FromId, 0 as ToId
union select '157162' as InvNumber, 4690 as FromId, 0 as ToId
union select '158409' as InvNumber, 4690 as FromId, 0 as ToId
union select '156251' as InvNumber, 4690 as FromId, 0 as ToId
union select '157163' as InvNumber, 4690 as FromId, 0 as ToId
union select '159316' as InvNumber, 4690 as FromId, 0 as ToId
union select '159316' as InvNumber, 4690 as FromId, 0 as ToId
union select '158870' as InvNumber, 4690 as FromId, 0 as ToId
union select '159763' as InvNumber, 4690 as FromId, 0 as ToId
union select '159972' as InvNumber, 4690 as FromId, 0 as ToId
union select '159971' as InvNumber, 4690 as FromId, 0 as ToId
union select '159971' as InvNumber, 4690 as FromId, 0 as ToId
union select '159972' as InvNumber, 4690 as FromId, 0 as ToId
union select '159972' as InvNumber, 4690 as FromId, 0 as ToId
union select '159971' as InvNumber, 4690 as FromId, 0 as ToId
union select '159972' as InvNumber, 4690 as FromId, 0 as ToId
union select '159972' as InvNumber, 4690 as FromId, 0 as ToId
union select '159972' as InvNumber, 4690 as FromId, 0 as ToId
union select '159971' as InvNumber, 4690 as FromId, 0 as ToId
union select '159971' as InvNumber, 4690 as FromId, 0 as ToId
union select '159972' as InvNumber, 4690 as FromId, 0 as ToId
union select '159971' as InvNumber, 4690 as FromId, 0 as ToId
union select '159971' as InvNumber, 4690 as FromId, 0 as ToId
union select '159971' as InvNumber, 4690 as FromId, 0 as ToId
union select '159971' as InvNumber, 4690 as FromId, 0 as ToId
union select '17' as InvNumber, 4690 as FromId, 0 as ToId
union select '159971' as InvNumber, 4690 as FromId, 0 as ToId
union select '159971' as InvNumber, 4690 as FromId, 0 as ToId
union select '159971' as InvNumber, 4690 as FromId, 0 as ToId
union select '159972' as InvNumber, 4690 as FromId, 0 as ToId
union select '159971' as InvNumber, 4690 as FromId, 0 as ToId
union select '159971' as InvNumber, 4690 as FromId, 0 as ToId
union select '159972' as InvNumber, 4690 as FromId, 0 as ToId
union select '159971' as InvNumber, 4690 as FromId, 0 as ToId
union select '159971' as InvNumber, 4690 as FromId, 0 as ToId
union select '159971' as InvNumber, 4690 as FromId, 0 as ToId
union select '159972' as InvNumber, 4690 as FromId, 0 as ToId
union select '159972' as InvNumber, 4690 as FromId, 0 as ToId
union select '159972' as InvNumber, 4690 as FromId, 0 as ToId
union select '159971' as InvNumber, 4690 as FromId, 0 as ToId
union select '159930' as InvNumber, 4690 as FromId, 0 as ToId
union select '159569' as InvNumber, 4690 as FromId, 0 as ToId
union select '159932' as InvNumber, 4690 as FromId, 0 as ToId
union select '159932' as InvNumber, 4690 as FromId, 0 as ToId
union select '159932' as InvNumber, 4690 as FromId, 0 as ToId
union select '159932' as InvNumber, 4690 as FromId, 0 as ToId
union select '159930' as InvNumber, 4690 as FromId, 0 as ToId
union select '159932' as InvNumber, 4690 as FromId, 0 as ToId
union select '159576' as InvNumber, 4690 as FromId, 0 as ToId
union select '159932' as InvNumber, 4690 as FromId, 0 as ToId
union select '159932' as InvNumber, 4690 as FromId, 0 as ToId
union select '159932' as InvNumber, 4690 as FromId, 0 as ToId
union select '159932' as InvNumber, 4690 as FromId, 0 as ToId
union select '159930' as InvNumber, 4690 as FromId, 0 as ToId
union select '159569' as InvNumber, 4690 as FromId, 0 as ToId
union select '159932' as InvNumber, 4690 as FromId, 0 as ToId
union select '159955' as InvNumber, 4690 as FromId, 0 as ToId
union select '159954' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159954' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159954' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159954' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159954' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159954' as InvNumber, 4690 as FromId, 0 as ToId
union select '159954' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159954' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159954' as InvNumber, 4690 as FromId, 0 as ToId
union select '159954' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159954' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159954' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159954' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159954' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159953' as InvNumber, 4690 as FromId, 0 as ToId
union select '159959' as InvNumber, 4690 as FromId, 0 as ToId
union select '159959' as InvNumber, 4690 as FromId, 0 as ToId
union select '159959' as InvNumber, 4690 as FromId, 0 as ToId
union select '159959' as InvNumber, 4690 as FromId, 0 as ToId
union select '159959' as InvNumber, 4690 as FromId, 0 as ToId
union select '159959' as InvNumber, 4690 as FromId, 0 as ToId
union select '159959' as InvNumber, 4690 as FromId, 0 as ToId
union select '159959' as InvNumber, 4690 as FromId, 0 as ToId
union select '159959' as InvNumber, 4690 as FromId, 0 as ToId
union select '159958' as InvNumber, 4690 as FromId, 0 as ToId
union select '159958' as InvNumber, 4690 as FromId, 0 as ToId
union select '159958' as InvNumber, 4690 as FromId, 0 as ToId
union select '159958' as InvNumber, 4690 as FromId, 0 as ToId
union select '159958' as InvNumber, 4690 as FromId, 0 as ToId
union select '159958' as InvNumber, 4690 as FromId, 0 as ToId
union select '159958' as InvNumber, 4690 as FromId, 0 as ToId
union select '159958' as InvNumber, 4690 as FromId, 0 as ToId
union select '159958' as InvNumber, 4690 as FromId, 0 as ToId
union select '159958' as InvNumber, 4690 as FromId, 0 as ToId
union select '159940' as InvNumber, 4690 as FromId, 0 as ToId
union select '159940' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159940' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159940' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159940' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159940' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159940' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159940' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159940' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159940' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '159939' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155956' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155956' as InvNumber, 4690 as FromId, 0 as ToId
union select '155956' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155956' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155967' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155956' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155956' as InvNumber, 4690 as FromId, 0 as ToId
union select '155956' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155956' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '156099' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155956' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '155965' as InvNumber, 4690 as FromId, 0 as ToId
union select '159926' as InvNumber, 4690 as FromId, 0 as ToId
union select '159931' as InvNumber, 4690 as FromId, 0 as ToId
union select '159926' as InvNumber, 4690 as FromId, 0 as ToId
union select '159926' as InvNumber, 4690 as FromId, 0 as ToId
union select '159926' as InvNumber, 4690 as FromId, 0 as ToId
union select '159926' as InvNumber, 4690 as FromId, 0 as ToId
union select '159931' as InvNumber, 4690 as FromId, 0 as ToId
union select '159926' as InvNumber, 4690 as FromId, 0 as ToId
union select '159926' as InvNumber, 4690 as FromId, 0 as ToId
union select '159926' as InvNumber, 4690 as FromId, 0 as ToId
union select '159929' as InvNumber, 4690 as FromId, 0 as ToId
union select '159926' as InvNumber, 4690 as FromId, 0 as ToId
union select '159926' as InvNumber, 4690 as FromId, 0 as ToId
union select '159926' as InvNumber, 4690 as FromId, 0 as ToId
union select '159926' as InvNumber, 4690 as FromId, 0 as ToId
union select '159926' as InvNumber, 4690 as FromId, 0 as ToId
union select '159931' as InvNumber, 4690 as FromId, 0 as ToId
union select '159926' as InvNumber, 4690 as FromId, 0 as ToId
union select '159929' as InvNumber, 4690 as FromId, 0 as ToId
union select '159931' as InvNumber, 4690 as FromId, 0 as ToId
union select '159931' as InvNumber, 4690 as FromId, 0 as ToId
union select '159926' as InvNumber, 4690 as FromId, 0 as ToId
union select '159926' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '159919' as InvNumber, 4690 as FromId, 0 as ToId
union select '157374' as InvNumber, 4690 as FromId, 0 as ToId
union select '157374' as InvNumber, 4690 as FromId, 0 as ToId
union select '157374' as InvNumber, 4690 as FromId, 0 as ToId
union select '157374' as InvNumber, 4690 as FromId, 0 as ToId
union select '157374' as InvNumber, 4690 as FromId, 0 as ToId
union select '157374' as InvNumber, 4690 as FromId, 0 as ToId
union select '157374' as InvNumber, 4690 as FromId, 0 as ToId
union select '157374' as InvNumber, 4690 as FromId, 0 as ToId
union select '157380' as InvNumber, 4690 as FromId, 0 as ToId
union select '157380' as InvNumber, 4690 as FromId, 0 as ToId
union select '157380' as InvNumber, 4690 as FromId, 0 as ToId
union select '157380' as InvNumber, 4690 as FromId, 0 as ToId
union select '157380' as InvNumber, 4690 as FromId, 0 as ToId
union select '157380' as InvNumber, 4690 as FromId, 0 as ToId
union select '157380' as InvNumber, 4690 as FromId, 0 as ToId
union select '157380' as InvNumber, 4690 as FromId, 0 as ToId
union select '2' as InvNumber, 4690 as FromId, 0 as ToId
union select '2' as InvNumber, 4690 as FromId, 0 as ToId
union select '3613' as InvNumber, 4690 as FromId, 0 as ToId
union select '3613' as InvNumber, 4690 as FromId, 0 as ToId
union select '3613' as InvNumber, 4690 as FromId, 0 as ToId
union select '3613' as InvNumber, 4690 as FromId, 0 as ToId
union select '158201' as InvNumber, 4690 as FromId, 0 as ToId
union select '155474' as InvNumber, 4690 as FromId, 0 as ToId
union select '155474' as InvNumber, 4690 as FromId, 0 as ToId
union select '158201' as InvNumber, 4690 as FromId, 0 as ToId
union select '157630' as InvNumber, 4690 as FromId, 0 as ToId
union select '155474' as InvNumber, 4690 as FromId, 0 as ToId
union select '155474' as InvNumber, 4690 as FromId, 0 as ToId
union select '155474' as InvNumber, 4690 as FromId, 0 as ToId
union select '9' as InvNumber, 4690 as FromId, 0 as ToId
union select '155474' as InvNumber, 4690 as FromId, 0 as ToId
union select '155474' as InvNumber, 4690 as FromId, 0 as ToId
union select '157942' as InvNumber, 4690 as FromId, 0 as ToId
union select '155727' as InvNumber, 4690 as FromId, 0 as ToId
union select '159480' as InvNumber, 4690 as FromId, 0 as ToId
union select '159480' as InvNumber, 4690 as FromId, 0 as ToId
union select '159281' as InvNumber, 4690 as FromId, 0 as ToId
