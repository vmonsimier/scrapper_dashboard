const scrappers = {
  data() {
    return {
      scrappers: [],
      scrapperToUpdate: {
        id: 0,
        name: "",
        path: "",
        enable: false,
        selectedLeagues: [],
        selectedSeasons: []
      }
    }
  },
  methods: {
    getScrappers() {
      axios.get(variables.API_URL + 'fapi/scrappers')
        .then(response => {
          this.scrappers = response.data
        })
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
    stopExecution: async function (path) {
      axios.post(variables.API_URL + "stop_scrapper", {
        headers: {
          'Access-Control-Allow-Origin': "*"
        },
        body: { path: path }
      })
        .then(r => this.getScrappers())
    },
    handleUpdate: async function () {
      if (this.scrapperToUpdate.id && this.scrapperToUpdate.name && this.scrapperToUpdate.path) {
        axios.post(variables.API_URL + 'update_scrapper', JSON.stringify(this.scrapperToUpdate))
          .then(response => {
            this.getScrappers()
            this.scrapperToUpdate = {
              id: 0,
              name: "",
              path: "",
              enable: false,
              selectedLeagues: [],
              selectedSeasons: [],
              updateKey: 0
            }
          })
      }
    },
    setId: function (id) {
      this.$set(this.scrapperToUpdate, 'id', id)
    },
    setName: function (name) {
      this.$set(this.scrapperToUpdate, 'name', name)
    },
    setPath: function (path) {
      this.$set(this.scrapperToUpdate, 'path', path)
    },
    setEnable: function (enable) {
      this.$set(this.scrapperToUpdate, 'enable', enable)
    },
    setActiveSeasons: function (selectedSeasons) {
      this.$set(this.scrapperToUpdate, 'selectedSeasons', selectedSeasons)
    },
    setActiveLeagues: function (selectedLeagues) {
      this.$set(this.scrapperToUpdate, 'selectedLeagues', selectedLeagues)
    },
    displayDateTime: function (datetime) {
      let date = datetime.toString().split('T')[0]
      let time = datetime.toString().split('T')[1].slice(0, 8)

      return date + ' - ' + time
    }
  },
  mounted: function () {
    this.getScrappers();
  },
  template: `
  <div id="scrapper-table-template">
    <template>
        <h1 class="block-title">Run scrappers</h1>
        <v-simple-table>
          <template v-slot:default>
              <thead>
                  <tr>
                      <th>Modifier</th>
                      <th>Name</th>
                      <th>Path</th>
                      <th>Execution</th>
                      <th>Enable</th>
                      <th>Current pid</th>
                      <th>Last execution</th>
                      <th>Actions</th>
                  </tr>
              </thead>
              <tbody :key="">
                <tr v-for="scrapper in scrappers" :key="scrapper.id">
                    <td>
                      <update-modal
                        v-bind:scrapper-id="scrapper.id"
                        v-bind:scrapper-name="scrapper.name"
                        v-bind:scrapper-path="scrapper.path"
                        v-bind:scrapper-enable="scrapper.enable"
                        v-on:setId="setId"
                        v-on:setName="setName"
                        v-on:setPath="setPath"
                        v-on:setEnable="setEnable"
                        v-on:setActiveLeagues="setActiveLeagues"
                        v-on:setActiveSeasons="setActiveSeasons"
                        v-on:updateScrapper="handleUpdate"
                      />
                    </td>
                    <td>{{scrapper.name}}</td>
                    <td>{{scrapper.path}}</td>
                    <td v-if="scrapper.in_execution == true"><span class="dot green"></span></td>
                    <td v-if="scrapper.in_execution == false"><span class="dot red"></span></td>
                    <td v-if="scrapper.enable == true"><span class="dot green"></span></td>
                    <td v-if="scrapper.enable == false"><span class="dot red"></span></td>
                    <td>{{scrapper.current_pid}}</td>
                    <td>{{ displayDateTime(scrapper.last_execution) }}</td>
                    <td>
                        <v-btn
                          depressed
                          class="btn-execute"
                          v-on:click="handleExecution(scrapper.path)"
                        >
                            Execute
                        </v-btn>
                        <v-btn
                          depressed
                          color="error"
                          v-on:click="stopExecution(scrapper.path)"
                        >
                            Stop
                        </v-btn>
                    </td>
                </tr>
              </tbody>
          </template>
      </v-simple-table>
    </template>
  </div>
  `
}
