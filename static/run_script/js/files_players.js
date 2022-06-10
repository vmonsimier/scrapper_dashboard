const files_players = {
  data() {
    return {
      page: 1,
      files: [],
      filesP: [],
      activeFilter: false,
      filtered: []
    }
  },
  methods: {
    getFiles() {
      axios.get(variables.API_URL + 'fapi/files')
        .then(async response => {
          let filesP = this.paginateFiles(response.data, 25);
          this.files = response.data;
          this.filesP = filesP;
        })
    },
    filterFiles(filterParams) {
      let files = this.files;
      let filtered = [];

      if (filterParams.search || filterParams.team || filterParams.season) {
        // Si search || team || season
        if (filterParams.search && filterParams.team && filterParams.season) {
          // Si search && team && season
          filtered = files.filter(item =>
            item.path.toLowerCase().includes(filterParams.search.toLowerCase()) &&
            item.season == filterParams.season &&
            item.team == filterParams.team
          )
        } else if (filterParams.search && filterParams.team) {
          // Si search && teams
          filtered = files.filter(item =>
            item.path.toLowerCase().includes(filterParams.search.toLowerCase())
            && item.team == filterParams.team
          )
        } else if (filterParams.search && filterParams.season) {
          // Si search && season
          filtered = files.filter(item =>
            item.path.toLowerCase().includes(filterParams.search.toLowerCase())
            && item.season == filterParams.season
          )
        } else if (filterParams.team && filterParams.season) {
          // Si team && season
          filtered = files.filter(item =>
            item.season == filterParams.season && item.team == filterParams.team
          )
        } else {
          // SINON
          if (filterParams.search) {
            // Si search
            filtered = files.filter(item =>
              item.path.toLowerCase().includes(filterParams.search.toLowerCase())
            )
          } else if (filterParams.team) {
            // Si team
            filtered = files.filter(item =>
              item.team == filterParams.team
            )
          } else if (season) {
            // Si season
            filtered = files.filter(item =>
              item.season == filterParams.season
            )
          }
        }
        this.filtered = this.paginateFiles(filtered);
        this.activeFilter = true;
        this.page = 1;
      }

      return -1;
    },
    paginateFiles(files, numberPage = 25) {
      let filesP = {};
      let nPages = Math.floor(files.length / numberPage) + 1;
      let num = 1;

      for (let i = 0; i < files.length; i += numberPage) {
        filesP[num.toString()] = [];
        for (let j = i; j < i + numberPage; j++) {
          if (files[j]) {
            filesP[num].push(files[j]);
          }
        }
        num += 1;
      }
      return filesP
    },
    displayDate(date) {
      let d = date.split('T')[0];
      let t = date.split('T')[1].slice(0, 8);

      return d + ' ' + t;
    },
    setFilter() {
      this.activeFilter = false;
      this.page = 1;
    }
  },
  mounted: function () {
    this.getFiles();
  },
  template: `
  <div id="files-table-template">
    <template>
        <h1>Files</h1>
        <filter-files-players
          @filterFiles="filterFiles"
          @setFilter="setFilter"
        />
        <v-simple-table class="table-files">
          <template v-slot:default>
              <thead>
                  <tr>
                    <th>id</th>
                    <th>Path</th>
                    <th>Player</th>
                    <th>Team</th>
                    <th>Season</th>
                    <th>League</th>
                    <th>DateIns</th>
                  </tr>
              </thead>
              <tbody>
                <tr v-for="file in filesP[page]" :key="file.id" v-if="activeFilter === false">
                  <td>{{file.id}}</td>
                  <td>{{file.path}}</td>
                  <td>{{file.player}}</td>
                  <td>{{file.team}}</td>
                  <td>{{file.season}}</td>
                  <td>{{file.league}}</td>
                  <td>{{displayDate(file.dateIns)}}</td>
                </tr>
                <tr v-for="file in filtered[page]" :key="file.id" v-if="activeFilter">
                  <td>{{file.id}}</td>
                  <td>{{file.path}}</td>
                  <td>{{file.player}}</td>
                  <td>{{file.team}}</td>
                  <td>{{file.season}}</td>
                  <td>{{file.league}}</td>
                  <td>{{displayDate(file.dateIns)}}</td>
                </tr>
              </tbody>
          </template>
      </v-simple-table>
    </template>
    <template>
      <div class="text-center">
        <v-pagination
          v-model="page"
          :length="Object.keys(filesP).length"
          v-if="activeFilter == false"
          circle
        ></v-pagination>
        <v-pagination
          v-model="page"
          :length="Object.keys(filtered).length"
          v-if="activeFilter"
          circle
        ></v-pagination>
      </div>
    </template>
  </div>
  `
}
