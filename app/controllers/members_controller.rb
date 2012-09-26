# -*- encoding : utf-8 -*-
class MembersController < ApplicationController
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
    notice = ""
    senha = gerar_senha

    @user = User.new
    @user.email = params[:email]
    @user.password = senha
    @user.password_confirmation = senha
    @user.save

    notice += " 2 "

    @member = Member.new
    @member.profile = @user

    @member.save

    notice += " 3 "

    MemberMailer.tell_user(@member).deliver

    notice += " 4 "

    redirect_to root_path, 
      :notice => 'Novo membro adicionado com sucesso'
  #rescue 
   #   flash[:notice] = notice + "Algum erro aconteceu"
   #   render :action => :new
    #  return
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

  def gerar_senha
    ('a'..'z').to_a.shuffle[0,8].join
  end
end
