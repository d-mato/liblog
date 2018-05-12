class Admin::CrawlerWorkersController < ApplicationController
  protect_from_forgery except: :create

  def create
    LibraryUser.pluck(:id).each { |id| CrawlerJob.perform_later(id) }
    head :ok
  end
end
