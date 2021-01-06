import jQuery from 'jquery'
import Rails from 'rails-ujs'
import '../libs/bootstrap'
import '../stylesheets/application.scss'

import Vue from 'vue'
import Calendar from 'components/calendar.vue'

window.$ = jQuery
window.jQuery = jQuery

Rails.start()

document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.calendar-container').forEach(el => {
    new Vue({
      el,
      render: h => h(Calendar)
    })
  })
})
