module TasksHelper
	def create_canlendar_data_obj_string(tasks = [])
		@objString = ""
		@i = tasks.length

		tasks.each do |task|

			@objString += "'"+task.dead_line.strftime('%Y-%m-%d')+"':{}" if task.dead_line

			if @i != 1
				@objString += ","
			end

			@i = @i-1
		end

		return @objString
	end

	def getFirstTaskData(tasks = [])
		return tasks.at(0).dead_line if tasks.at(0)
	end
end
