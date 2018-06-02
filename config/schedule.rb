every 6.hours do
  rake 'crawler:exec'
end

every 1.day, at: '18:30' do
  rake 'notifier:return_date'
end
