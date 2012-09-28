# -*- encoding : utf-8 -*-
class MembersController < ApplicationController

  before_filter :authenticate_user!, :except => [:show, :index]
  
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
    password = generate_password

    @user = User.new
    @user.email = params[:email]
    @user.password = password
    @user.password_confirmation = password
    @user.save

    @member = Member.new
    @member.profile = @user

    @member.save

    MemberMailer.tell_user(@member).deliver

    redirect_to root_path, 
      :notice => 'Novo membro adicionado com sucesso'
  rescue 
      flash[:notice] = notice + "Algum erro aconteceu"
      render :action => :new
  end

  #pode ser gambiarra, olhar isso ae
  def edit
    #nao importa a id passada, sempre editara apenas o membro logado
    @member = current_user.profileable
  end

  #pode ser gambiarra, olhar isso ae
  def update
    #nao importa a id passada, sempre editara apenas o membro logado
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

  private
  #colocar isso em algum lugar mais decente
  def admin_only
    unless current_user.profileable_type == "Admin"
      flash[:notice] = "Permissão negada"
      redirect_to members_path
    end
  end

  def member_only
    unless current_user.profileable_type == "Member"
      flash[:notice] = "Permissão negada"
      redirect_to members_path
    end
  end
end
