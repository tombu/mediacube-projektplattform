authorization do
  
  role :owner do
    has_permission_on :projects, :to => [:manage, :join]
    has_permission_on :statusupdates, :to => [ :read, :new, :create ]
    has_permission_on :statusupdates, :to => :delete do
      if_attribute :user => is { user }
    end   
    has_permission_on :media, :to => [ :read, :create, :destroy ]
  end
  
  role :leader do
    has_permission_on :projects, :to => [ :manage, :leave, :join ]
  end
  
  role :member do
    has_permission_on :projects, :to => [ :read, :leave ]
    has_permission_on :statusupdates, :to => [ :read, :new, :create ]
    has_permission_on :statusupdates, :to => :delete do
      if_attribute :user => is { user }
    end
    has_permission_on :media, :to => [ :read, :create ]
  end
  
  role :follower do
    has_permission_on :projects, :to => [ :show, :unfollow, :apply, :join ]
    has_permission_on :statusupdates, :to => :read
  end
  
  role :guest do
    has_permission_on :projects, :to => [ :read, :follow, :apply, :join ] do
      if_attribute :isPublic => is { true }
    end
    has_permission_on :projects, :to => :create
    has_permission_on :users, :to => :manage do
      if_attribute :id => is { user.id }
    end
    has_permission_on :users, :to => :read
    
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