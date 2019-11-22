// import Vue from 'vue'
import Vue from 'vue/dist/vue.esm'
import VueRouter from 'vue-router'

import Loans from 'components/loans.vue'
import Loan from 'components/loan.vue'

Vue.use(VueRouter)

const routes = [
  { path: '/', component: Loans },
  { path: '/loans/:id', component: Loan },
]

const router = new VueRouter({
  routes
})

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    router
  }).$mount('#app')
})
