def set_current_user_admin
  ApplicationController.class_eval do
    @old_get_current_user = instance_method :get_current_user
    def get_current_user
      @user = User.create({
        username: 'admin',
        email: 'admin@example.com',
        password: 'test',
        password_confirmation: 'test',
        admin: true
      })
    end
  end
end

def set_current_user_cleanup
  ApplicationController.class_eval do
    define_method :get_current_user, @old_get_current_user
  end
end

def require_logged_in_test_def
  ApplicationController.class_eval do
    @old_require_logged_in = instance_method :require_logged_in
    def require_logged_in
      puts "require logged in called"
    end
  end
end

def require_admin_test_def
  ApplicationController.class_eval do
    @old_require_admin = instance_method :require_admin
    def require_admin
      puts "require admin called"
    end
  end
end

def require_logged_in_cleanup
  ApplicationController.class_eval do
    define_method :require_logged_in, @old_require_logged_in
  end
end

def require_admin_cleanup
  ApplicationController.class_eval do
    define_method :require_admin, @old_require_admin
  end
end
