class Ability
   include CanCan::Ability

   def initialize(user)

      user ||= User.new
    
      if user.role == 'admin'
        can :manage, :all
      else
        can :create, User
        can :read, Group
        can :add_comments, Group
        can :read, Post
        can :add_comments, Post
        can :read, Page
        can :add_comments, Page
    end
   end
end
