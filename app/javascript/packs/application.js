import jQuery from 'jquery'
import Rails from 'rails-ujs'
import '../libs/bootstrap'
import '../stylesheets/application.scss'

window.$ = jQuery
window.jQuery = jQuery

Rails.start()
