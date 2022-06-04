const routes = [
  {path: '/', component: scrappers},
  {path: '/files', component: files}
]

const router = new VueRouter({
  mode:'history',
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
