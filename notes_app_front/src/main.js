// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
// import Vuex from 'vuex'
import App from './App'
import router from './router'
import VueAxios from 'vue-axios'
import { securedAxiosInstance, plainAxiosInstance } from './backend/axios'
import VuePaginate from 'vue-paginate'

import '@/assets/css/main.css'

Vue.config.productionTip = false

Vue.use(VueAxios, {
  secured: securedAxiosInstance,
  plain: plainAxiosInstance
})

Vue.use(VuePaginate)

// Vue.use(Vuex)

/* const store = new Vuex.Store({
  state: {
    count: 0
  },
  mutations: {
    initialiseStore (state) {
      // Check if the ID exists
      if (localStorage.getItem('store')) {
        // Replace the state object with the stored item
        this.replaceState(
          Object.assign(state, JSON.parse(localStorage.getItem('store')))
        )
      }
    }
  },
  getters: {}
})

store.subscribe((mutation, state) => {
  // Store the state object as a JSON string
  localStorage.setItem('store', JSON.stringify(state))
}) */

/* eslint-disable no-new */
new Vue({
  el: '#app',
  /* store: store,
  beforeCreate () {
    this.$store.commit('initialiseStore')
  }, */
  router,
  securedAxiosInstance,
  plainAxiosInstance,
  components: { App },
  template: '<App/>'
})
