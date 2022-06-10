Vue.component('scrapper-logs', {
  data() {
    return {
      errors: [],
      logs: [],
      tab: 0
    }
  },
  methods: {
    getLogs() {
      axios.get(variables.API_URL + 'fapi/scrapper_logs')
        .then(response => {
          let errors = [];
          let logs = [];

          for (const item of response.data) {
            if (item.type === 'error') {
              errors.push(item);
            } else {
              logs.push(item);
            }
          }

          errors.sort(function compare(a, b) {
            if (a.id > b.id) {
              return -1
            } else if (a.id < b.id) {
              return 1
            }
            return 0
          })

          logs.sort(function compare(a, b) {
            if (a.id > b.id) {
              return -1
            } else if (a.id < b.id) {
              return 1
            }
            return 0
          })

          this.errors = errors.slice(0, 20);
          this.logs = logs.slice(0, 20);
        })
    },
    displayDate(date) {
      let d = date.split('T')[0];
      let t = date.split('T')[1].slice(0, 8)

      return d + ' ' + t;
    }
  },
  mounted: function () {
    this.getLogs();
  },
  template: `
    <div id="scrapper-logs">
      <template>
        <h1>Scrapper logs</h1>
        <div class="tab-logs">
          <template>
            <v-tabs v-model="tab">
              <v-tab>Errors</v-tab>
              <v-tab>Logs</v-tab>
            </v-tabs>
          </template>
        </div>
        <v-simple-table class="table-logs" v-if="tab === 0">
          <template v-slot:default>
              <thead>
                  <tr>
                    <th>id</th>
                    <th>Scrapper id</th>
                    <th>Type</th>
                    <th>Message</th>
                    <th>Date</th>
                  </tr>
              </thead>
              <tbody>
                <tr v-for="error in errors" :key="error.id">
                  <td>{{error.id}}</td>
                  <td>{{error.scrapper_id}}</td>
                  <td><v-chip color="red">{{error.type}}</v-chip></td>
                  <td>{{error.text}}</td>
                  <td>{{displayDate(error.date)}}</td>
                </tr>
              </tbody>
          </template>
      </v-simple-table>
      <v-simple-table class="table-logs" v-if="tab === 1">
        <template v-slot:default>
            <thead>
                <tr>
                  <th>id</th>
                  <th>Scrapper id</th>
                  <th>Type</th>
                  <th>Message</th>
                  <th>Date</th>
                </tr>
            </thead>
            <tbody>
              <tr v-for="log in logs" :key="log.id">
                <td>{{log.id}}</td>
                <td>{{log.scrapper_id}}</td>
                <td><v-chip color="green">{{log.type}}</v-chip></td>
                <td>{{log.text}}</td>
                <td>{{displayDate(log.date)}}</td>
              </tr>
            </tbody>
        </template>
    </v-simple-table>
    </template>
    </div>
  `
})
