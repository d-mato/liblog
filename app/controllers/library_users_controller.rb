class LibraryUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_library_user, only: %i(edit update destroy activate)

  def index
    @library_users = current_user.library_users.order(id: :asc)
  end

  def new
    @library_user = LibraryUser.new
  end

  def create
    @library_user = current_user.library_users.new(library_user_params)
    if @library_user.save
      redirect_to library_users_path, notice: '連携設定を追加しました'
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @library_user.update(library_user_params)
        format.html { redirect_to @library_user, notice: 'Library user was successfully updated.' }
        format.json { render :show, status: :ok, location: @library_user }
      else
        format.html { render :edit }
        format.json { render json: @library_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @library_user.destroy!
    redirect_to library_users_url
  end

  def activate
    if request.patch?
      @library_user.update!(active: true)
    elsif request.delete?
      @library_user.update!(active: false)
    end

    redirect_to library_users_url
  end

  private

  def set_library_user
    @library_user = current_user.library_users.find(params[:id])
  end

  def library_user_params
    params.require(:library_user).permit(%i(library_id sign_in_id password active))
  end
end
