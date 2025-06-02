# frozen_string_literal: true

class HeavyTasksJob < ApplicationJob
  queue_as :default

  def perform(_current_user_id)
    total_count.times do |i|
      sleep rand
      Turbo::StreamsChannel.broadcast_replace_to ["heavy_task_channel", current_user.to_gid_param].join(":"),
                                                 target: "heavy_task",
                                                 partial: "heavy_tasks/progress",
                                                 locals: {
                                                   progress: (i + 1) * 100 / total_count
                                                 }
    end
    Turbo::StreamsChannel.broadcast_replace_to ["heavy_task_channel", current_user.to_gid_param].join(":"),
                                               target: "heavy_task",
                                               partial: "heavy_tasks/complete"
  end

  private

  def total_count
    @total_count ||= rand(5..20)
  end

  def current_user
    @current_user ||= User.find(arguments.first)
  end
end
