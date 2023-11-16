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
    can :manage, Post, author: user
    can :manage, Comment, user: user
    can :manage, :all if user.role == 'Administrator'
    can :read, :all
  end
end
