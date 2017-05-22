module SubscriptionsHelper
  def user_not_subscribed?
    if current_user.present?
      Subscription.where(user_email: current_user.email).present?
    else
      true
    end
  end
end
