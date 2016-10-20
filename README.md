#Ants Republic
		
			power by amos

#TODO
	
	1. amdin消息通知(项目状态变更, 认证状态变更)

## change log

## 1019
need convert_to_queen_work

```
curl -X GET http://localhost/api/needs/{need.id}/convert_to_queen_work
```


##1018

api:
	1. api/needs/:id/vote_to_me 
		
		action: POST
```
		curl -X POST -d "voter_id=1" -d "speedStars=3" -d "qualityStars=3" -d "serviceStars=3"  http://localhost:3000/api/needs/4/vote_to_me
```
		return:
		{"vote_speed":0,"vote_quality":0,"vote_service":3}%

	2. api/needs/:id/vote_sum 

		action: GET
```
		curl -X GET http://localhost:3000/api/needs/4/vote_sum
```		
		return:
		{"vote_speed":0,"vote_quality":0,"vote_service":3}%


##0903
api:
	
	1. home page, 案例輸出12個

		curl http://localhost:3000/api/queen_works.json?category={'效果图'|'影片'|多媒体'}&page={0...page_num}

	2 home page, queens

		curl http://localhost:3000/api/queens.json?page={page_num}


## 0823
update attachment api

## 0819
banner index
	
		admin banner 添加, api获取路径

```
curl -X GET http://localhost/api/banners
```

## 0818
attachment index

```
curl -X GET http://localhost/api/tasks/{task.id}/attachments
or
curl -X GET http://localhost/api/queen_works/{queen_work.id}/attachments
```

attachment create: resource[task|queen_work]

```
curl -F "attachment[file]=@{file_path/file_name}" -F 'attachment[title]=xxxx' http://localhost/api/tasks/{task.id}/attachments
or
curl -F "attachment[file]=@{file_path/file_name}" -F 'attachment[title]=xxxx' http://localhost/api/queen_works/{queen_work.id}/attachments
```

attachment show

```
curl -X GET http://localhost/api/tasks/{task.id}/attachments/{attachment.id}
curl -X GET http://localhost/api/queen_works/{queen_work.id}/attachments/{attachment.id}
```

attachment destroy

```
curl -X DELETE http://localhost/api/tasks/{task.id}/attachments/{attachment.id}
curl -X DELETE http://localhost/api/queen_works/{queen_work.id}/attachments/{attachment.id}

```


## 0815
queen_works search

```
curl -X GET -d "q=xxx" http://localhost/api/queen_works/search
```

queen_works following_list
```
curl -X GET -d "user_id=1" http://localhost/api/queen_works/following_list
```


## 0811
Plan: title, dead_line, state

		state: closed, open[default:open]

## plan creation
```
curl -X POST -d "plan[dead_line]=2016-07-31&plan[title]=title&plan[state]=desc" http://localhost/api/needs/{need.id}/plans
```
## plan show
```
curl -X GET http://localhost/api/plan/{plan.id}
```
## plan update
```
curl -X PATCH -d "plan[dead_line]=2016-07-31&plan[title]=title&plan[state]=desc" http://localhost/api/plans/{plan.id}
```
## plan list
```
curl -X GET http://localhost/api/needs/{need.id}/plans
```
## plan deletion
```
curl -X DELETE http://localhost/api/plan/{plan.id}
```


## 0806

		推荐蚁后(权重sort_no 从大到小), 在后台 用户-编辑, 设置 sort_no


## 0801
gem ransack 和 acts-as-messageable冲突，解决办法[参考](https://github.com/LTe/acts-as-messageable/pull/73#discussion-diff-23638195)

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
