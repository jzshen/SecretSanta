class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])
    @group_members = Membership.where(group_id: params[:id]).all
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    respond_to do |format|
      if @group.save
        @membership = Membership.create!(group_id: @group.id, user_id: current_user.id, admin: true)
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def join
    @group = Group.find(params[:id])
    @membership = Membership.create(group_id: params[:id], user_id: current_user.id, admin: false)
    respond_to do |format|
      if @membership.save
        format.html { redirect_to @group, notice: 'You have joined this group.' }
        format.json { render :show, status: :ok, location: @group }
      else
        @group_members = Membership.where(group_id: params[:id]).all #sketchy
        format.html { render :show, notice: 'You have already joined this group' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def leave
    @group = Group.find(params[:id])
    @membership = Membership.find_by(group_id: params[:id], user_id: current_user.id)
    respond_to do |format|
      if @membership
        @membership.destroy
        format.html { redirect_to @group, notice: 'Bye Felicia!' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html {redirect_to @group, notice: 'You were never apart of this group'}
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end  
  end

  def match
    logger.info "matching again ..."
    @group = Group.find(params[:id])
    @group_members_id = Membership.where(group_id: params[:id]).pluck(:user_id)
    @taken = Array.new
    @available = Membership.where(group_id: params[:id]).pluck(:user_id)
    @matches = Hash.new
    logger.info @group_members_id.to_s
    @group_members_id.each do |id|
      logger.info "ID: " + id.to_s + "\n"
      @available.delete(id)
      match_id = @available.sample(1).pop
      logger.info "MATCH: " + match_id.to_s + "\n"
      @taken << match_id
      @matches[id] = match_id
      if !@taken.include? id
        @available.push(id)
      end
    end
    @group.update(:matches => @matches)
    @group.updated(:matched => true)
    respond_to do |format|
        format.html { redirect_to @group, notice: 'Matches created.' }
        format.json { render :show, status: :ok, location: @group }
    end
  end

  def mymatch
    @group = Group.find(params[:id])
    @match = User.find(@group.matches[current_user.id]).first_name
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name)
    end
end
