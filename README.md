#Ants Republic
		
			power by amos

## change log

## 0806

		推荐蚁后(权重sort_no 从大到小), 在后台 用户-编辑, 设置 sort_no


## 0801
gem ransack 和 acts-as-messageable冲突，解决办法[参考](https://github.com/LTe/acts-as-messageable/pull/73#discussion-diff-23638195)

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


## queen search
```
curl -X GET -d "q=xxx" http://localhost/api/queens/search
```
## task creation
```
curl -X POST -d "task[dead_line]=2016-07-31&task[title]=title&task[description]=desc" http://localhost/api/needs/{need.id}/tasks
```
## task show
```
curl -X GET http://localhost/api/tasks/{task.id}
```
## task update
```
curl -X PATCH -d "task[dead_line]=2016-07-31&task[title]=title&task[description]=desc" http://localhost/api/tasks/{task.id}
```
## task list
```
curl -X GET http://localhost/api/needs/{need.id}/tasks
```
## task deletion
```
curl -X DELETE http://localhost/api/tasks/{task.id}
```
