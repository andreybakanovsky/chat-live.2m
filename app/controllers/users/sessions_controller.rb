# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    def destroy
      ActionCable.server.remote_connections.where(current_user:).disconnect
      current_user.offline!
      super
    end
  end
end
