authorization do
  
  role :owner do
    has_permission_on :projects, :to => [:index, :show, :edit, :create, :update]   
  end
  
  role :leader do
    has_permission_on :projects, :to => :manage
  end
  
  role :member do
    has_permission_on :projects, :to => :show
    has_permission_on :statusupdates, :to => [:show, :new, :create]
    has_permission_on :statusupdates, :to => :delete do
      if_attribute :user => is { user }
    end
  end
  
  role :follower do
    has_permission_on :projects, :to => :show
    has_permission_on :statusupdates, :to => :read
  end
  
  role :guest do
    has_permission_on :projects, :to => :read do
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
    includes :read, :edit, :update, :delete 
  end
  
end