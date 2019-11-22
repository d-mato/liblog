// import Vue from 'vue'
import Vue from 'vue/dist/vue.esm'
import VueRouter from 'vue-router'

import Top from 'components/top.vue'

Vue.use(VueRouter)

const Foo = { template: '<div>foo</div>' }
const Bar = { template: '<div>bar</div>' }

const routes = [
  { path: '/', component: Top },
  { path: '/foo', component: Foo },
  { path: '/bar', component: Bar }
]

const router = new VueRouter({
  routes
})

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    router
  }).$mount('#app')
})
