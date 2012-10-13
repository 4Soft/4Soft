# -*- encoding : utf-8 -*-
class MembersController < ApplicationController
  
  before_filter :admin_only, :only => [:new, :create, :destroy]
  before_filter :member_only, :only => [:edit, :update]

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new
    @member.profile = User.new
  end

  def create
    if Member.create(params[:email])
      redirect_to root_path, 
        :notice => 'Novo membro adicionado com sucesso'
    else
      flash[:notice] = "Algum erro aconteceu"
      render :action => :new
    end
  end

  def edit
    @member = current_user.profileable
  end

  def update
    @member = current_user.profileable
    @member.update_attributes(params[:member].except(:profile_attributes))

    if params[:member][:profile_attributes][:password] != ""
      #caso haja algum erro em atualizar a profile, dispare uma excecao
      if not @member.profile.update_attributes(
        params[:member][:profile_attributes])
        raise new Exception
      end
    end

    flash[:notice] = "Membro salvo com sucesso"
    redirect_to members_path
  rescue
    flash[:notice] = "Algum erro aconteceu"
    render :action => :edit
  end

  def destroy
  end  
end
