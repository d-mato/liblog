class Admin::CrawlerWorkersController < ApplicationController
  protect_from_forgery except: :create

  def create
    LibraryUser.pluck(:id).each { |id| CrawlerJob.perform_now(id) }
    head :ok
  end
end
