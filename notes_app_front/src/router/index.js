import Vue from 'vue'
import Router from 'vue-router'
import Signin from '@/components/Signin.vue'
import Signup from '@/components/Signup.vue'
import Users from '@/components/users/Users.vue'
import User from '@/components/users/User.vue'
import Notes from '@/components/notes/Notes.vue'
import Note from '@/components/notes/Note.vue'

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
      path: '/users/:user_id',
      name: 'User',
      component: User
    },
    {
      path: '/notes',
      name: 'Notes',
      component: Notes
    },
    {
      path: '/notes/:note_id',
      name: 'Note',
      component: Note
    }
  ]
})
