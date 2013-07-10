class UsersController < InheritedResources::Base

  def show
    @user = User.find(params[:id])
  end
end
