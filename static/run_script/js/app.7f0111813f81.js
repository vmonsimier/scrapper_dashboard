const routes = [
  { path: '/', component: scrappers },
  { path: '/logs', component: null }
]

const router = new VueRouter({
  mode: 'history',
  routes
})

const app = new Vue({
  router,
  vuetify: new Vuetify({
    icons: {
      iconfont: 'mdi',
    }
  })
}).$mount('#vue-app')
