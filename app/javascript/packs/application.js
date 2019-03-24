import jquery from 'jquery'
import Rails from 'rails-ujs'
import 'bootstrap'
import '../stylesheets/application.scss'

window.$ = jquery
window.jquery = jquery
window.jQuery = jquery

Rails.start()
