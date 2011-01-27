authorization do
  
  role :owner do
    has_permission_on :projects, :to => [:manage, :join]
    has_permission_on :statusupdates, :to => [ :read, :new, :create ]
    has_permission_on :statusupdates, :to => :delete do
      if_attribute :user => is { user }
    end   
  end
  
  role :leader do
    has_permission_on :projects, :to => [ :manage, :leave ]
  end
  
  role :member do
    has_permission_on :projects, :to => [ :read, :leave ]
    has_permission_on :statusupdates, :to => [ :read, :new, :create ]
    has_permission_on :statusupdates, :to => :delete do
      if_attribute :user => is { user }
    end
  end
  
  role :follower do
    has_permission_on :projects, :to => [ :show, :unfollow, :join ]
    has_permission_on :statusupdates, :to => :read
  end
  
  role :guest do
    has_permission_on :projects, :to => [ :read, :follow, :join ] do
      if_attribute :isPublic => is { true }
    end
    has_permission_on :projects, :to => :create
    has_permission_on :users, :to => :manage do
      if_attribute :id => is { user.id }
    end
    
  end
  
end

privileges do
  
  privilege :read do
    includes :index, :show
  end
  
  privilege :create do
    includes :new, :create
  end
  
  privilege :manage do
    includes :read, :edit, :update
  end
  
end