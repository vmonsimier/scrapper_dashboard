Vue.component('update-scrapper-modal', {
  data() {
      return{
        dialog: false,
        id: this.scrapperId,
        name: this.scrapperName,
        path: this.scrapperPath,
        enable: this.scrapperEnable,
        leagues: [],
        seasons: [],
        selectedLeagues: [],
        selectedSeasons: [],
      }
  },
  // props: {
  //   scrapperId: {
  //     type: String, // not 'string'
  //     required: true
  //   },
  //   scrapperName: {
  //     type: String, // not 'number'
  //     required: true,
  //   },
  //   scrapperPath: {
  //     type: String,
  //     required: true
  //   },
  //   scrapperEnable: {
  //     type: String,
  //     required: true
  //   }
  // },
  props: ['scrapperId', 'scrapperName', 'scrapperPath', 'scrapperEnable'],
  methods: {
    handleUpdate: async function(path) {
      this.dialog = false;
      this.$emit('setId', this.id);
      this.$emit('setName', this.name);
      this.$emit('setPath', this.path);
      this.$emit('setEnable', this.enable);
      this.$emit('setActiveLeagues', this.selectedLeagues);
      this.$emit('setActiveSeasons', this.selectedSeasons);
      this.$emit('updateScrapper');
    },
    getFbrefLinks: async function() {
      axios.get(variables.API_URL + 'api/fbref_links')
        .then(response => {
            let seasons = []
            let leagues = []

            for(const item of response.data) {
              if(!seasons.includes(item.season)) {
                seasons.push(item.season);
              }
              if (!leagues.includes(item.league)) {
                leagues.push(item.league);
              }
            }

            this.seasons = seasons;
            this.leagues = leagues;
        })
    },
    getActiveLinks: async function() {
      axios.get(variables.API_URL + 'api/scrapper_active_links')
        .then(response => {
          let seasons = []
          let leagues = []

          for(const item of response.data) {
            if(!seasons.includes(item.season)) {
              seasons.push(item.season);
            }
            if (!leagues.includes(item.league)) {
              leagues.push(item.league);
            }
          }

          this.selectedSeasons = seasons;
          this.selectedLeagues = leagues;
        })
    }
  },
  mounted: function() {
    this.getActiveLinks();
    this.getFbrefLinks();
  },
  template: `
   <v-dialog
      v-model="dialog"
      persistent
      max-width="800"
    >
      <template v-slot:activator="{ on, attrs }">
          <img
            v-bind="attrs"
            v-on="on"
            class="modify"
            src="/static/run_script/img/edit.png" >
      </template>
      <v-card>
        <v-card-title class="text-h5 title-modal">
          Modifier {{ scrapperName }}
        </v-card-title>
        <v-card-text>
          <v-form ref="form">
            <label>Enable</label>
            <v-switch
              v-model="enable"
            ></v-switch>
            <label>Name</label>
            <v-text-field
              v-model="name"
            >
            </v-text-field>
            <label>Path</label>
            <v-text-field
              v-model="path"
            >
            </v-text-field>
            <v-row>
              <v-col
                cols="12"
                sm="6"
              >
                <label>Ligues actives</label>
                <v-combobox
                  v-model="selectedLeagues"
                  :items="leagues"
                  multiple
                  dense
                ></v-combobox>
              </v-col>

              <v-col
                cols="12"
                sm="6"
              >
                <label>Saisons actives</label>
                <v-combobox
                  v-model="selectedSeasons"
                  :items="seasons"
                  multiple
                  dense
                ></v-combobox>
              </v-col>
            </v-row>
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            depressed
            class="btn-execute"
            @click="handleUpdate"
          >
            Enregistrer
          </v-btn>
          <v-btn
            depressed
            color="error"
            @click="dialog = false"
          >
            Quitter sans sauvegarder
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>`
})
