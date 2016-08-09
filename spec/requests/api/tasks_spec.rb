require 'rails_helper'

RSpec.describe "tasks" do
  describe "POST #create" do
    it "create a new task" do
      Task.delete_all
      need = create(:need)
      valid_attributes = attributes_for(:task)
      post "/api/needs/#{need.id}/tasks/", {task: valid_attributes}
      expect(response).to be_success
      expect(response).to have_http_status(201)
      json = JSON.parse(response.body)
      expect(json["task_id"]).to eq Task.first.id
      expect(I18n.l(Task.first.dead_line)).to eq I18n.l(valid_attributes[:dead_line].to_date)
      expect(Task.first.title).to eq valid_attributes[:title]
      expect(Task.first.description).to eq valid_attributes[:description]
      # expect(Task.first.state).to eq valid_attributes[:state] #should be default state
      expect(Task.first.need_id).to eq need.id
    end
  end

  describe "GET #show" do
    it "get the requested task" do
      task = create(:task)
      get "/api/tasks/#{task.id}"
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["task"]
      expect(json["id"]).to eq task.id
      expect(json["dead_line"]).to eq I18n.l(task.dead_line)
      expect(json["title"]).to eq task.title
      expect(json["description"]).to eq task.description
      expect(json["state"]).to eq task.state
      expect(json["need_id"]).to eq task.need_id
    end
  end

  describe "PATCH #update" do
    it "update the attributes of the requested task" do
      task = create(:task)
      new_attributes = {
        dead_line: Date.today,
        title: "new_title",
        description: "new description",
      }
      patch "/api/tasks/#{task.id}", {task: new_attributes}
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["task"]
      expect(json["id"]).to eq task.id
      expect(json["title"]).to eq new_attributes[:title]
      expect(json["dead_line"]).to eq I18n.l(new_attributes[:dead_line])
      expect(json["description"]).to eq new_attributes[:description]
    end
  end

  describe "DELETE #destroy" do
    it "delete the requested task" do
      Task.delete_all
      task = create(:task)
      delete "/api/tasks/#{task.id}"
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(Task.count).to eq 0
    end
  end

  describe "GET #index" do
    it "get all tasks of some need" do
      Task.delete_all
      need = create(:need)
      task = create(:task, need_id: need.id)
      get "/api/needs/#{need.id}/tasks"
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["tasks"].first
      expect(json["id"]).to eq task.id
    end
  end
end