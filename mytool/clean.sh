make clean
make
rm -rf .dircache
echo "helloxingkun" > xingkun.txt
./init-db
./update-cache xingkun.txt
# /home/ubuntu/git/.dircache/objects/0e/5818df3ec1d08e488a368c9a52a31ecfae92ae -> file content
# index
# Offset	Size	Name	Value	Description
# 0	4	signature	0x44495243	DIRC
# 4	4	version	0x00000001	
# 8	4	entries	0x00000001	1
# 12	20	sha1	0x3FE10A5CACCFF8966939D3A0D4AFC372EC08A911	calculate from header and entries
# 32	4	ctime_sec	0x64576C50	1683450960
# 36	4	ctime_nsec	0x3A5B48F1	979060977
# 40	4	mtime_sec	0x64576C50	1683450960
# 44	4	mtime_nsec	0x3A5B48F1	979060977
# 48	4	st_dev	0x00010301	66305
# 52	4	st_info	0x00040AD2	264914
# 56	4	st_mode	0x000081B4	33204
# 60	4	st_uid	0x000003E8	1000
# 64	4	st_gid	0x000003E8	1000
# 68	4	st_size	0x0000000D	13
# 72	20	sha1	0xAE92AECF1EA3529A8C368A488ED0C13EDF18580E	calc from metadata and content
# 92	2	namelen	0x000B	11
# 94	11	name	0x7478742E6E756B676E6978	xingkun.txt


./write-tree | tee /tmp/tree-sha1.txt
# /home/ubuntu/git/.dircache/objects/57/c3b0bfcbb86bdd2ba8c10ef8c52008a7a94aff -> tree object
# 	Offset	Size	Name	Value	Description
# +	0	5	tag	0x74726565	tree
# +	5	3	length	0x333900	39
# 8	39	content	0xAE92AECF1EA3529A8C368A488ED0C13EDF18580E007478742E6E756B676E697820343636303031	100664 xingkun.txtXß>ÁÐH6R£Ï®®


tree_sha1=$(cat /tmp/tree-sha1.txt)
./commit-tree $tree_sha1 < changelog
# /home/ubuntu/git/.dircache/objects/0e/3b6574546f2844bf856a1ef9f424a43bb15ae3 -> commit object
# Offset	Size	Name	Value	Description
# +	0	7	tag	0x636F6D6D6974	commit
# +	7	4	length	0x32303100	201
# 11	201	content		tree 57c3b0bfcbb86bdd2ba8c10ef8c52008a7a94aff author Ubuntu Sun May 7 09:50:54 2023 committer Ubuntu Sun May 7 09:50:54 2023 this is some change log
# 0x676F6C2065676E61686320656D6F7320736920736968740A0A333230322034353A30353A39302037202079614D206E7553203E36372D31332D31332D3237312D70694075746E7562753C2075746E7562552072657474696D6D6F630A333230322034353A30353A39302037202079614D206E7553203E36372D31332D31332D3237312D70694075746E7562753C2075746E75625520726F687475610A666661343961376138303032356338666530316338616232646462363862626366623062336337352065657274


echo "now change something and commit again"
echo "some change" >> xingkun.txt
./update-cache xingkun.txt
# /home/ubuntu/git/.dircache/objects/c9/ff72b01df9c1da14540eb732c7ad1431d38830 -> new file content
# index
# Offset	Size	Name	Value	Description
# 0	4	signature	0x44495243	DIRC
# 4	4	version	0x00000001	
# 8	4	entries	0x00000001	1
# 12	20	sha1	0x4854B8C8E880190A53AD9E6E7991B2AD411CB66C	calculate from header and entries
# 32	4	ctime_sec	0x645774C5	1683453125
# 36	4	ctime_nsec	0x2CF74ECD	754405069
# 40	4	mtime_sec	0x645774C5	1683453125
# 44	4	mtime_nsec	0x2CF74ECD	754405069
# 48	4	st_dev	0x00010301	66305
# 52	4	st_info	0x00040AD2	264914
# 56	4	st_mode	0x000081B4	33204
# 60	4	st_uid	0x000003E8	1000
# 64	4	st_gid	0x000003E8	1000
# 68	4	st_size	0x00000019	25
# 72	20	sha1	0x3088D33114ADC732B70E5414DAC1F91DB072FFC9	calc from metadata and content
# 92	2	namelen	0x000B	11
# 94	11	name	0x7478742E6E756B676E6978	xingkun.txt

./write-tree | tee /tmp/tree-sha1-v2.txt
# /home/ubuntu/git/.dircache/objects/73/4ce8b8ad15f60edd73d8c82194435e6c996496 -> new tree
# 	Offset	Size	Name	Value	Description
# +	0	5	tag	0x74726565	tree
# +	5	3	length	0x333900	39
# 8	39	content	0x3088D33114ADC732B70E5414DAC1F91DB072FFC9007478742E6E756B676E697820343636303031	100664 xingkun.txtÉÿr°ùÁÚT·2Ç­1Ó0

tree_sha1_v2=$(cat /tmp/tree-sha1-v2.txt)
./commit-tree $tree_sha1_v2 -p $tree_sha1 < changelogv2
# /home/ubuntu/git/.dircache/objects/f9/c2a8ffcaed77a502f0606519301b07516c8f33 -> new commit object
# Offset	Size	Name	Value	Description
# +	0	7	tag	0x636F6D6D6974	commit
# +	7	4	length	0x32353200	252
# 11	252	content	tree 734ce8b8ad15f60edd73d8c82194435e6c996496 parent 57c3b0bfcbb86bdd2ba8c10ef8c52008a7a94aff author Ubuntu Sun May 7 09:56:25 2023 committer Ubuntu Sun May 7 09:56:25 2023 this is another change log
# 0x676F6C2065676E61686320726568746F6E6120736920736968740A0A333230322035323A36353A39302037202079614D206E7553203E36372D31332D31332D3237312D70694075746E7562753C2075746E7562552072657474696D6D6F630A333230322035323A36353A39302037202079614D206E7553203E36372D31332D31332D3237312D70694075746E7562753C2075746E75625520726F687475610A6666613439613761383030323563386665303163386162326464623638626263666230623363373520746E657261700A363934363939633665353334343931323863386433376464653036663531646138623865633433372065657274	