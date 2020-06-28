<template>
  <div class="max-w-md m-auto py-10">
    <div class="text-red" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb4">All notes</h3>
    <form action="" @submit.prevent="addNote">
      <div class="mb-6">
        <input
          id="note_title"
          type="text"
          class="input"
          autofocus
          autocomplete="off"
          placeholder="Type a note title"
          v-model="newNote.title" />
      </div>
      <div class="mb-6">
        <input
          id="note_description"
          type="text"
          class="input"
          autofocus
          autocomplete="off"
          placeholder="Type a note description"
          v-model="newNote.description" />
      </div>
      <input type="submit" value="Add Note" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green hover:bg-green-dark block w-full py-4 text-white items-center justify-center" />
    </form>

    <hr class="border border-grey-light my-6" />

    <p class="pt-4">
        <router-link to="/notes" class="link-grey">Add a note</router-link>
      </p>

    <ul class="list-reset mt-4">
      <li class="py-4" v-for="note in notes" :key="note.id" :note="note">
        <div class="flex items-center justify-between flex-wrap">
          <p class="block flex-1 font-mono font-semibold flex items-center"></p>
          {{ note.title }}
        </div>
        <div class="flex items-center justify-between flex-wrap">
          <p class="block flex-1 font-mono font-semibold flex items-center"></p>
          {{ note.description }}
        </div>
        <button class="bg-tranparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 mr-2 rounded" @click.prevent="editNote(note)">Edit</button>

        <button class="bg-transprent text-sm hover:bg-red text-red hover:text-white no-underline font-bold py-2 px-4 rounded border border-red" @click.prevent="removeNote(note)">Delete</button>
        <div v-if="note == editedNote">
          <form action="" @submit.prevent="updateNote(note)">
            <div class="mb-6 p-4 bg-white rounded border border-grey-light mt-4">
              <input class="input" v-model="note.title" />
              <input class="input" v-model="note.description" />
              <input type="submit" value="Update" class=" my-2 bg-transparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 rounded cursor-pointer">
            </div>
          </form>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'Notes',
  data () {
    return {
      notes: [],
      newNote: [],
      error: '',
      editedNote: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.push('/')
      window.location.reload() // FIXME Need a better way of doing this
    } else {
      this.$http.secured.get('/api/v1/notes')
        .then(response => { this.notes = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addNote () {
      const value = this.newNote
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/notes/', { note: { title: this.newNote.title, description: this.newNote.description } })
        .then(response => {
          this.notes.push(response.data)
          this.newNote = ''
        })
        .catch(error => this.setError(error, 'Cannot create note'))
    },
    removeNote (note) {
      this.$http.secured.delete(`/api/v1/notes/${note.id}`)
        .then(response => {
          this.notes.splice(this.notes.indexOf(note), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete note'))
    },
    editUNote (note) {
      this.editedNote = note
    },
    updateNote (note) {
      this.editedNote = ''
      this.$http.secured.patch(`/api/v1/notes/${note.id}`, { note: { title: note.title, description: note.description } })
        .catch(error => this.setError(error, 'Cannot update note'))
    }
  }
}
</script>
