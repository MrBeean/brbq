module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    if current_user == nil
      username = 'Товарисч'
    else
      username = current_user.name
    end

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = t('errors.messages.not_saved',
                      count: resource.errors.count,
                      resource: username)

    html = <<-HTML
    <div class="alert alert-danger alert-dismissable">
      <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
      <div class="container">
        <h4>#{sentence}</h4>
        <p>#{messages}</p>
      </div>
    </div>
    HTML

    html.html_safe
  end
end