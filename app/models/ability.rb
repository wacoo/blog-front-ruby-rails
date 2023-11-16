class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end

    can :destroy, Post, author_id: user.id
    can :destroy, Comment, user_id: user.id
    return unless user.role == 'Administrator'

    can :destroy, Post
    can :destroy, Comment
  end
end
