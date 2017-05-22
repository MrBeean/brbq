class SubscriptionsController < ApplicationController
  # Задаем «родительский» event для подписки
  before_action :set_event, only: [:create, :destroy]

  # Задаем подписку, которую юзер хочет удалить
  before_action :set_subscription, only: [:destroy]

  # Проверяем если текущий юзер, то возвращаем текущее собитие
  before_action :self_subscription, only: [:create]

  # Проверяем если email уже есть, то возвращаем текущее собитие
  before_action :email_checker, only: [:create]

  def create
    # Болванка для новой подписки
    @new_subscription = @event.subscriptions.build(subscription_params)
    @new_subscription.user = current_user

    if @new_subscription.save
      # Если сохранилась успешно, редирект на страницу самого события
      redirect_to @event, notice: I18n.t('controllers.subscriptions.created')
    else
      # если ошибки — рендерим здесь же шаблон события
      render 'events/show', alert: I18n.t('controllers.subscriptions.error')
    end
  end

  def destroy
    message = {notice: I18n.t('controllers.subscriptions.destroyed')}

    if current_user_can_edit?(@subscription)
      @subscription.destroy
    else
      message = {alert: I18n.t('controllers.subscriptions.error')}
    end

    redirect_to @event, message
  end

  private

  def set_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def subscription_params
    # .fetch разрешает в params отсутствие ключа :subscription
    params.fetch(:subscription, {}).permit(:user_email, :user_name)
  end

  def self_subscription
    redirect_to @event, alert: I18n.t('controllers.subscriptions.same_user') if @event.user == current_user
  end

  def email_checker
    new_user_email = params[:subscription][:user_email]
    check_subscripton_email = Subscription.where(user_email: new_user_email).present?
    check_user_email = User.where(email: new_user_email).present?

    if check_user_email
      redirect_to new_user_session_path, alert: I18n.t('controllers.subscriptions.user_exist')
    else check_subscripton_email
      redirect_to @event, alert: I18n.t('controllers.subscriptions.email_exist')
    end
  end
end
