class LibraryUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_library_user, only: [:show, :edit, :update, :destroy]

  # GET /library_users
  # GET /library_users.json
  def index
    @library_users = current_user.library_users
  end

  # GET /library_users/1
  # GET /library_users/1.json
  def show
  end

  # GET /library_users/new
  def new
    @library_user = LibraryUser.new
  end

  # GET /library_users/1/edit
  def edit
  end

  # POST /library_users
  # POST /library_users.json
  def create
    @library_user = LibraryUser.new(library_user_params)

    respond_to do |format|
      if @library_user.save
        format.html { redirect_to @library_user, notice: 'Library user was successfully created.' }
        format.json { render :show, status: :created, location: @library_user }
      else
        format.html { render :new }
        format.json { render json: @library_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /library_users/1
  # PATCH/PUT /library_users/1.json
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

  # DELETE /library_users/1
  # DELETE /library_users/1.json
  def destroy
    @library_user.destroy
    respond_to do |format|
      format.html { redirect_to library_users_url, notice: 'Library user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library_user
      @library_user = LibraryUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def library_user_params
      params.fetch(:library_user, {})
    end
end
