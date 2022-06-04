Vue.component('filter-files', {
  data() {
    return {
      filterTeams: [],
      filterSeasons: [],
      activeSearch: '',
      activeTeam: '',
      activeSeason: ''
    }
  },
  mounted: function() {
    this.getFilters();
  },
  methods: {
    async getFilters() {
      let teams = [];
      let players = [];
      let seasons =[];

      await axios.get(variables.API_URL + 'fapi/files')
        .then(r => {
          teams = this.sortResult(r.data, 'team');
          players = this.sortResult(r.data, 'player');
          seasons = this.sortResult(r.data, 'season');
        })
      this.filterTeams = teams;
      this.filterPlayers = players;
      this.filterSeasons = seasons;
    },
    sortResult(data, type) {
      let known = []
      let filters = []

      for(const item of data) {
        if(!(known.includes(item[type]))) {
          filters.push(item[type]);
          known.push(item[type]);
        }
      }
      return filters
    },
    handleFilter() {
      if(this.activeSearch || this.activeTeam || this.activeSeason) {
        this.$emit("filterFiles", {search: this.activeSearch, team: this.activeTeam, season: this.activeSeason});
      }
    },
    resetFilter() {
      this.activeSearch = '';
      this.activeTeam = '';
      this.activeSeason = '';
      this.$emit("setFilter");
    }
  },
  template: `
    <div class="filter-component">
        <template>
            <v-row align="center">
              <v-col
                class="d-flex"
                cols="12"
                sm="4"
              >
                <v-text-field label="Rechercher" v-on:keyup.enter="handleFilter" v-model="activeSearch" color="#44b88b"></v-text-field>
              </v-col>
              <v-col
                class="d-flex"
                cols="12"
                sm="3"
              >
                <v-select
                  :items="filterTeams"
                  label="Teams"
                  v-model="activeTeam"
                  color="#44b88b"
                ></v-select>
              </v-col>
              <v-col
                class="d-flex"
                cols="12"
                sm="3"
              >
                <v-select
                  :items="filterSeasons"
                  label="Seasons"
                  v-model="activeSeason"
                  color="#44b88b"
                ></v-select>
              </v-col>
              <v-col
                class="d-flex filter-actions"
                cols="12"
                sm="2"
              >
                <v-btn
                  class="btn-execute"
                  depressed
                  v-on:click="handleFilter"
                >Filtrer</v-btn>
                <v-btn
                  depressed
                  color="error"
                  v-on:click="resetFilter"
                >Reset</v-btn>
              </v-col>
            </v-row>
      </template>
    </div>
  `
})
