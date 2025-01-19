module HandleServiceErrors
  extend ActiveSupport::Concern

  included do
    def handle_error(message, redirect_path)
      flash[:notice] = message
      redirect_to redirect_path
    end
  end
end
