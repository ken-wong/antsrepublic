#Ants Republic
		
			power by amos

## change log

## 0731
		
		MySQL外键 Cannot add or update a child row错误的实例解释

		https://www.evernote.com/shard/s18/sh/61a6be96-8031-41cc-a3e2-594bfe884291/80a4efa1bc6d2abf697fd06e5a107d5f

		`
			 1  mysql >  show  create   table  xiaodi;
			 2    
			 3     CONSTRAINT  `xiaodi_ibfk_1`  FOREIGN   KEY  (`dage_id`)  REFERENCES  `dage` (`id`)
			 4    
			 5  mysql >   alter   table  xiaodi  drop   foreign   key  xiaodi_ibfk_1; 
			 6  Query OK,  1  row affected ( 0.04  sec)
			 7  Records:  1   Duplicates:  0   Warnings: 
			 8  mysql >   alter   table  xiaodi  add   foreign   key (dage_id)  references  dage(id)  on   delete   cascade   on   update   cascade ;
			 9  Query OK,  1  row affected ( 0.04  sec)
			10  Records:  1   Duplicates:  0   Warnings:  0
		`

## 0722
	
		1 用户可以直接注册, 访客身份
		2 用户可以认证甲方或则蚁后
		3 ants.easybird.cn/admin 后台登录, 可以对申请的user 认证审核

## feature change user role
		
		http://www.cnblogs.com/zs-note/p/4256226.html

* add gallery silde
		
		https://github.com/blueimp/Gallery




