module TasksHelper

  def attachment(task)
    return unless task.file.present?
    url = task.file.url
    return image_tag(url, width: '125px', alt: task.name) if task.file.image?
    link_to 'Download', url
  end

  TASK_STATE_LABELS = {
      new: 'warning',
      started: 'info',
      finished: 'success'
  }.freeze

  def show_task_state(task)
    state = Task.human_attribute_name("state.#{task.state}")
    css_class = TASK_STATE_LABELS[task.state_name]
    "<span class='label label-#{css_class}'>#{state}</span>"
  end

end
