class MembershipController < ApplicationController

  def new
    @group = Group.find(params[:group_id])
    @membership = current_user.memberships.build(:group_id => params[:group_id], :user_id => current_user.id)
  end

  def create
    @group = Group.find(params[:group_id])
  	@membership = current_user.memberships.build(:group_id => params[:group_id], :user_id => current_user.id)
    respond to do |format|
      if @member.save
        format.html { redirect_to @group, notice: 'You have successfully joined.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @membership = current_user.memberships.find(params[:id])
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'You have successfully left.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:group_id, :user_id)
    end
end
