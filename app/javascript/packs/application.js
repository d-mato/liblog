import Rails from 'rails-ujs'
import '../libs/bootstrap'
import '../stylesheets/application.scss'

import Vue from 'vue'
import Calendar from 'components/calendar.vue'

Rails.start()

document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.calendar-container').forEach(el => {
    new Vue({
      el,
      render: h => h(Calendar)
    })
  })

  // auto-rezie textarea
  const autoResize = function(e) {
    e.target.style.height = 'auto'
    e.target.style.height = `${e.target.scrollHeight}px`
  }
  document.querySelectorAll('textarea').forEach(textarea => {
    textarea.addEventListener('input', autoResize)
    textarea.addEventListener('focus', autoResize)
  })
})
