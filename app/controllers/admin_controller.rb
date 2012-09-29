# -*- encoding : utf-8 -*-
class AdminController < ApplicationController  
  before_filter :admin_only

  def index
  end
end
