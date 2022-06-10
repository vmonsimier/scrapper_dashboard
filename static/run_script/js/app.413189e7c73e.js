const routes = [
  { path: '/', component: scrappers },
  { path: '/logs', component: logs },
  { path: '/files', component: files_players }
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
