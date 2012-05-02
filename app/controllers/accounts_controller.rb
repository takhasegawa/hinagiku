class AccountsController < ApplicationController

  def update
    if current_user.update_attributes(params[:user])
      flash.notice = t("flash.accounts.update.notice")
      redirect_to :account
    else
      render :show
    end
  end

end
