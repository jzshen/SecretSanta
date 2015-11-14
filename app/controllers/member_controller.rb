class MemberController < ApplicationController
  
  def create
  	@member = current_user.members.build(:group_id => params[:group_id], :user_id => current_user.id)
    if @member.save
      flash[:notice] = "You have joined this group."
      redirect_to :back
    else
      flash[:error] = "Unable to join."
      redirect_to :back
    end
  end

  def destroy
    @member = current_user.memberships.find(params[:id])
    @member.destroy
    flash[:notice] = "Removed membership."
        redirect_to :back
  end

end
