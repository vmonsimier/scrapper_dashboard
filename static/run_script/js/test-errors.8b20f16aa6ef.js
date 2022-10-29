Vue.component('test-errors', {
    data() {
        return {
          tests: [],
          files: [],
          testToUpdate: {
            id: 0,
            name: "",
            path: "",
            file: ""
          }
        }
      },
      methods: {
        getTests() {
          axios.get(variables.API_URL + 'api/tests', {
            headers: {
              'Access-Control-Allow-Origin': "*"
            }
        })
            .then(response => {
              this.tests = response.data
            })
        },
        handleExecution: async function (path) {
          axios.post(variables.API_URL + "execute_test", {
            headers: {
              'Access-Control-Allow-Origin': "*"
            },
            body: { path: path }
          })
            .then(_ => {
              this.getTests()
            })
        },
        handleUpdate: async function () {
          if (this.testToUpdate.id && this.testToUpdate.name && this.testToUpdate.path) {
            axios.post(variables.API_URL + 'update_test', JSON.stringify(this.testToUpdate))
              .then(response => {
                this.getTests()
                this.testToUpdate = {
                  id: 0,
                  name: "",
                  path: "",
                  file: ""
                }
              })
          }
        },
        setId: function (id) {
          this.$set(this.testToUpdate, 'id', id)
        },
        setName: function (name) {
          this.$set(this.testToUpdate, 'name', name)
        },
        setPath: function (path) {
          this.$set(this.testToUpdate, 'path', path)
        },
        setFile: function (file) {
          this.$set(this.testToUpdate, 'file', file)
        },

        displayDateTime: function (datetime) {
          try {
            let date = datetime.toString().split('T')[0]
            let time = datetime.toString().split('T')[1].slice(0, 8)
      
            return date + ' - ' + time
          } catch(e) {
            return ''
          }
        }
      },
      mounted: function () {
        this.getTests();
      },
      template: `
      <div id="test-table-template">
        <template>
            <h1 class="block-title">Tests</h1>
            <v-simple-table>
              <template v-slot:default>
                  <thead>
                      <tr>
                          <th>Modifier</th>
                          <th>Name</th>
                          <th>Path</th>
                          <th>File</th>
                          <th>Last execution</th>
                          <th>Actions</th>
                      </tr>
                  </thead>
                  <tbody :key="">
                    <tr v-for="test in tests" :key="test.id">
                        <td>
                          <update-test-modal
                            v-bind:test-id="test.id"
                            v-bind:test-name="test.name"
                            v-bind:test-path="test.path"
                            v-bind:test-file="test.file"
                            v-on:setId="setId"
                            v-on:setName="setName"
                            v-on:setPath="setPath"
                            v-on:setFile="setFile"
                            v-on:updateTest="handleUpdate"
                          />
                        </td>
                        <td>{{test.name}}</td>
                        <td>{{test.path}}</td>
                        <td>{{test.file}}</td>
                        <td>{{ displayDateTime(test.last_execution) }}</td>
                        <td>
                            <v-btn
                              depressed
                              class="btn-execute"
                              v-on:click="handleExecution(test.path)"
                            >
                                Execute
                            </v-btn>
                        </td>
                    </tr>
                  </tbody>
              </template>
          </v-simple-table>
        </template>
      </div>
      `
})