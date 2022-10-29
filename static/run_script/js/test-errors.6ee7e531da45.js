Vue.component('test-errors', {
    data() {
        return {
          tests: [],
          files: [],
          testToUpdate: {
            id: 0,
            name: "",
            path: "",
            enable: false,
            selectedFile: ""
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
        getFiles() {
          
        },
        handleExecution: async function (path) {
          axios.post(variables.API_URL + "execute_scrapper", {
            headers: {
              'Access-Control-Allow-Origin': "*"
            },
            body: { path: path }
          })
            .then(_ => {
              this.getScrappers()
            })
        },
        // handleUpdate: async function () {
        //   if (this.testToUpdate.id && this.testToUpdate.name && this.testToUpdate.path) {
        //     axios.post(variables.API_URL + 'update_scrapper', JSON.stringify(this.testToUpdate))
        //       .then(response => {
        //         // this.getScrappers()
        //         this.testToUpdate = {
        //           id: 0,
        //           name: "",
        //           path: "",
        //           enable: false,
        //           selectedFile: ""
        //         }
        //       })
        //   }
        // },
        // setId: function (id) {
        //   this.$set(this.scrapperToUpdate, 'id', id)
        // },
        // setName: function (name) {
        //   this.$set(this.scrapperToUpdate, 'name', name)
        // },
        // setPath: function (path) {
        //   this.$set(this.scrapperToUpdate, 'path', path)
        // },
        // setEnable: function (enable) {
        //   this.$set(this.scrapperToUpdate, 'enable', enable)
        // },
        // setActiveFile: function (selectedLeagues) {
        //   this.$set(this.scrapperToUpdate, 'selectedLeagues', selectedLeagues)
        // },
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
        this.getFiles();
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
                        <td></td>
                        <td>{{test.name}}</td>
                        <td>{{test.path}}</td>
                        <td>{{test.file}}</td>
                        <td>{{ displayDateTime(test.last_execution) }}</td>
                        <td>
                            <v-btn
                              depressed
                              class="btn-execute"
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