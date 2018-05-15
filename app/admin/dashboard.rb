ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  page_action :start_crawler, method: :post do
    LibraryUser.active.pluck(:id).each { |id| CrawlerJob.perform_now(id) }
    redirect_to admin_root_path, notice: 'Finished crawling'
  end

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      a href: admin_dashboard_start_crawler_path, 'data-method': :post do
        'Start crawler'
      end
    end
  end
end
