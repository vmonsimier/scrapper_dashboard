Vue.component('scrappers-table', {
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
          axios.get(variables.API_URL + 'fapi/scrappers', {
            headers: {
              'Access-Control-Allow-Origin': "*"
            }
        })
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
        
      </div>
      `
})