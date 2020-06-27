import Vue from 'vue'
import Router from 'vue-router'
import Signin from '@/components/Signin.vue'
import Signup from '@/components/Signup.vue'
import Users from '@/components/users/Users.vue'
import Notes from '@/components/notes/Notes.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Signin',
      component: Signin
    },
    {
      path: '/signup',
      name: 'Signup',
      component: Signup
    },
    {
      path: '/users',
      name: 'Users',
      component: Users
    },
    {
      path: '/notes',
      name: 'Notes',
      component: Notes
    }
  ]
})
