module SubscriptionsHelper
  def user_not_subscribed?
    if current_user.present?
      Subscription.where(user: current_user).blank?
    else
      true
    end
  end
end
